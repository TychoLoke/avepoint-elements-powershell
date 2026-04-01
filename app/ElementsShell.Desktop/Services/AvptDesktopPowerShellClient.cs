using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
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

    public AvptDesktopPowerShellClient()
    {
        _modulePath = ResolveModulePath();
    }

    public Task<ConnectionResult> ConnectAsync(DesktopConnectionSettings settings, CancellationToken cancellationToken = default)
    {
        var script = BuildConnectionScript(settings, "$result = Connect-AvptElements @connectSplat -PassThru");
        return InvokeObjectAsync<ConnectionResult>(script, cancellationToken);
    }

    public Task<IReadOnlyList<CustomerRecord>> GetCustomersAsync(DesktopConnectionSettings settings, CancellationToken cancellationToken = default)
    {
        var script = BuildConnectionScript(settings, @"
$result = @(
    Get-AvptCustomer -All |
        Select-Object id, organization, ownerEmail, countryOrRegion, jobStatusName, managementModeName, tenantCount, tenantNames
)
");
        return InvokeArrayAsync<CustomerRecord>(script, cancellationToken);
    }

    public Task<CustomerSummaryResult> GetCustomerSummaryAsync(DesktopConnectionSettings settings, string customerId, CancellationToken cancellationToken = default)
    {
        var script = BuildConnectionScript(settings, $@"
$result = Get-AvptCustomerSummary -CustomerId '{EscapePowerShell(customerId)}' |
    Select-Object customerId, organization, ownerEmail, countryOrRegion, managementMode, tenantCount, tenantNames, productCount, serviceNames, backupModuleCount, protectedObjectCount, scannedObjectCount, avePointStorageGb
");
        return InvokeObjectAsync<CustomerSummaryResult>(script, cancellationToken);
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

    private async Task<T> InvokeObjectAsync<T>(string script, CancellationToken cancellationToken)
    {
        var json = await InvokeScriptAsync(script, cancellationToken).ConfigureAwait(false);
        var result = JsonSerializer.Deserialize<T>(json, JsonOptions);
        return result ?? throw new InvalidOperationException("The PowerShell command returned no data.");
    }

    private async Task<IReadOnlyList<T>> InvokeArrayAsync<T>(string script, CancellationToken cancellationToken)
    {
        var json = await InvokeScriptAsync(script, cancellationToken).ConfigureAwait(false);

        if (string.IsNullOrWhiteSpace(json) || string.Equals(json.Trim(), "null", StringComparison.OrdinalIgnoreCase)) {
            return Array.Empty<T>();
        }

        var trimmed = json.TrimStart();
        if (trimmed.StartsWith("[", StringComparison.Ordinal)) {
            var items = JsonSerializer.Deserialize<List<T>>(json, JsonOptions);
            if (items is null) {
                return Array.Empty<T>();
            }

            return items;
        }

        var single = JsonSerializer.Deserialize<T>(json, JsonOptions);
        return single is null ? Array.Empty<T>() : new[] { single };
    }

    private async Task<string> InvokeScriptAsync(string script, CancellationToken cancellationToken)
    {
        using var process = new Process
        {
            StartInfo = new ProcessStartInfo
            {
                FileName = "pwsh",
                Arguments = $"-NoLogo -NoProfile -EncodedCommand {EncodeScript(script)}",
                RedirectStandardError = true,
                RedirectStandardOutput = true,
                UseShellExecute = false,
                CreateNoWindow = true
            }
        };

        if (!process.Start()) {
            throw new InvalidOperationException("Failed to start pwsh.");
        }

        using var registration = cancellationToken.Register(() =>
        {
            try {
                if (!process.HasExited) {
                    process.Kill(entireProcessTree: true);
                }
            }
            catch {
            }
        });

        var standardOutput = process.StandardOutput.ReadToEndAsync(cancellationToken);
        var standardError = process.StandardError.ReadToEndAsync(cancellationToken);
        await process.WaitForExitAsync(cancellationToken).ConfigureAwait(false);

        var output = await standardOutput.ConfigureAwait(false);
        var error = await standardError.ConfigureAwait(false);

        if (process.ExitCode != 0) {
            throw new InvalidOperationException(string.IsNullOrWhiteSpace(error) ? "PowerShell invocation failed." : error.Trim());
        }

        return output.Trim();
    }

    private static string EncodeScript(string script)
    {
        return Convert.ToBase64String(Encoding.Unicode.GetBytes(script));
    }

    private static string ResolveModulePath()
    {
        var candidates = new[]
        {
            Path.Combine(AppContext.BaseDirectory, "EmbeddedModule", "AvePoint.Elements", "AvePoint.Elements.psd1"),
            Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, "..", "..", "..", "..", "src", "AvePoint.Elements", "AvePoint.Elements.psd1"))
        };

        foreach (var candidate in candidates) {
            if (File.Exists(candidate)) {
                return candidate;
            }
        }

        throw new FileNotFoundException("Could not locate the embedded AvePoint.Elements module for the desktop app.");
    }
}
