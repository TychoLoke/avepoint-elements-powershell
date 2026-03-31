function ConvertTo-AvptNestedObject {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [object] $InputObject,

        [Parameter(Mandatory)]
        [string] $TypeName
    )

    $properties = [ordered]@{}
    foreach ($property in $InputObject.PSObject.Properties) {
        $properties[$property.Name] = $property.Value
    }

    $object = [pscustomobject] $properties
    $object.PSObject.TypeNames.Insert(0, $TypeName)
    $object
}
