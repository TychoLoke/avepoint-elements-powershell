using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Management.Automation;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using ElementsShell.Desktop.Models;

namespace ElementsShell.Desktop.Services;

public sealed class AvptDesktopPowerShellClient
{
    private static readonly JsonSerializerOptions JsonOptions = new()
    {
        PropertyNameCaseInsensitive = true
    };

    private readonly string _modulePath;
    private readonly string _diagnosticLogPath;

    public AvptDesktopPowerShellClient()
    {
        _modulePath = ResolveModulePath();
        _diagnosticLogPath = ResolveDiagnosticLogPath();
    }

    public IReadOnlyList<DependencyCheckItem> GetDependencyChecks()
    {
        var checks = new List<DependencyCheckItem>
        {
            new()
            {
                Name = ".NET Runtime",
                Status = "Ready",
                Detail = $".NET {Environment.Version} is running the desktop host."
            },
            new()
            {
                Name = "Embedded Module",
                Status = File.Exists(_modulePath) ? "Ready" : "Missing",
                Detail = _modulePath
            }
        };

        try
        {
            using var powerShell = PowerShell.Create();
            checks.Add(new DependencyCheckItem
            {
                Name = "PowerShell Engine",
                Status = "Ready",
                Detail = $"Hosted in-process via {typeof(PowerShell).Assembly.GetName().Name}."
            });
        }
        catch (Exception ex)
        {
            checks.Add(new DependencyCheckItem
            {
                Name = "PowerShell Engine",
                Status = "Error",
                Detail = ex.Message
            });
        }

        return checks;
    }

    public Task<ConnectionResult> ConnectAsync(DesktopConnectionSettings settings, CancellationToken cancellationToken = default)
    {
        var script = BuildConnectionScript(settings, "$result = Connect-AvptElements @connectSplat -PassThru");
        return InvokeObjectAsync<ConnectionResult>("Connect", script, cancellationToken);
    }

