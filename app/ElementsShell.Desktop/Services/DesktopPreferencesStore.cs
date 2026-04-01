using System;
using System.IO;
using System.Text.Json;
using ElementsShell.Desktop.Models;

namespace ElementsShell.Desktop.Services;

public sealed class DesktopPreferencesStore
{
    private static readonly JsonSerializerOptions JsonOptions = new()
    {
        WriteIndented = true
    };

    private readonly string _settingsPath;

    public DesktopPreferencesStore()
    {
        var appDataRoot = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
        var settingsDirectory = Path.Combine(appDataRoot, "ElementsShellDesktop");
        Directory.CreateDirectory(settingsDirectory);
        _settingsPath = Path.Combine(settingsDirectory, "preferences.json");
    }

    public DesktopPreferences Load()
    {
        try
        {
            if (!File.Exists(_settingsPath))
            {
                return new DesktopPreferences();
            }

            var json = File.ReadAllText(_settingsPath);
            return JsonSerializer.Deserialize<DesktopPreferences>(json) ?? new DesktopPreferences();
        }
        catch
        {
            return new DesktopPreferences();
        }
    }

    public void Save(DesktopPreferences preferences)
    {
        var json = JsonSerializer.Serialize(preferences, JsonOptions);
        File.WriteAllText(_settingsPath, json);
    }
}
