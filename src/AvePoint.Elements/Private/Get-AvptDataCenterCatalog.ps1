function Get-AvptDataCenterCatalog {
    [CmdletBinding()]
    param(
        [string] $Environment
    )

    $targetEnvironment = if ($Environment) {
        $Environment
    }
    else {
        $state = Get-AvptModuleState
        if ($state.Connection) { $state.Connection.Environment } else { 'Commercial' }
    }

    $catalog = @(
        [pscustomobject]@{ Environment = 'Commercial'; DataCenterId = '0b635b49-4c56-4e52-800a-1fa79b2d5b08'; Name = 'Australia Southeast'; Region = 'Victoria' }
        [pscustomobject]@{ Environment = 'Commercial'; DataCenterId = '7b9835ec-7299-4177-85e3-ba5cb3b2e041'; Name = 'Canada Central'; Region = 'Toronto' }
        [pscustomobject]@{ Environment = 'Commercial'; DataCenterId = 'e44bb3ed-f1d8-4055-8c77-c8fd8cd63409'; Name = 'East US'; Region = 'Virginia' }
        [pscustomobject]@{ Environment = 'Commercial'; DataCenterId = '49681f94-26a7-4825-aca2-df2eca7c0f81'; Name = 'France Central'; Region = 'Paris' }
        [pscustomobject]@{ Environment = 'Commercial'; DataCenterId = 'ab2faf29-9e66-45ce-bf37-32f8cf484fb2'; Name = 'GCP Australia Southeast'; Region = 'Sydney' }
        [pscustomobject]@{ Environment = 'Commercial'; DataCenterId = '7bd9748b-b52b-4e4d-9389-e70dccee3b2d'; Name = 'GCP East US'; Region = 'Moncks Corner' }
        [pscustomobject]@{ Environment = 'Commercial'; DataCenterId = '4f77581e-1a6f-47fd-9f68-9134a4f6989b'; Name = 'GCP Japan'; Region = 'Tokyo' }
        [pscustomobject]@{ Environment = 'Commercial'; DataCenterId = '8998f218-708f-4084-8647-32ed67042487'; Name = 'GCP South Korea'; Region = 'Seoul' }
        [pscustomobject]@{ Environment = 'Commercial'; DataCenterId = 'e38cb1b7-efa9-490e-ab46-83b45a94d1da'; Name = 'GCP West Europe'; Region = 'Eemshaven, Netherlands' }
        [pscustomobject]@{ Environment = 'Commercial'; DataCenterId = '3225f6f8-a98c-425e-8279-c6696d99659d'; Name = 'Germany West Central'; Region = 'Frankfurt' }
        [pscustomobject]@{ Environment = 'Commercial'; DataCenterId = 'ca577c72-83bd-454c-af62-da3d0586691d'; Name = 'Japan West'; Region = 'Osaka' }
        [pscustomobject]@{ Environment = 'Commercial'; DataCenterId = 'e4f66389-8219-4432-9af1-01a9fe62a640'; Name = 'Korea Central'; Region = 'Seoul' }
        [pscustomobject]@{ Environment = 'Commercial'; DataCenterId = 'f1cdd2b2-ac32-4509-8784-fb2b947ef519'; Name = 'North Europe'; Region = 'Ireland' }
        [pscustomobject]@{ Environment = 'Commercial'; DataCenterId = '0d4a9846-97ad-4c09-bb1c-8fbe93eaf3c6'; Name = 'Southeast Asia'; Region = 'Singapore' }
        [pscustomobject]@{ Environment = 'Commercial'; DataCenterId = 'f8ccd75d-d979-417c-96ee-ae256a3af091'; Name = 'Switzerland North'; Region = 'Zurich' }
        [pscustomobject]@{ Environment = 'Commercial'; DataCenterId = 'd95b9c82-a426-400f-8256-70646fdd1b4f'; Name = 'UK South'; Region = 'London' }
        [pscustomobject]@{ Environment = 'Commercial'; DataCenterId = '4f93bdff-9b11-47b9-aa68-a86bfa09f61c'; Name = 'West Europe'; Region = 'Netherlands' }
        [pscustomobject]@{ Environment = 'Government'; DataCenterId = 'd9210f50-bdb1-4f8f-a2bb-99694d11f2da'; Name = 'US Gov Virginia'; Region = 'Virginia' }
    )

    @($catalog | Where-Object Environment -eq $targetEnvironment)
}