    public Task<IReadOnlyList<CustomerRecord>> GetCustomersAsync(DesktopConnectionSettings settings, CancellationToken cancellationToken = default)
    {
        var script = BuildConnectionScript(settings, @"
$result = @(
    Get-AvptCustomer -All |
        Select-Object id, organization, ownerEmail, countryOrRegion, jobStatusName, managementModeName, tenantCount, tenantNames
)
");
        return InvokeArrayAsync<CustomerRecord>("GetCustomers", script, cancellationToken);
    }

    public Task<CustomerSummaryResult> GetCustomerSummaryAsync(DesktopConnectionSettings settings, string customerId, CancellationToken cancellationToken = default)
    {
        var script = BuildConnectionScript(settings, $@"
$result = Get-AvptCustomerSummary -CustomerId '{EscapePowerShell(customerId)}' |
    Select-Object customerId, organization, ownerEmail, countryOrRegion, managementMode, tenantCount, tenantNames, productCount, serviceNames, backupModuleCount, protectedObjectCount, scannedObjectCount, avePointStorageGb
");
        return InvokeObjectAsync<CustomerSummaryResult>("GetCustomerSummary", script, cancellationToken);
    }

    private static string EscapePowerShell(string value)
    {
        return value.Replace("'", "''", StringComparison.Ordinal);
    }

    private string BuildConnectionScript(DesktopConnectionSettings settings, string resultScript)
    {
        var bundleExpression = string.Join(", ", settings.ScopeBundles.Select(bundle => $"'{EscapePowerShell(bundle)}'"));
        return $@"
$ErrorActionPreference = 'Stop'
Import-Module '{EscapePowerShell(_modulePath)}' -Force
$secret = ConvertTo-SecureString '{EscapePowerShell(settings.ClientSecret)}' -AsPlainText -Force
$credential = [pscredential]::new('{EscapePowerShell(settings.ClientId)}', $secret)
$connectSplat = @{{
    Environment = '{EscapePowerShell(settings.Environment)}'
    Credential = $credential
    ScopeBundle = @({bundleExpression})
}}
if ('{EscapePowerShell(settings.TenantLabel)}') {{
    $connectSplat.TenantName = '{EscapePowerShell(settings.TenantLabel)}'
}}
{resultScript}
$result | ConvertTo-Json -Depth 8
";
    }

    public string GetDiagnosticLogPath()
    {
        return _diagnosticLogPath;
    }

    private async Task<T> InvokeObjectAsync<T>(string operationName, string script, CancellationToken cancellationToken)
    {
        var json = await InvokeScriptAsync(operationName, script, cancellationToken).ConfigureAwait(false);
        var result = JsonSerializer.Deserialize<T>(json, JsonOptions);
        return result ?? throw new InvalidOperationException("The PowerShell command returned no data.");
    }

    private async Task<IReadOnlyList<T>> InvokeArrayAsync<T>(string operationName, string script, CancellationToken cancellationToken)
    {
        var json = await InvokeScriptAsync(operationName, script, cancellationToken).ConfigureAwait(false);

        if (string.IsNullOrWhiteSpace(json) || string.Equals(json.Trim(), "null", StringComparison.OrdinalIgnoreCase))
        {
            return Array.Empty<T>();
        }

        var trimmed = json.TrimStart();
        if (trimmed.StartsWith("[", StringComparison.Ordinal))
        {
            var items = JsonSerializer.Deserialize<List<T>>(json, JsonOptions);
            if (items is null)
            {
                return Array.Empty<T>();
            }

            return items;
        }

        var single = JsonSerializer.Deserialize<T>(json, JsonOptions);
        return single is null ? Array.Empty<T>() : new[] { single };
    }

    private Task<string> InvokeScriptAsync(string operationName, string script, CancellationToken cancellationToken)
    {
        return Task.Run(() =>
        {
            try
            {
                cancellationToken.ThrowIfCancellationRequested();

                using var powerShell = PowerShell.Create();
                powerShell.AddScript(script);

                var output = powerShell.Invoke();

                if (powerShell.HadErrors)
                {
                    var errors = string.Join(Environment.NewLine, powerShell.Streams.Error.Select(error => error.ToString()));
                    var message = string.IsNullOrWhiteSpace(errors) ? "PowerShell invocation failed." : errors.Trim();
                    WriteDiagnostic(operationName, "Error", message);
                    throw new InvalidOperationException(message);
                }

                var rendered = string.Join(Environment.NewLine, output.Select(item => item?.ToString()).Where(item => !string.IsNullOrWhiteSpace(item)));
                WriteDiagnostic(operationName, "Success", "PowerShell invocation completed.");
                return rendered.Trim();
            }
            catch (Exception ex)
            {
                WriteDiagnostic(operationName, "Exception", ex.Message);
                throw;
            }
        }, cancellationToken);
    }

    private static string ResolveModulePath()
    {
        var candidates = new[]
        {
            Path.Combine(AppContext.BaseDirectory, "EmbeddedModule", "AvePoint.Elements", "AvePoint.Elements.psd1"),
            Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, "..", "..", "..", "..", "src", "AvePoint.Elements", "AvePoint.Elements.psd1"))
        };

        foreach (var candidate in candidates)
        {
            if (File.Exists(candidate))
            {
                return candidate;
            }
        }

        throw new FileNotFoundException("Could not locate the embedded AvePoint.Elements module for the desktop app.");
    }

    private static string ResolveDiagnosticLogPath()
    {
        var baseDirectory = Path.Combine(
            Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData),
            "ElementsShell",
            "Logs");

        Directory.CreateDirectory(baseDirectory);
        return Path.Combine(baseDirectory, "desktop-host.log");
    }

    private void WriteDiagnostic(string operationName, string category, string message)
    {
        var line = $"[{DateTimeOffset.UtcNow:O}] [{category}] [{operationName}] {message}{Environment.NewLine}";
        File.AppendAllText(_diagnosticLogPath, line);
    }
}
