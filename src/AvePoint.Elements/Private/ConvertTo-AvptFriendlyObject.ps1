function ConvertTo-AvptFriendlyObject {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [object] $InputObject,

        [Parameter(Mandatory)]
        [string] $TypeName,

        [hashtable] $EnumMap
    )

    $properties = [ordered]@{}
    foreach ($property in $InputObject.PSObject.Properties) {
        $properties[$property.Name] = $property.Value
    }

    if ($EnumMap) {
        foreach ($key in $EnumMap.Keys) {
            if ($properties.Contains($key)) {
                $friendlyName = '{0}Name' -f $key
                $map = $EnumMap[$key]
                $properties[$friendlyName] = if ($map.ContainsKey([int] $properties[$key])) { $map[[int] $properties[$key]] } else { 'Unknown' }
            }
        }
    }

    $object = [pscustomobject] $properties
    $object.PSObject.TypeNames.Insert(0, $TypeName)
    $object
}

