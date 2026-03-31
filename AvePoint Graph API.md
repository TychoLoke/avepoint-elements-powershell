

Table of Contents
Explore Elements API3
## Get Started5
Register an App8
## Change Log16
## Common Features
## Customers
## Retrieve All Customers20
Onboard a Customer24
## Service Subscriptions
Add a Service28
Retrieve All Services of Customers37
## Tenants
## Retrieve Customer Tenant User Seats42
Retrieve AvePoint Product Overview45
Retrieve User Protected Status for Customer48
## Jobs
Retrieve Cloud Backup for Microsoft 365 Overview52
## Retrieve Jobs55
## Retrieve Customer Scan Profiles62
## Retrieve Customer Scan Profile Details65
## Retrieve Daily Scan Profile Changes70
## Baseline Management
## Create Baseline74
## Retrieve Baseline Information77
## Retrieve Baseline Creation Job Report80
Retrieve Job Information from Process Center83
## Retrieve Tenant Information87
## Monitor Tenant91
## Risk Management
## Retrieve Matched Risk Rules94
## Retrieve Matched Objects98
## User Management
## Dashboard
Retrieve Information of Security Users112
## Users
Retrieve Information of a Specific User117
Retrieve Information of Multiple Users122
Update Information of a Specific User127

Update Birthday of a Specific User130
Update Contact Information of a Specific User132
Update Alternate Email Address of a Specific User134
Update General Information of a Specific User136
Update the Test User Property of a Specific User139
Update Manager of a Specific User141
Update Office Information of a Specific User143
Update Office Location Information of a Specific User145
Update the Password Setting of a Spceific User148
## Risky Users
## Retrieve Workflow Information150
## Retrieve Risky Action Count153
## Retrieve Compliance Information155
## Retrieve Sign-in Information159
## Workspace Management
## Retrieve Workspace Overview162
## Retrieve Workspace Compliance166
## Retrieve Data Security Posture168
## Retrieve Data Protection Statistics171

## 3 / 174
Explore Elements API
Unleash the full potential of customer management with AvePoint's Elements API. Designed
for seamless integration and robust performance, the API empower partners and
developers to manage, secure, and optimize cloud services with precision and ease.
## Comprehensive Partner Operations
Leverage our API to streamline partner-related workflows, enhance operational efficiency,
and improve collaboration. Automate processes, manage customers, and integrate
seamlessly with existing systems to deliver exceptional service and value.
Secure and Scalable
Built on a foundation of security and scalability, the Elements API ensures that your data
interactions are both safe and efficient. With advanced authentication and granular
permissions, you have precise control over access, ensuring sensitive information is always
protected. Our scalable infrastructure supports growing demands, providing consistent
performance as your needs evolve.
## Key Features
Common Features: Provide comprehensive capabilities for customer onboarding,
service management, subscription tracking, tenant resource monitoring, and backup
job reporting, which enable partners to streamline customer related operations and
enhance visibility into service usage.
Baseline Management: Create baselines from your golden tenants to establish
benchmarks for tenant configurations and apply baselines to tenants to monitor
configuration deviations.
Risk Management: Retrieve the matched risk rules of a specific tenant and view all
objects that violate a specific risk rule within a tenant.
User Management: Manage users in your customer's tenants, including retrieving
user inforamtion, updating user information, and retrieving risk and compliance details
of your customer's tenant.
Workspace Management: View workspace statistics for a specific tenant, including
workspace overview, workspace compliance statistics, data security posture, and data
protection statistics.
## Get Started Now!

## 4 / 174
Harness the power of Elements API to drive your business forward. With our cutting-edge
technology and expert support, you'll transform the way you manage customers, ensuring
seamless monitoring of backup protection and precise tracking of subscription usage.
Detect and adapt to Auto Discovery scan changes with unparalleled efficiency. Our
comprehensive resources, including in-depth documentation, coupled with expert support,
provide everything you need to embark on a successful integration journey today.

## 5 / 174
Use Elements API
In this article
Authentication and Authorization
Call an API Method
## Request Components
## Response Components
HTTP Methods
HTTP Status Code
## Resource
Welcome to the Elements API, your gateway to accessing and managing the Elements
Platform with efficiency and security. This API is designed to streamline your data
management and monitoring processes, providing IT professionals with robust tools and
insights.
Authentication and Authorization
To access the resources of Elements services via the Elements API, you must configure the
app registration and grant the necessary permissions. This process involves:
Registering an app: Set up your app in Elements.
Permissions: Assign the appropriate permissions for your app.
Authentication: Use the generated application (client) ID for secure access.
For a step-by-step guide on creating an app registration for API authentication, refer to
Register an App.
Call an API Method
To interact with resources, construct a request as follows:
## Request Components
{HTTP method} – The HTTP method used for the request.
{resource} – The referenced resource.
{query-parameters} – Optional parameters to customize the response.
## Response Components
After making a request, a response is returned that includes:
{HTTP method} https://graph.avepointonlineservices.com/{resource}?{query-parameters}

## 6 / 174
Status code – An HTTP status code that indicates success or failure.
Response message – The data that you requested or the result of the operation. The
response message can be empty for some operations.
nextLink – If your request returns a lot of data, you need to page through it by using the
URL returned in nextLink.
Response headers – Additional information about the response, such as the type of
content returned and the request-id that you can use to correlate the response to the
request.
HTTP Methods
The API uses the HTTP methods to specify the action being performed on a request.
Currently, the API documented here only supports:
MethodDescription
GETRead data from a resource.
POSTCreate data in a resource.
PUTUpdate data in a resource.
HTTP Status Code
HTTP status codes indicate the outcome of a request. Common codes include:
CodeDescription
200OK – The request was successful, and the response contains the requested data.
201Created – The request was successful and a new resource was created as a result.
204No Content – The request was successful, but the response body contains no
content.
400Bad Request – The request could not be processed due to invalid parameters.
401Unauthorized – The request requires user authentication.
403Forbidden – The server understood the request but refuses to authorize it.
404Not Found – The requested resource could not be found on the server.

## 7 / 174
CodeDescription
429Too Many Requests – The client has exceeded the rate limit defined by the server.
500Internal Server Error – An unexpected server error occurred.
503Service Unavailable – The server is temporarily unable to handle the request due
to maintenance or overload.
## Resource
A resource can be an entity or complex type, commonly defined with properties. Your URL
will include the resource you are interacting with in the request, such as customers, tenants,
and services. Methods can also be used to perform operations on these resources.

## 8 / 174
Register an App for API Access
Complete the following steps to register an app for the Elements API:
- Sign in to Elements with your account.
- Go to the Settings page and select API app registration in the Additional area.
- On the API app registration page, click Create app registration under the Public
API tab.
- In the Basic information step, enter a name for the app and select the corresponding
permissions that you need to grant to this app.
- In the Customer scope step, select All customers, Specific customers, or
Customer groups as the scope.
- In the Certificates and secrets step, configure the credentials. Credentials enable
applications to identify themselves to the authentication service when receiving tokens
at a web addressable location (using an HTTPS scheme). For a higher level of
assurance, we recommend using a certificate (instead of a client secret) as a
credential. Follow the instructions below to configure credentials:
Select the Certificate tab, and then click Upload certificate to upload a
certificate (.cer file). The certificate serves as credentials that allow your
application to authenticate itself, requiring no interaction from a user at runtime.
You can refer to Prepare a Certificate to prepare a certificate.
Select the Client secret tab, click Add client secret, set the effective duration to
1 year, 2 years, or 3 years, and then click Add to generate a client secret. Client
secret values cannot be entirely shown once they are saved. To get a client secret
value for later use, copy and save it upon creation.
- Click Save to save your configurations.
When you finish the registration, click the app name and you can copy the generated
Application (Client) ID on the App registration details page.
Prepare a Certificate
To prepare self-signed certificate files based on your scenario, choose one of the following
methods.
Use a Key Vault in Azure to Prepare Certificates
Before preparing a certificate with this method, make sure you have a key vault in Azure. If
you have an Azure subscription but do not have any key vaults, refer to the instructions
below to create a Key Vault in Azure.
Make sure you have an Azure subscription that contains Azure Key Vault. Then follow the
instructions below:

## 9 / 174
- Create an application. This application is only used for Azure Key Vault.
- In the Microsoft Entra admin center (or Microsoft Azure portal), navigate to Identity
> Applications > App registrations (or Microsoft Entra ID > App
registrations).
- Click New registration.
- On the Register an application page, configure the application settings.
- Click Register to create your application.
- After the application is created, copy the application ID.
- Add a client secret for the application.
- After creating the application, click Certificates & secrets in the left menu.
- In the Client secrets field, click New client secret.
- In the Add a client secret pane, enter a description for the client secret and
select a duration.
- Click Add. The value of the client secret is automatically generated and displayed.
- Copy the client secret value. You will need to provide the value when configuring
the encryption profile. Note that the value will be hidden after you leave or refresh
the page.
- Create a key vault.
- In the Microsoft Azure portal, enter Key vaults in the search box on the top, and
then select the first result to access the Key vaults page.
- Click Create. The Create a key vault page appears.
- In the Basics tab, provide the basic information for the key vault, and then click the
Access configuration tab.
- In the Access policies section, click Create.
- The Create an access policy pane appears. In the Permissions tab, select the
following Key permissions:
In the Key Management Operations field, select Get.
In the Cryptographic Operations field, select Decrypt and Encrypt.
- Click Next to go to the Principal tab.
- In the Principal pane, enter the application name or application ID in the
search box.
- Select the application and click Select at the bottom.
- Click Next at the bottom.
- Click Create to add the access policy.
- Click the Networking tab.
- Select Enable public access which allows all networks to connect to this key
vault.
- Click the Tags tab and you can add tags to categorize your key vault.
- Click Review + create to review all of your configurations first, and then click
Create at the bottom to create the key vault.

## 10 / 174
- Create a key.
- On the Key vaults page, click the newly created key vault.
- Click Keys in Settings. In the Keys pane, click Generate/Import and create a
key.
- In the Keys pane, click the key name, and then click the current version. The key
properties are displayed.
- Copy the key identifier. You will need to provide the key identifier when configuring
the encryption profile.
Then, refer to the steps below to prepare the certificate:
- In the Microsoft Azure portal, navigate to Key vaults.
- On the Key vaults page, select a key vault and then select Certificates in the left
menu.
- In the Certificates panel, click Generate/Import and complete the required fields.
The screenshot below is a sample certificate. (In the Content Type field, select PKCS
## #12)
- Click Create and wait for the Status of the certificate to become Enabled. You can
click Refresh to update the status if needed.
- Click the name of the certificate, and then select the current version of the certificate.
- Click Download in CER format and Download in PFX/PEM format to download the
certificate files to your local machine.
- When you have the certificate (.pfx file), you must set a password to protect the
certificate.
- Open Windows PowerShell and paste the following script. Replace [Full path to
your PFX] with the full path of the certificate (.pfx file) on your local machine. Note
that quotes are required when you enter the commands.
- Press Enter to execute the script.
## NOTE
If you need to change some settings before creating the key vault, you can click
the < Previous button to change previous settings.
## 
$pfxPath="[Full path to your PFX]"
Export-PfxCertificate -Password $(Read-Host -AsSecureString -Prompt "Enter a
password to protect the certificate") -PFXData $(Get-PfxData -FilePath
$pfxPath) -FilePath $pfxPath

## 11 / 174
Use Windows PowerShell to Prepare Certificates
To create a self-signed certificate using Windows PowerShell, refer to the following steps:
- Right-click Windows PowerShell on the machine and select Run as administrator
from the drop-down list.
- Use the New-SelfSignedCertificate cmdlet to generate certificate files. For example:
Press Enter on the keyboard.
- Export the .crt (or .cer) file by entering the following command:
Note the following:
If you want to export a .cer file, r eplace .crt with .cer in the cmdlet above.
The file will be saved to the current working directory of the PowerShell session. To
specify a different directory, use the full path, for example:
- Export the .pfx file with a password by entering the following command:
## NOTE
The .pfx file contains your private key.
## 
## NOTE
The steps below are based on running Windows PowerShell on a machine with the
Windows 10 or Windows 11 operating system.
## 
$cert = New-SelfSignedCertificate -Subject CN=AvePointCustomApp -
CertStoreLocation 'Cert:\CurrentUser\My' -NotAfter (Get-Date).AddMonths(60)
Export-Certificate -Cert $cert -FilePath AvePointCustomApp.crt
Export-Certificate -Cert $cert -FilePath "C:\\Temp\\AvePointCustomApp.crt"

## 12 / 174
Note the following:
The .pfx file contains your private key.
The file will be saved to the current working directory of the PowerShell session. To
specify a different directory, use the full path, for example:
Press Enter on the keyboard.
Get the Access Token
Based on the credentials of an app registration in Elements, refer to the following sections.
## Client Secret
If you want to get the access token with a client secret in an app registration, follow the
instructions below to send a POST request:
- Set the access token URL.
Choose the URL based on your organization's environment:
## Elements
EnvironmentAccess Token URL
## Commercialhttps://identity.avepointonlineservices.com/connect/token
U.S. Governmenthttps://identity-
gov.avepointonlineservices.com/connect/token
AOS2https://identity-
aos2.avepointonlineservices.com/connect/token
FedRAMP Cloud
(Project Hosts)
https://identity.online15.net/connect/token
Export-PfxCertificate -Password $(Read-Host -AsSecureString -
Prompt "Enter a password to protect the certificate") -Cert $cert -
FilePath AvePointCustomApp.pfx
Export-PfxCertificate -Password $(Read-Host -AsSecureString -Prompt "Enter a
password to protect the certificate") -Cert $cert -FilePath
"C:\\Temp\\AvePointCustomApp.pfx"

## 13 / 174
- Set the header to Content-Type: application/x-www-form-urlencoded.
- Set the following parameters in the request body:
client_id – Copy the Application (Client) ID value from the app registration details
page and paste the value here.
client_secret – Copy the Client Secret value that has been saved upon the creation
of the app registration, and paste the value here.
scope – Set the scope, which is the assigned permissions. Please ensure the
permissions have been configured in the app registration.
grant_type – Set this value to client_credentials.
- In the response:
The access_token node represents the token value.
The expires_in node represents how many seconds until the token expires.
The scope node lists the assigned permissions of the app registration.
## Certificate
Once you have the application (client) ID, get the access token via the application (client)
ID to authenticate with Elements API.
The following information is required to get an access token:
ElementDescription
## Identity
Service URL
https://identity.avepointonlineservices.com/connect/token
## Application
(Client) ID
The application (client) ID you have retrieved.
CertificateThe corresponding .pfx certificate file of the .cer certificate you used
when registering the app.
To get the access token using the above information, create a JSON web token using the
Client ID and certificate first, and then use the JSON web token to request an access token
of the defined scope from Identity Service.
Below is an example for getting the access token:

## 14 / 174
## NOTE
Adjust the identityServiceUrl based on your Elements environment.
## Elements
EnvironmentIdentity Service URL
## Commercialhttps://identity.avepointonlineservices.com/connect/token
U.S. Governmenthttps://identity-
gov.avepointonlineservices.com/connect/token
AOS2https://identity-
aos2.avepointonlineservices.com/connect/token
FedRAMP Cloud
(Project Hosts)
https://identity.online15.net/connect/token
## 
var identityServiceUrl = "
## {https://identity.avepointonlineservices.com/connect/token}";
var client = new HttpClient();
var disco = await client.GetDiscoveryDocumentAsync(identityServiceUrl);
if (disco.IsError)
## {
return;
## }
var tokenResponse = await client.RequestClientCredentialsTokenAsync(new
ClientCredentialsTokenRequest
## {
Address = disco.TokenEndpoint,
ClientAssertion = new ClientAssertion()
## {
Type = OidcConstants.ClientAssertionTypes.JwtBearer,
Value = CreateClientAuthJwt(disco)
## }
## });
if (tokenResponse.IsError)
## {
return;
## }
return tokenResponse.Json;

## 15 / 174
private static string CreateClientAuthJwt(DiscoveryDocumentResponse response)
## {
var clientId = "{Client ID}";
var certificateThumbprint = "{Certificate Thumbprint}";
// set exp to 5 minutes
var tokenHandler = new JwtSecurityTokenHandler { TokenLifetimeInMinutes = 60
## };
var securityToken = tokenHandler.CreateJwtSecurityToken(
// iss must be the client_id of our application
issuer: clientId,
// aud must be the identity provider (token endpoint)
audience: response.TokenEndpoint,
// sub must be the client_id of our application
subject: new ClaimsIdentity(
new List<Claim> { new Claim("sub", clientId),
new Claim("jti", Guid.NewGuid().ToString())}),
// sign with the private key (using RS256 for IdentityServer)
signingCredentials: new SigningCredentials(
new X509SecurityKey(new
X509Certificate2(LoadCertificate(certificateThumbprint))), "RS256")
## );
return tokenHandler.WriteToken(securityToken);
## }
private static X509Certificate2 LoadCertificate(string certificateThumbprint)
## {
var store = new X509Store(StoreName.My, StoreLocation.LocalMachine);
store.Open(OpenFlags.ReadOnly);
var vCloudCertificate = store.Certificates.Find(
X509FindType.FindByThumbprint,
certificateThumbprint,
false)[0];
return vCloudCertificate;
## }
## NOTE
The token you get will expire in one hour, and you need to get the token again after the
expiration.
## 

## 16 / 174
## Change Log
This document provides a detailed log of changes, updates, and enhancements made to
the Elements API. It includes information on newly introduced features, improvements to
existing functionalities, and any fixes applied. Stay up-to-date with the latest modifications
to ensure optimal integration and utilization of the API.
## December 2025
## Changed
Enhanced the /partner/external/v3/general/customers/{customerId}/cloud-backup-
m365/overview endpoint to support page pagination.
## October 2025
## Added
Introduced new endpoints for common features.
/partner/external/v3/general/customers/batch for retrieving the information of all
customers managed by the current partner.
/partner/external/v3/general/customers for onboarding a customer to the current
partner.
/partner/external/v3/general/customers/{customerId}/services for adding a service
for a customer.
/partner/external/v3/general/customers/services/batch for retrieving the services
of customers managed by the current partner.
/partner/external/v3/general/customers/{customerId}/3rd-party-
products/type/{type}/tenants/batch for retrieving the numbers of assigned and
available user seats of customer's tenant.
/partner/external/v3/general/customers/{customerId}/avpt-
products/type/{productType}/overview for retrieving the purchased user seats for
AvePoint products of the customer.
/partner/external/v3/general/customers/{customerId}/tenants/{tenantId}/cloud-
backup-m365/users/batch for retrieving the protected status of users in the
customer's tenant by Cloud Backup for Microsoft 365.
/partner/external/v3/general/customers/{customerId}/cloud-backup-m365/overview
for retrieving the customer's protected data information of Cloud Backup for
## Microsoft 365.
/partner/external/v3/general/customers/{customerId}/avpt-products/jobs/batch for
retrieving the job details of the backup services for a specific customer.

## 17 / 174
/partner/external/v3/general/customers/{customerId}/scan-profiles/batch for
retrieving all scan profiles configured for a specific customer in AvePoint Online
## Services.
/partner/external/v3/general/customers/{customerId}/scan-
profiles/{scanProfileId} for retrieving the details of a specific scan profile
configured in AvePoint Online Services for a customer.
/partner/external/v3/general/customers/{customerId}/scan-
profiles/{scanProfileId}/changes for retrieving the daily scan profile changes in
AvePoint Online Services for a customer.
Introduced new endpoints for baseline management.
/partner/external/v3/bm/baselines for creating a baseline from a tenant to establish
benchmarks for tenant configurations.
/partner/external/v3/bm/baselines/batch for retrieving the general information of
baselines.
/partner/external/v3/bm/baselines/{baselineId}/reports for retrieving the report
details of a baseline creation job.
/partner/external/v3/bm/customers/{customerId}/tenants/{tenantId}/process-
center/jobs/batch for retrieving job information from the Process center page.
/partner/external/v3/bm/tenants/batch for retrieving the general information of
tenants added to the Baseline Management module.
/partner/external/v3/bm/customers/{customerId}/tenants/{tenantId}/actions for
monitoring a tenant by performing specific actions to the tenant.
Introduced new endpoints for risk management.
/partner/external/v3/rm/customers/{customerId}/tenants/{tenantId}/detection/rule
s for retrieving all matched risk rules for a specific tenant.
/partner/external/v3/rm/customers/{customerId}/tenants/{tenantId}/detection/rule
s/{ruleId}/hit-items for retrieving the objects that violate a specific risk rule.
Introduced new endpoints for user management.
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/overview/secur
ity/users for retrieving information of security users in a customer's tenant.
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}
for retrieving information of a specific user in a customer's tenant.
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/batch for
retrieving information of multiple users in a customer's tenant.
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}
/account-information for updating information of a specific user in a customer's
tenant.
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}
/birthday for updating the birthday of a specific user in a customer's tenant.

## 18 / 174
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}
/contact-information for updating the contact information of a specific user in a
customer's tenant.
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}
/alternate-email-address for updating the alternate email address of a specific user
in a customer's tenant.
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}
/general-information for updating the general information of a specific user in a
customer's tenant.
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}
/istest for updating the test user property of a specific user in a customer's tenant.
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}
/manager for updating the manager of a specific user in a customer's tenant.
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}
/office for updating the office information of a specific user in a customer's tenant.
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}
/office-information for updating the office location information of a specific user in
a customer's tenant.
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}
/password-setting for updating the password setting of a specific user in a
customer's tenant.
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/overview/secur
ity/compliances/workflows for retrieving information of workflows in a customer's
tenant.
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/overview/secur
ity/compliances/actions for retrieving the risky action count in a customer's tenant.
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/overview/secur
ity/compliances/workflows/{workflowId} for retrieving compliance information of a
specific workflow in a customer's tenant.
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/overview/secur
ity/compliances/signins for retrieving users' sign-in information in a customer's
tenant.
Introduced new endpoints for workspace management.
/partner/external/wm/customers/{customerId}/tenants/{tenantId}/overview/workspac
e for retrieving the workspace overview statistics of a specific tenant.
/partner/external/wm/customers/{customerId}/tenants/{tenantId}/overview/data-
protection/compliance-rate for retrieving the compliance statistics of workspaces
for a specific tenant.
/partner/external/wm/customers/{customerId}/tenants/{tenantId}/overview/dspm/ins
ights for retrieving the data security posture statistics of a specific tenant.

## 19 / 174
/partner/external/wm/customers/{customerId}/tenants/{tenantId}/overview/data-
protection/ransomware-detection for retrieving the data protection statistics of a
specific tenant.

## 20 / 174
Retrieve All Customers Managed by Current
## Partner
Use this API to retrieve the information of all customers managed by the current partner.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPermission
## /partner/external/v3/general/customers/batchelements.customers.read.all
## Request
This section outlines the details of the HTTP method and endpoint used to retrieve
customers managed by the current partner.
MethodEndpointDescription
POST/partner/external/v3/general/customers/batchRetrieve customers managed
by the current partner.
## Query Parameters
This section outlines the parameters that allow users to specify pagination.
ParameterDescriptionTypeRequired
pageIndexThe starting number of the page to retrieve the
customers. The default value is 1.
integerNo
pageSizeThe number of objects to display on one page. The
default value is 50 and the maximum value allowed is
## 100.
integerNo
## Request Body Parameters
This section outlines the request body parameters required to specify the customers you
want to retrieve.

## 21 / 174
ParameterDescriptionTypeRequired
customerIdsThe ID of the customer to be retrieved.string[]No
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.
FieldDescriptionType
idThe ID of the customer.string
organizationThe organization name of the customer.string
ownerEmailThe email address of the customer.string
jobStatusThe status of the customer's tenant.
## 0 - N/A
## 1 - Working
## 2 - Failed
3 - Waiting for configuration
4 - Multiple issues found
5 - Finished with exception
6 - No backup updates
integer
countryOrRegionThe country or region of the customer.string
managementModeThe management mode of the customer.
0 - Customer management of tenant
1 - Partner management of tenant
2 - To be configured
integer
tenantsThe tenant information of the customer.list
Tenant information:
FieldDescriptionType
idThe ID of the tenant.string

## 22 / 174
FieldDescriptionType
nameThe name of the tenant.string
## Request Sample
To use this API, send a POST request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://graph.avepointonlineservices.com/partner/external/v3/general/customers/batch
## {
## "data": [
## {
"id": "03f7382e-****-1cda-****-dd9a****74f0", //The customer ID
"organization": "OrganizationABC", //The organization name of
the customer
"ownerEmail": "user@domain.com", //The email address of the customer
"jobStatus": 0, //The status of the customer's tenant: 0 represents N/A
"countryOrRegion": "Afghanistan", //The country or region of
the customer
"managementMode": 1, //The management mode of the customer: 1 represents
the partner management mode of tenant.
## "tenants":
## [
## {
"id":"03f7382e-****-1bcd-****-dd9a****74f0", //The ID of
the tenant
"name":"Tenant ABC" //The name of the tenant
## }
## ]
## },
## {
## "id": "03f7382e-****-1bac-****-dd9a****74f0",
"organization": "OrganizationDEF",
"ownerEmail": "userA@domain.com",
"jobStatus": 0,
"countryOrRegion": "Afghanistan",

## 23 / 174
"managementMode": 2,
## "tenants":
## [
## ]
## }
## ],
## "metadata": {
"pageIndex": 1, // The current display page
"pageSize": 50, // The number of objects on the display page
"totalCount": 2 // The total number of objects matching the query parameters
## }
## }

## 24 / 174
Onboard a Customer
Use this API to onboard a customer to the current partner.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPermission
## /partner/external/v3/general/customerselements.customers.readwrite.all
## Request
This section provides details on the HTTP method and endpoint used to onboard customers
to the current partner.
MethodEndpointDescription
POST/partner/external/v3/general/customersOnboard a customer to the current
partner.
## Request Body Parameters
This section outlines the request body parameters required to onboard a customer.
ParameterDescriptionTypeRequired?
firstNameThe first name of the customer.stringYes
lastNameThe last name of the customer.stringYes
organizationNameThe organization name of the customer.stringYes
registrationAccountThe registration account of the customer.stringYes
countryCodeThe country code of the customer. For
details, refer to Countries or Regions.
stringYes
telephoneNumberThe telephone number of the customer.stringNo

## 25 / 174
ParameterDescriptionTypeRequired?
dataCenterThe data center ID of the customer.
Commercial environment:
## 0b635b49-4c56-4e52-800a-
## 1fa79b2d5b08 - Australia Southeast
(Victoria)
## 7b9835ec-7299-4177-85e3-
ba5cb3b2e0411 - Canada Central
(Toronto)
e44bb3ed-f1d8-4055-8c77-
c8fd8cd63409 - East US (Virginia)
## 49681f94-26a7-4825-aca2-
df2eca7c0f81 - France Central (Paris)
ab2faf29-9e66-45ce-bf37-
32f8cf484fb2 - GCP for Australia
Southeast (Sydney)
## 7bd9748b-b52b-4e4d-9389-
e70dccee3b2d - GCP for East US
(Moncks Corner)
## 4f77581e-1a6f-47fd-9f68-
9134a4f6989b - GCP for Japan (Tokyo)
## 8998f218-708f-4084-8647-
32ed67042487 - GCP for South Korea
(Seoul)
e38cb1b7-efa9-490e-ab46-
83b45a94d1da - GCP for West Europe
(Eemshaven, Netherlands)
## 3225f6f8-a98c-425e-8279-
c6696d99659d - Germany West
Central (Frankfurt)
ca577c72-83bd-454c-af62-
da3d0586691d - Japan West (Osaka)
e4f66389-8219-4432-9af1-
01a9fe62a640 - Korea Central (Seoul)
f1cdd2b2-ac32-4509-8784-
fb2b947ef519 - North Europe (Ireland)
## 0d4a9846-97ad-4c09-bb1c-
## 8fbe93eaf3c6 - Southeast Asia
(Singapore)
stringYes

## 26 / 174
ParameterDescriptionTypeRequired?
f8ccd75d-d979-417c-96ee-
ae256a3af091 - Switzerland North
(Zurich)
d95b9c82-a426-400f-8256-
70646fdd1b4f - UK South (London)
## 4f93bdff-9b11-47b9-aa68-
a86bfa09f61c - West Europe
(Netherlands)
GOV environment:
d9210f50-bdb1-4f8f-a2bb-
99694d11f2da - US Gov Virginia
(Virginia)
passwordThe password of the customer.stringYes
tagsThe tags of the customer.string[]No
managementModeThe management mode of the customer.booleanNo
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.
ResponseDescriptionType
idThe ID of the customer.string
statusThe status of the customer.
## 1 - Successful
## 2 - Failed
3 - Customer does not exist
4 - Failed to register customer
5 - Customer is managed by current partner
6 - Customer is the same as current partner
7 - Customer already exists
integer
## Request Sample

## 27 / 174
To use this API, send a POST request to the specified endpoint.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://graph.avepointonlineservices.com/partner/external/v3/general/customers
## {
"firstName":"Tony", // The first name of the customer
"lastName":"Brown", // The last name of the customer
"organizationName":"OrganizationABC", // The organization name of the customer
"RegistrationAccount": "user@domain.com", // The registration account of
the customer
"password":"**********", // The password of the customer
"countryCode":"AF", // The country code of the customer
"dataCenter":"0d4a9846-97ad-4c09-bb1c-8fbe93eaf3c6", // The data center ID of
the customer
"tags":["tagA"] // The tags of the customer
## }
## {
"status":1, //The status of onboarding the customer: 1 represents Successful
"id":"76f5dc9e-****-****-****-d7ef****36i5" //The ID of the customer
## }

## 28 / 174
Add a Service
Use this API to add a service for a customer.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPermission
/partner/external/v3/general/customers/{customerId}/serviceselements.license.readwrite
## Request
This section provides details on the HTTP method and endpoint used to add a service for a
customer.
MethodEndpointDescription
POST/partner/external/v3/general/customers/{customerId}/servicesAdd a service
for a
customer.
## Request Body Parameters
You can provide the service detailed information in the request body to add a service for a
customer.
Add a Cloud Backup for Microsoft 365/Cloud Backup for
Exchange Online & OneDrive trial subscription:
ParameterDescriptionTypeRequired?
productThe name of the service.
2048 - Cloud Backup for Microsoft 365
integerYes
licenseTypeThe subscription type of the service.
## 0 - Trial
integerYes

## 29 / 174
ParameterDescriptionTypeRequired?
avepointStorageTypeThe AvePoint storage type of the service.
0 - AvePoint storage - Microsoft Azure
## Blob
1 - AvePoint storage - Amazon S3
integerYes (No)
retentionYearThe retention year for the data of the
service.
integerYes (No)
byosWhether the storage of the service is Bring
your own storage.
true - The storage is BYOS.
false - The storage is AvePoint
storage.
booleanNo (Yes)
storageProfileIdThe storage profile when BYOS is used.booleanNo (Yes)
Add a Cloud Backup Express/Baseline management/Workspace
management/User and device management/Workspace
management - storage optimization trial subscription:
ParameterDescriptionTypeRequired?
productThe name of the service.
## 274 - Cloud Backup Express
40 - Baseline management
42 - Workspace management
49 - User and device management
65 - Workspace management - storage
optimization
integerYes
licenseTypeThe subscription type of the service.integerYes
## NOTE
Either avepointStorageType and retentionYear must be provided, or byos must be
provided; at least one option is required.
## 

## 30 / 174
ParameterDescriptionTypeRequired?
## 0 - Trial
Add a Cloud Backup for Microsoft 365/Cloud Backup for Power
Platform/Cloud Backup for Exchange Online & OneDrive pooled
subscription:
ParameterDescriptionTypeRequired?
productThe name of the service.
2048 - Cloud Backup for Microsoft 365
integerYes
licenseTypeThe subscription type of the service.
## 1 - Enterprise
integerYes
avepointStorageTypeThe AvePoint storage type of the service.
0 - AvePoint storage - Microsoft Azure
## Blob
1 - AvePoint storage - Amazon S3
integerYes (No)
retentionYearThe retention year of the service.integerYes (No)
byosWhether the storage of the service is Bring
your own storage.
true - The storage is BYOS.
false - The storage is AvePoint
storage.
booleanNo (Yes)
storageProfileIdThe storage profile for BYOS when BYOS is
used.
booleanNo (Yes)
licenseItemsThe subscription items of the service.listYes
## NOTE
Either avepointStorageType and retentionYear must be provided, or byos must be
provided; at least one option is required.
## 

## 31 / 174
Subscription items:
ParameterDescriptionTypeRequired?
resourceThe resource of the service.
Office365Backup - Cloud Backup
for Microsoft 365 pool
Office365PPBackup - Cloud Backup
for Power Platform pool
Office365EXODBackup - Cloud
Backup for Exchange Online &
OneDrive pool
stringYes
subscriptionSourceTypeThe source of the service.
1 - AvePoint pool
2 - Marketplace pool
6 - LARS AvePoint pool
integerYes
isSameAsPoolWhether the expiration time of the
service is the same as the pool.
true - Same as the pool
false - Different from the pool
boolYes (No)
expireTimeThe expiration time of the service in ISO
8601 format.
stringNo (Yes)
saleTypeThe type of the service.
0 - Capacity tier
1 - Unlimited users
2 - Unlimited organization
integerYes
packageTypeThe package type of the service.
## 0 - Standard
## 1 - Core
## 2 - Flex
integerYes
customerSizeThe customer's size of the service.integerYes

## 32 / 174
ParameterDescriptionTypeRequired?
userSeatThe number of user seats of the service
to assign to the customer.
integerYes
contractEndDateThe contract end date of the service.stringNo
paymentTypeThe payment type of the service.
## 0 - Prepaid
1 - Pay as you go
integerYes
Add a Baseline management/Workspace management/User and
device management/Workspace management - Storage
optimization pooled subscription:
ParameterDescriptionTypeRequired?
productThe name of the service.
40 - Baseline management
42 - Workspace management
49 - User and device management
65 - Workspace management - storage
optimization
integerYes
licenseTypeThe subscription type of the service.
## 1 - Enterprise
integerYes
licenseItemsThe subscription items of the service.listYes
Subscription items:
## NOTE
If isSameAsPool is false, expireTime must be provided. If expireTime is provided,
isSameAsPool is not required. PackageType and customerSize are only for Cloud
Backup for Microsoft 365/Cloud Backup for Exchange Online & OneDrive.
## 

## 33 / 174
ParameterDescriptionTypeRequired
resourceThe resource of the service.
PartnerTenantSettingManagement
- Baseline management pool
PartnerWorkspaceOnboarding -
Workspace management pool
PartnerUserManagement - User
and device management pool
PartnerStorageOptimization -
Workspace management - storage
optimization pool
stringYes
subscriptionSourceTypeThe source of the service.
1 - AvePoint pool
2 - Marketplace pool
6 - LARS AvePoint pool
integerYes
isSameAsPoolWhether the expiration time of the service
is the same as the pool.
true - Same as the pool
false - Different from the pool
booleanYes (No)
expireTimeThe expiration time of the service in ISO
8601 format.
stringNo (Yes)
userSeatThe number of user seats of the service to
assign to the customer.
integerYes
contractEndDateThe contract end date of the service.stringNo
paymentTypeThe payment type of the service.
## 0 - Prepaid
1 - Pay as you go
integerYes

## 34 / 174
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information in the response body.
ResponseDescriptionType
customerIdThe ID of the customer.string
productThe name of the added service.integer
statusThe status of adding the service.
## 1 - Successful
## 2 - Failed
3 - Partner has no subscription
4 - User seat insufficient
5 - Exceeded expiration time
6 - Check failed
7 - Subscription already exists
11 - Expiration time earlier than current time
12 - Has same subscription
16 - Check successful
17 - Premium service reached limit
18 - Expiration time less than one month
19 - Failed to reduce user seats
20 - Failed to assign Exchange Online & OneDrive subscription
integer
## Request Sample
To use this API, send a POST request to the specified endpoint.
## NOTE
If isSameAsPool is false, expireTime must be provided. If expireTime is provided,
isSameAsPool is not required.
## 
https://graph-
us.avepointonlineservices.com/partner/external/v3/general/customers/caf9****-2cc6-
## ****-b04b-794c****5ea3/services

## 35 / 174
Add a Cloud Backup for Microsoft 365/Cloud Backup for Exchange Online & OneDrive
trial subscription request:
## {
"product": 2048, // The name of the service: 2048 represents Cloud Backup for
## Microsoft 365
"licenseType": 0, // The subscription type of the service: 0 represents trial
"avepointStorageType": 0, // The storage type of the service: 0 represents the
AvePoint storage - Microsoft Azure Blob
"retentionYear": 1, // The retention year of the service
## }
Add a Cloud Backup Express/Baseline management/Workspace management/User and device
management/Workspace management - storage optimization trial subscription request:
## {
## "product": 42,
"licenseType": 0
## }
Add a Cloud Backup for Microsoft 365/Cloud Backup for Power Platform/Cloud Backup
for Exchange Online & OneDrive pool subscription request:
## {
## "product": 2048,
"licenseType": 1,
"byos": true, // The storage type of the service: true represents Bring your
own storage
"storageProfileId": "96c5****-c6cb-****-9792-b1a1****aeae", // The ID of the
storage profile
"licenseItems": [
## {
"expireTime": "2025-09-26T00:00:00Z", // The expiration time of the service
"userSeat": 1, // The number of user seats to assign to the customer
"resource": "Office365Backup", // The resource of the service: Office365Backup
represents Cloud Backup for Microsoft 365 pool
"isSameAsPool": true, // Whether the expiration time of the service is the
same as the pool: true represents the expiration time are the same
"subscriptionSourceType": 1, // The source of the service: 1 represents
AvePoint pool
"paymentType": 0, // The payment type of the service: 0 represents Prepaid
"saleType": 0, // The type of the service: 0 represents Capacity tier
"customerSize": 5, // The customer's size of the service
"packageType": 0 // The package type of the service; 0 represents Standard
## },
## {
"expireTime": "2025-09-26T00:00:00Z",
"userSeat": 1,
"resource": "Office365PPBackup",

## 36 / 174
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
"isSameAsPool": true,
"subscriptionSourceType": 6,
"paymentType": 1,
"saleType": 2,
## }
## ]
## }
Add Baseline management/Workspace management/User and device management/Workspace
management - storage optimization pooled subscription request:
## {
## "product": 42,
"licenseType": 1,
"licenseItems": [
## {
"expireTime": "2025-09-30T00:00:00Z",
"userSeat": 1,
"resource": "PartnerTenantSettingManagement",
"isSameAsPool": true,
"subscriptionSourceType": 1,
"paymentType": 0
## }
## ]
## }
## {
"customerId":"caf9****-2cc6-****-b04b-794c****5ea3", // The ID of the customer
"product":2048, // The added service: 2048 represents Cloud Backup for
## Microsoft 365
"status":1 // The status of adding the service: 1 represents successful
## }

## 37 / 174
Retrieve All Services of Customers
Use this API to retrieve the services of customers managed by the current partner.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPermission
## /partner/external/v3/general/customers/services/batchelements.license.read.all
## Request
This section outlines the details of the HTTP method and endpoint used to retrieve the
services of customers managed by the current partner.
MethodEndpointDescription
POST/partner/external/v3/general/customers/services/batchRetrieve the services
of customers
managed by the
current partner.
## Query Parameters
This section outlines the parameters that allow users to specify pagination.
ParameterDescriptionTypeRequired
pageIndexThe starting number of the page to retrieve the
services. The default value is 1.
integerNo
pageSizeThe number of objects to display on one page. The
default value is 50 and the maximum value allowed is
## 100.
integerNo
## Request Body Parameters
This section outlines the request body required to specify which customers you want to
retrieve.

## 38 / 174
ParameterDescriptionTypeRequired
customerIdsThe ID of the customer to be retrieved.string[]No
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.
FieldDescriptionType
customerIdThe ID of the customer.string
organizationThe organization name of the customer.string
customerThe email address of the customer.string
productsThe service subscription information of the customer.list
Service subscriptions:
FieldDescriptionType
serviceThe service that the customer has subscriptions for.string
subscriptionModelThe subscription model of the service.string
purchasedUserSeatsThe number of purchased user seats of the customer.string
purchasedUnitsThe purchased unit of the service.string
microsoftLicenseAssignedThe number of assigned Microsoft licenses of the
customer.
string
microsoftLicenseAvailableThe number of available Microsoft licenses of the
customer.
string
purchasedCapacityThe purchased capacity for the customer.string
protectedCapacityThe protected capacity for the customer.string
storageThe storage of the service.string
retentionThe data retention period of the customer.string

## 39 / 174
FieldDescriptionType
consumedStorageThe consumed storage size of the customer.string
expirationDateThe expiration time of the customer’s service in ISO
8601 format.
string
changeThe changes in the pooled license compared with the
first day of the current month.
string
sourceThe source of the subscription.string
paymentTypeThe payment type of the subscription.string
subscriptionNameThe subscription name. This parameter is intended
specifically for the Fly service.
string
packageThe package of the subscription. This parameter is
intended specifically for the Cloud Backup for
Microsoft 365 service.
string
contractEndDateThe contract end date of the subscription.string
## Request Sample
To use this API, send a POST request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://graph.avepointonlineservices.com/partner/external/v3/general/customers/servi
ces/batch
## {
## "data": [
## {
"customerId": "1c10525c-****-****-****-2e641bc13421", // The ID of
the customer
"organization": "OrganizationABC", // The organization name of

## 40 / 174
the customer
"customer": "user@domain.com", //The email address of the customer
## "products": [
## {
"service": "Cloud Backup for IaaS + PaaS - Unit", // The service
that the customer has subscriptions for
"subscriptionModel": "N/A", // The subscription model of the
service; not applicable here
"purchasedUserSeats": "N/A", // The number of purchased user
seats of the customer; not applicable here
"purchasedUnits": "N/A", // The purchased unit of the service;
not applicable here
"microsoftLicenseAssigned": "0", // The number of assigned
Microsoft licenses of the customer
"microsoftLicenseAvailable": "0", // The number of available
Microsoft licenses of the customer
"purchasedCapacity": "0/1 GB", // The purchased capacity for
the customer
"protectedCapacity": "0 GB", // The protected capacity for
the customer
"storage": "Bring your own storage", // The storage of
the service
"retention": "N/A", // The data retention period of the
customer; not applicable here
"consumedStorage": "N/A", // The consumed storage size of the
customer; not applicable here
"expirationDate": "2025-09-26T00:00:00Z", // The expiration time
of the customer’s service
"change": "N/A", // The changes in the pooled license compared
with the first day of the current month; no changes here
"source": "AvePoint pooled subscription", // The source of
the subscription
"paymentType": "Prepaid", // The payment type of the
subscription; not applicable here
"subscriptionName": "N/A", // The subscription name; not
applicable here
"package": "N/A", // The package of the subscription; not
applicable here
"contractEndDate": "N/A" // The contract end date of the
subscription; not applicable here
## },
## {
"service": "Fly Migration to Google",
"subscriptionModel": "N/A",
"purchasedUserSeats": "2",
"purchasedUnits": "N/A",

## 41 / 174
"microsoftLicenseAssigned": "0",
"microsoftLicenseAvailable": "0",
"purchasedCapacity": "N/A",
"protectedCapacity": "N/A",
"storage": "N/A",
"retention": "N/A",
"consumedStorage": "N/A",
"expirationDate": "2025-09-26T00:00:00Z",
"change": "N/A",
"source": "AvePoint subscription",
"paymentType": "N/A",
"subscriptionName": "N/A",
"package": "N/A",
"contractEndDate": "N/A"
## }
## ]
## },
## ],
## "metadata": {
"pageIndex": 1, // The current display page
"pageSize": 50, // The number of objects on the display page
"totalCount": 1 // The total number of objects matching the query parameters
## }
## }

## 42 / 174
## Retrieve Customer Tenant User Seats
Use this API to retrieve the numbers of assigned and available user seats of the customer's
tenant.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPermission
/partner/external/v3/general/customers/{customerId}/3rd-
party-products/type/{type}/tenants/batch
elements.license.read.all
## Request
This section outlines the details of the HTTP method and endpoint used to retrieve the user
seat details of customer's tenant.
MethodEndpointDescription
POST/partner/external/v3/general/customers/{customerId}/3rd-
party-products/type/{type}/tenants/batch
Retrieve the
user seat
details of
customer's
tenant.
## Query Parameters
This section outlines the parameters that allow users to specify pagination.
ParameterDescriptionTypeRequired
pageIndexThe starting number of the page to get the numbers
of assigned and available user seats. The default
value is 1.
integerNo
pageSizeThe number of objects to display on one page. The
default value is 50 and the maximum value allowed is
## 100.
integerNo

## 43 / 174
URL Parameters
This section outlines the parameters required to specify which customer tenant you want to
retrieve.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes
typeThe tenant type of the customer.
## 0 - Microsoft 365
## 1 - Salesforce
## 2 - Google
## 3 - Dynamics 365
integerYes
## Request Body Parameters
This section outlines the request body required to specify the tenants for which you want to
retrieve the user seats.
ParameterDescriptionTypeRequired
tenantIdsThe ID of the tenant.integerNo
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.
FieldDescriptionType
typeThe tenant type of the customer.
## 0 - Microsoft 365
## 1 - Salesforce
## 2 - Google
## 3 - Dynamics 365
integerYes
tenantIdThe ID of the tenant.string
tenantNameThe name of the tenant.string

## 44 / 174
FieldDescriptionType
availableUserSeatThe number of available user seats of the tenant.integer
assignedUserSeatThe number of assigned user seats of the tenant.integer
## Request Sample
To use this API, send a POST request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://graph.avepointonlineservices.com/partner/external/v3/general/customers/f162*
## ***-b9d4-****-a165-97db****fc15/3rd-party-products/type/0/tenants/batch
## {
## "data": [
## {
"type": 0, // The type of the tenant; 0 represents the Microsoft
365 tenant
"tenantId": "f04d7aee-****-5f92-****-6521****e596", // The ID of
the tenant
"tenantName":"TenantABC", // The name of the tenant
"availableUserSeat": 25, // The number of available user seats of
the tenant
"assignedUserSeat": 25 // The number of assigned user seats of
the tenant
## }
## ],
## "metadata": {
"pageIndex": 1, // The current display page
"pageSize": 50, // The number of objects on the display page
"totalCount": 1 // The total number of objects matching the query parameters
## }
## }

## 45 / 174
Retrieve AvePoint Product Overview
Use this API to retrieve the number of purchased user seats for AvePoint products of the
customer.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPermission
/partner/external/v3/general/customers/{customerId}/avpt-
products/type/{productType}/overview
elements.license.read.all
## Request
This section outlines the details of the HTTP method and endpoint used to retrieve the
purchased user seats for AvePoint products of the customer.
MethodEndpointDescription
GET/partner/external/v3/general/customers/{customerId}/avpt-
products/type/{productType}/overview
Retrieve the
purchased user
seats for
AvePoint
products of the
customer.
URL Parameters
This section outlines the parameters required to specify which customer and product you
want to retrieve.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes
productTypeThe product type.
1 - DocAve Online
## 4 - Cloud Governance
integerYes

## 46 / 174
ParameterDescriptionTypeRequired
32 - Cloud Backup for Salesforce
40 - Baseline management
41 - Risk management
42 - Workspace management
49 - User management
60 - MyHub
65 - WorkSpace management - storage
optimization
257 - TyGraph
2048 - Cloud Backup for Microsoft 365
## 4096 - Cloud Management
## 8192 - Cloud Archiving
## 65536 - Opus
131072 - Cloud Backup for Dynamics 365
## 4194304 - Insights
8388608 - Policies for Microsoft 365
## 16777216 - Fly
33554432 - Cloud Backup for Google Workspace
## 67108864 - Cense
## 134217728 - Enpower
1073741824 - Cloud Backup for IaaS + PaaS
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.
FieldDescriptionType
productTypeThe product type.
1 - DocAve Online
## 4 - Cloud Governance
32 - Cloud Backup for Salesforce
40 - Baseline management
41 - Risk management
42 - Workspace management
49 - User management
60 - MyHub
string

## 47 / 174
FieldDescriptionType
65 - WorkSpace management - storage optimization
257 - TyGraph
2048 - Cloud Backup for Microsoft 365
## 4096 - Cloud Management
## 8192 - Cloud Archiving
## 65536 - Opus
131072 - Cloud Backup for Dynamics 365
## 4194304 - Insights
8388608 - Policies for Microsoft 365
## 16777216 - Fly
33554432 - Cloud Backup for Google Workspace
## 67108864 - Cense
## 134217728 - Enpower
1073741824 - Cloud Backup for IaaS + PaaS
purchasedUserSeatThe number of purchased user seats of the product.integer
## Request Sample
To use this API, send a GET request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://graph.avepointonlineservices.com/partner/external/v3/general/customers/f162*
## ***-b9d4-****-a165-97db****fc15/avpt-products/type/2048/overview
## {
"productType": 2048, // The product type: 2048 represents Cloud Backup for
## Microsoft 365
"purchasedUserSeat": 25 // The number of purchased user seats of
the customer
## }

## 48 / 174
Retrieve User Protected Status for Customer
Use this API to retrieve the protected status of users in the customer's tenant by Cloud
Backup for Microsoft 365.
## Permissions
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPermiss
/partner/external/v3/general/customers/{customerId}/tenants/{tenantId}/cloud-
backup-m365/users/batch
element
## Request
This section outlines the details of the HTTP method and endpoint used to retrieve the user
protected status.
MethodEndpoint
POST/partner/external/v3/general/customers/{customerId}/tenants/{tenantId}/cloud-
backup-m365/users/batch
## Query Parameters
This section outlines the parameters that allow users to specify pagination.
ParameterDescriptionTypeRequired
pageIndexThe starting number of the page to get the protected
status of users. The default value is 1.
integerNo
pageSizeThe number of objects to display on one page. The
default value is 50 and the maximum value allowed is
## 100.
integerNo
URL Parameters

## 49 / 174
This section outlines the parameters required to specify which customer tenant you want to
retrieve.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes
tenantIdThe tenant ID of the customer.stringYes
## Request Body Parameters
This section outlines the request body required to specify which tenant user's protected
status you want to retrieve.
ParameterDescriptionTypeRequired
userEmailsThe email address of the tenant user to be retrieved.string[]No
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.
FieldDescriptionType
idThe ID of the tenant user.string
emailThe email address of the tenant user.string
displayNameThe display name of the tenant user.string
moduleStatusThe protected module information of the tenant user.list
Protected module information
FieldDescriptionType
ModuleThe protected module of the tenant user.
## 0 - Mailbox
2 - OneDrive
integer
IsProtectedThe protected status of the module.
true - Protected
boolean

## 50 / 174
FieldDescriptionType
false - Not protected
## Request Sample
To use this API, send a POST request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://graph.avepointonlineservices.com/partner/external/v3/general/customers/f162*
***-b9d4-****-a165-97db****fc15/tenants/0eaab044-****-4a92-****-93c6****711e/cloud-
backup-m365/users/batch
## {
## "data": [
## {
"id": "96c5a607-****-12d7-****-b1a1****aeae", // The ID of the
tenant user
"email": "user@domain.onmicrosoft.com", // The email address of the
tenant user
"displayName":"UserA", // The display name of the tenant user
"moduleStatus":
## [
## {
"module":0, // The module of the tenant user: 0
represents mailbox
"isProtected": false // Whether the user is protected by Cloud
Backup for Microsoft 365: false represents not protected
## },
## {
## "module":2,
"isProtected": true
## }
## ]
## }
## ],
## "metadata": {

## 51 / 174
"pageIndex": 1, // The current display page
"pageSize": 50, // The number of objects on the display page
"totalCount": 1// The total number of objects matching the query parameters
## }
## }

## 52 / 174
Retrieve Cloud Backup for Microsoft 365
## Overview
Use this API to retrieve the customer's protected data information of Cloud Backup for
## Microsoft 365.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPermission
/partner/external/v3/general/customers/{customerId}/cloud-
backup-m365/overview
elements.cbprotected.read.a
## Request
This section outlines the details of the HTTP method and endpoint used to retrieve the
customer's protected data information of Cloud Backup for Microsoft 365.
MethodEndpointDescription
GET/partner/external/v3/general/customers/{customerId}/cloud-
backup-m365/overview
Retrieve the
customer's
protected data
information of
## Cloud Backup
for Microsoft
## 365.
## Query Parameters
This section outlines the parameters that allow users to specify pagination.
ParameterDescriptionTypeRequired
pageIndexThe starting number of the page to retrieve the
customer's protected data information. The default
value is 1.
integerNo

## 53 / 174
ParameterDescriptionTypeRequired
pageSizeThe number of objects to display on one page. The
default value is 50 and the maximum value allowed is
## 100.
integerNo
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.
FieldDescriptionType
customerIdThe ID of the customer.string
customerThe email address of the customer.string
serviceTypeThe name of the service.string
serviceModuleThe module of the customer’s Cloud Backup for
Microsoft 365 service.
string
totalScannedObjectsThe number of scanned objects of the module.integer
totalProtectedObjectsThe number of backed-up objects of the module.integer
dataSizeStoredInAvePointThe backup data size of objects in the last job (using
AvePoint storage).
string
dataSizeStoredInBYOSThe backup data size of objects in the last job (using
## BYOS).
string
## Request Sample
To use this API, send a GET request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
https://graph.avepointonlineservices.com/partner/external/v3/general/customers/caf9*
## ***-2cc6-****-b04b-794c****5ea3/cloud-backup-m365/overview

## 54 / 174
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
## [
## "data": [
## {
"customerId": "f1626c49-****-****-****-97db****fc15", // The customer ID
"customer": "userA@domain.com", // The email address of the customer
"serviceType": "Cloud Backup for Microsoft 365", // The service name
"serviceModule": "Exchange Online", // The module of Cloud Backup for
## Microsoft 365
"totalScannedObjects": 25, // The number of scanned objects of
the module
"totalProtectedObjects": 25, // The number of backed-up objects of
the module
"dataSizeStoredInAvePoint": "0 GB", // The backup data size of objects
in the last job (using AvePoint storage)
"dataSizeStoredInBYOS": "N/A" // The backup data size of objects in the
last job (using BYOS): N/A represents not applicable here
## },
## {
"customerId": "f1626c49-****-****-****-97db****fc15",
"customer": "userB@domain.com",
"serviceType": "Cloud Backup for Microsoft 365",
"serviceModule": "Microsoft 365 Group",
"totalScannedObjects": 7,
"totalProtectedObjects": 7,
"dataSizeStoredInAvePoint": "0 GB",
"dataSizeStoredInBYOS": "N/A"
## }
## ],
## "metadata": {
"pageIndex": 1, // The current display page
"pageSize": 50, // The number of objects on the display page
"totalCount": 2 // The total number of objects matching the query parameters
## }
## ]

## 55 / 174
Retrieve Job Details of Backup Services for a
## Customer
Use this API to retrieve the job details for a specific job type and module of backup services,
including Cloud Backup for Microsoft 365, Cloud Backup for Google Workspace, Cloud
Backup for IaaS + PaaS, Cloud Backup for Dynamics 365, and Cloud Backup for Salesforce.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPermission
/partner/external/v3/general/customers/{customerId}/avpt-
products/jobs/batch
elements.jobs.read.all
## Request
This section outlines the details of the HTTP method and endpoint used to retrieve the job
details of the backup services for a specific customer.
MethodEndpointDescription
POST/partner/external/v3/general/customers/{customerId}/avpt-
products/jobs/batch
Retrieve the job
details of the
backup services
for a specific
customer.
## Query Parameters
This section outlines the parameters that allow users to specify pagination.
ParameterDescriptionTypeRequired
pageIndexThe starting number of the page to get the job
details. The default value is 1.
integerNo
pageSizeThe number of objects to display on one page. The
default value is 50 and the maximum value allowed is
integerNo

## 56 / 174
ParameterDescriptionTypeRequired
## 100.
## Request Body Parameters
This section outlines the request body required to specify which backup service you want to
retrieve.
ParameterDescriptionTypeRequired
jobTypeThe service type of the job to be retrieved.
## 0 - Microsoft 365 Scan
## 7 - Microsoft 365
## 10 - Google Workspace Scan
## 11 - Google Workspace
12 - IaaS + PaaS
## 15 - Salesforce
## 16 - Dynamics 365
integerNo
jobModuleThe module of the job to be retrieved.
## 0 - None
## 8 - Archiver
## 10 - Retention
302 - SharePoint Online
## 303 - Exchange Online
## 304 - Microsoft 365 Groups
305 - OneDrive
## 306 - Project Online
## 307 - Exchange Online Public Folder
## 308 - Microsoft Teams
## 309 - Teams Chat
310 - Power BI
## 311 - Power Automate
## 312 - Power Apps
355 - Cloud Backup for Azure
## 356 - Azure Virtual Machine
## 357 - Disk
358 - Microsoft Entra ID
## 359 - Storage
## 360 - Admin Portal Settings
integerNo

## 57 / 174
ParameterDescriptionTypeRequired
361 - Amazon EC2
362 - Native Azure SQL Backup Monitoring
## 363 - Dev Ops
364 - Microsoft Entra ID B2C
365 - Azure SQL Backup
## 366 - Google Virtual Machine Instance
367 - Azure VMware Solution
368 - Microsoft SQL Server in Azure VM
## 369 - Google Cloud Storage
## 401 - Dynamics 365
## 402 - Viva Engage
## 501 - Gmail
## 502 - Calendar
## 503 - Contacts
## 504 - Drive
## 505 - Shared Drives
## 506 - Google Classroom
## 507 - Chat
## 508 - Google Directory
550 - Dynamics CRM Backup
## 551 - Dynamics Unified Operations Backup
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.
FieldDescriptionType
jobTypeThe service type of the job.
## 0 - Microsoft 365 Scan
## 7 - Microsoft 365
## 10 - Google Workspace Scan
## 11 - Google Workspace
12 - IaaS + PaaS
## 15 - Salesforce
## 16 - Dynamics 365
integer

## 58 / 174
FieldDescriptionType
jobModuleThe module of the job.
## 0 - None
## 8 - Archiver
## 10 - Retention
302 - SharePoint Online
## 303 - Exchange Online
## 304 - Microsoft 365 Groups
305 - OneDrive
## 306 - Project Online
## 307 - Exchange Online Public Folder
## 308 - Microsoft Teams
## 309 - Teams Chat
310 - Power BI
## 311 - Power Automate
## 312 - Power Apps
355 - Cloud Backup for Azure
## 356 - Azure Virtual Machine
## 357 - Disk
358 - Microsoft Entra ID
## 359 - Storage
## 360 - Admin Portal Settings
361 - Amazon EC2
362 - Native Azure SQL Backup Monitoring
## 363 - Dev Ops
364 - Microsoft Entra ID B2C
365 - Azure SQL Backup
## 366 - Google Virtual Machine Instance
367 - Azure VMware Solution
368 - Microsoft SQL Server in Azure VM
## 369 - Google Cloud Storage
## 401 - Dynamics 365
## 402 - Viva Engage
## 501 - Gmail
## 502 - Calendar
## 503 - Contacts
## 504 - Drive
## 505 - Shared Drives
## 506 - Google Classroom
integer

## 59 / 174
FieldDescriptionType
## 507 - Chat
## 508 - Google Directory
550 - Dynamics CRM Backup
## 551 - Dynamics Unified Operations Backup
statusThe status of the job.
## 0 - None
## 1 - Running
## 2 - Finished
## 3 - Failed
4 - Finished with exception
## 5 - Skipped
## 6 - Pending
7 - Failed to start
## 8 - Canceled
## 9 - Rejected
## 10 - Stopped
11 - Not scanned
## 12 - Disabled
13 - Not started
14 - Waiting for configuration
integer
jobIdThe ID of the job.string
nameThe name of the job.string
totalCountThe number of the objects that have been processed by the
job.
string
failedCountThe number of failed objects.string
successfulCountThe number of successful objects.string
skippedCountThe number of skipped objects.string
warningCountThe number of warning objects.string
backupSizeThe size of the backed-up objects.string
startTimeThe start time of the job in ISO 8601 format.string

## 60 / 174
FieldDescriptionType
endTimeThe end time of the job in ISO 8601 format.string
jobDurationThe duration of the job.string
lastModifyTimeThe last modified time of the job in ISO 8601 format.string
## Request Sample
To use this API, send a POST request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://graph.avepointonlineservices.com/partner/external/v3/general/customers/caf9*
## ***-2cc6-****-b04b-794c****5ea3/avpt-products/jobs/batch
## {
## "data": [
## {
"jobType": 7, // The type of the job: 7 represents Microsoft 365
"jobModule": 304, // The module of the job: 304 represents Microsoft
## 365 Groups
"status": 3, // The status of the job. 3 represents failed
"jobId": "FB20****1103****214502", // The ID of the job
"name": "N/A", // The name of the job; not applicable here
"totalCount": "2323", // The number of the objects that have been
processed by the job
"failedCount": "0", // The number of failed objects
"successfulCount": "2323", // The number of successful objects
"skippedCount": "0", // The number of skipped objects
"warningCount": "0", // The number of warning objects
"backupSize": "0 GB", // The backup size of the job
"startTime": "2025-09-11T03:21:16Z", // The start time of the job
"endTime": "2025-09-11T03:38:56Z", // The end time of the job
"jobDuration": "17m39s", // The duration of the job
"lastModifyTime": "2025-09-11T03:38:57Z" // The last modified time of
the job
## }

## 61 / 174
## ],
## "metadata": {
"pageIndex": 1, // The current display page
"pageSize": 50, // The number of objects on the display page
"totalCount": 1 // The total number of objects matching the query parameters
## }
## }

## 62 / 174
Retrieve All Scan Profiles for a Customer
Use this API to retrieve all scan profiles configured for a specific customer in AvePoint
## Online Services.
## Permissions
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPermission
/partner/external/v3/general/customers/{customerId}/scan-
profiles/batch
elements.scanprofiles.read.al
## Request
This section outlines the details of the HTTP method and endpoint used to retrieve all scan
profiles configured for a specific customer in AvePoint Online Services.
MethodEndpointDescription
POST/partner/external/v3/general/customers/{customerId}/scan-
profiles/batch
Retrieve all scan
profiles
configured for a
specific
customer in
AvePoint Online
## Services
## Query Parameters
This section outlines the parameters optional required to specify paging information about
the profile you want to retrieve.
ParameterDescriptionTypeRequired
pageIndexThe starting number of the page to retrieve the scan
profiles. The default value is 1.
integerNo

## 63 / 174
ParameterDescriptionTypeRequired
pageSizeThe number of objects to display on one page. The
default value is 50 and the maximum value allowed is
## 100.
integerNo
## Request Body Parameters
This section outlines the request body required to specify which scan profiles you want to
retrieve.
ParameterDescriptionTypeRequired
scanProfileIdsThe IDs of the scan profiles to be retrieved.string[]No
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.
FieldDescriptionType
profileNameThe name of the scan profile.string
profileIdThe ID of the scan profile.string
scanModeThe scan mode of the scan profile.
0 - Express mode
1 - Advanced mode
integer
modifiedTimeThe last modified time of the scan profile in ISO 8601 format.string
## Request Sample
To use this API, send a GET request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
https://graph.avepointonlineservices.com/partner/external/v3/general/customers/caf9*
## ***-2cc6-****-b04b-794c****5ea3/scan-profiles/batch

## 64 / 174
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
## {
## "data": [
## {
"profileName": "Default Microsoft 365 Scan Profile", // The name of the
scan profile
"profileId": "47db****-1004-****-b2ce-8f5e****842d", // The ID of the
scan profile
"scanMode": 0, // The scan mode of the scan profile: 0 represents
Express mode
"modifiedTime": "2025-09-11T03:19:14Z" // The last modified time of the
scan profile
## }
## ],
## "metadata": {
"pageIndex": 1, // The current display page
"pageSize": 50, // The number of objects on the display page
"totalCount": 1 // The total number of objects matching the query parameters
## }
## }

## 65 / 174
## Retrieve Customer Scan Profile Details
Use this API to retrieve the details of a specific scan profile configured in AvePoint Online
Services for a customer.
## Permissions
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPermission
/partner/external/v3/general/customers/{customerId}/scan-
profiles/{scanProfileId}
elements.scanprofiles.read.al
## Request
This section outlines the details of the HTTP method and endpoint used to retrieve the
details of a specific scan profile configured in AvePoint Online Services for a customer.
MethodEndpointDescription
GET/partner/external/v3/general/customers/{customerId}/scan-
profiles/{scanProfileId}
Retrieve the
details of a
specific scan
profile
configured in
AvePoint Online
Services for a
customer.
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.
FieldDescriptionType
profileNameThe name of the scan profile.string
profileIdThe ID of the scan profile.string

## 66 / 174
FieldDescriptionType
descriptionThe description of the scan profile.string
tenantIdThe tenant ID of the scan profile.string
tenantDomainThe tenant domain of the scan profile.string
scanModeThe scan mode of the scan profile.
0 - Express mode
1 - Advanced mode
integer
modifiedTimeThe last modified time of the scan profile in
ISO 8601 format.
string
createdTimeThe created time of the scan profile in ISO
8601 format.
string
impersonationAccountThe impersonation account configured in the
scan profile.
string
scanInplaceArchivedMailboxesWhether the Scan in-place archived
mailboxes setting is enabled in the scan
profile:
true - Enabled
false - Disabled
boolean
isIgnoreLockedSiteEnabledWhether the Ignore the locked objects
when updating the job status setting is
enabled in the scan profile:
true - Enabled
false - Disabled
boolean
enableDailyScanWhether the Enable daily scan setting is
enabled in the scan profile:
## No - Disabled
hh:mm - The time of the daily scan, for
example, 01:59
string
isSendOutOfPolicyNotificationWhether the Send an email notification to
the following recipients when objects are
boolean

## 67 / 174
FieldDescriptionType
moved to other containers or removed
from any containers setting is enabled in
the scan profile:
true - Enabled
false - Disabled
containersThe information of the containers.list
Container information:
FieldDescriptionType
containersNameThe name of the container.string
objectTypeThe object type of the container.
## 0 - Site Collection
## 1 - Mailbox
2 - OneDrive
## 5 - Microsoft 365 Group
## 6 - Project Online
## 7 - Public Folder
## 9 - Channel
## 10 - User
## 11 - None Unified Group
## 12 - Power Platform Environment
## 13 - Power Platform Connection
## 14 - Power Apps
## 15 - Power Automate
16 - Power BI Workspace
## 17 - Active Directory Mailbox
## 18 - Active Directory User
## 19 - Active Directory Group
## 20 - Power Platform Solution
## 21 - Power Copilot Studio
## 22 - Power Page
## 23 - Loop Container
24 - SharePoint Agent
25 - Azure AI Foundry Agent
## 100 - Google User
integer

## 68 / 174
FieldDescriptionType
## 101 - Google Shared Drive
## 102 - Google Classroom
## 103 - Google Mailbox
## 104 - Google Group
## 105 - Google Vault Matter
## Request Sample
To use this API, send a GET request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://graph.avepointonlineservices.com/partner/external/v3/general/customers/caf9*
***-2cc6-****-b04b-794c****5ea3/scan-profiles/47db****-1004-****-b2ce-8f5e****842d
## {
"profileId": "47db****-1004-****-b2ce-8f5e****842d",// The ID of the
scan profile
"profileName": "Default Microsoft 365 Scan Profile", // The name of the
scan profile
"description": "This is a partner-configured scan profile.", // The description
of the scan profile
"tenantId": "c235****-c7a2-****-b7d4-79e8****66c3", // The tenant ID of the
scan profile
"tenantDomain": "domain", // The tenant domain of the scan profile
"scanMode": 0, // The scan mode of the scan profile: 0 represents the
Express mode
"modifiedTime": "2025-09-11T03:19:14Z",  // The last modified time of the
scan profile
"createdTime": "2025-09-11T03:19:14Z", // The created time of the scan profile
"impersonationAccount": "user@domain.com", // The impersonation account
configured in the scan profile
"scanInplaceArchivedMailboxes": false, // Whether to scan in-place archived
mailboxes configured in the scan profile: False represents Do not scan in-place
archived mailbox
"isIgnoreLockedSiteEnabled": false, // Whether to ignore the locked sites in the

## 69 / 174
scan profile: false represents Disabled
"enableDailyScan": "15:19", // The time of the daily scan
"isSendOutOfPolicyNotification": false, // Whether the Send an email
notification to the following recipients when objects are moved to other containers
or removed from any containers setting is enabled in the scan profile: false
represents Disabled
## "containers": [
## {
"containersName": "Default_ProjectOnline_Sites_Group", // The
container name
"objectType": 6 // The object type: 6 represents Project Online
## },
## {
"containersName": "Default OneDrive for Business Group",
"objectType": 2
## },
## {
"containersName": "Default_ SharePoint Sites_ Group",
"objectType": 0
## },
## {
"containersName": "Default_ Mailbox_ Group",
"objectType": 1
## },
## {
"containersName": "Default_ User_ Group",
"objectType": 10
## },
## {
"containersName": "Default Office 365 Group Group",
"objectType": 5
## }
## ]
## }

## 70 / 174
Retrieve Daily Scan Profile Changes in Ave
Point Online Services for a Customer
Use this API to retrieve the daily scan profile changes in AvePoint Online Services for a
customer.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPermission
/partner/external/v3/general/customers/{customerId}/scan-
profiles/{scanProfileId}/changes
elements.scanprofiles.read.al
## Request
This section outlines the details of the HTTP method and endpoint used to retrieve the daily
scan profile changes in AvePoint Online Services for a customer.
MethodEndpointDescription
GET/partner/external/v3/general/customers/{customerId}/scan-
profiles/{scanProfileId}/changes
Retrieve the
daily scan
profile changes
in AvePoint
## Online Services
for a customer.
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.
FieldDescriptionType
profileNameThe name of the scan profile.string
profileIdThe ID of the scan profile.string

## 71 / 174
FieldDescriptionType
descriptionThe description of the scan
profile.
string
tenantIdThe tenant ID of the scan
profile.
string
tenantDomainThe tenant domain of the
scan profile.
string
scanModeThe scan mode of the profile.
0 - Express mode
1 - Advanced mode
integer
modifiedTimeThe last modified time of the
scan profile in ISO 8601
format.
string
lastUpdateTimeThe time the daily report for
the scan profile was
generated in ISO 8601
format. If no daily report has
been generated, the time will
be the last modified time of
the scan profile.
string
lastScanStatusThe last scan job status of the
scan profile.
## 0 - None
## 1 - Running
## 2 - Finished
## 3 - Failed
4 - Finished with
exception
## 5 - Skipped
## 6 - Pending
7 - Failed to tart
## 8 - Canceled
## 9 - Rejected
## 10 - Stopped
integer

## 72 / 174
FieldDescriptionType
11 - Not scanned
## 12 - Disabled
13 - Not started
14 - Wait for
configuration
newRegisteredContentCountThe number of newly
registered objects in the daily
report of the scan profile.
integer
movedToAnotherContainerThe number of objects moved
to another container in the
daily report of the scan
profile.
integer
removedFromMicrosoft365OrOutofPolicyThe number of objects
removed from Microsoft 365
or out of policy in the daily
report of the scan profile.
integer
newRegisteredContentThe information of the newly
registered objects in the daily
report of the scan profile.
list
removedFromMicrosoft365OrOutOfPolicyObjectsThe objects removed from
Microsoft 365 or out of policy
in the daily report of the scan
profile.
string[]
movedToAnotherContainerObjectsThe information of the objects
moved to another container
in the daily report of the scan
profile.
list
## Request Sample
To use this API, send a GET request to the specified endpoint, including necessary
parameters as defined in the references.

## 73 / 174
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://graph.avepointonlineservices.com/partner/external/v3/general/customers/caf9*
## ***-2cc6-****-b04b-794c****5ea3/scan-profiles/47db****-1004-****-b2ce-
## 8f5e****842d/changes
## {
"profileName": "Default Microsoft 365 Scan Profile", // The name of the
scan profile
"profileId": "47db****-1004-****-b2ce-8f5e****842d", // The ID of the
scan profile
"tenantDomain": "Domain", // The tenant domain of the scan profile
"tenantId": "c235****-c7a2-****-b7d4-79e8****66c3", // The tenant ID of the
scan profile
"description": "This is a partner-configured scan profile.", // The description
of the scan profile
"scanMode": 0, // The scan mode of the profile: 0 represents the Express mode.
"modifiedTime": "2025-09-11T03:19:14Z", // The last modified time of the
scan profile
"lastUpdateTime": "2025-09-11T03:19:14Z", // The last updated time of the
scan profile
"lastScanStatus": 2, // The last scan job status of the scan profile: 2
represents finished
"newRegisteredContentCount": 0, // The number of newly registered objects in the
daily report of the scan profile
"movedToAnotherContainer": 0, // The number of objects moved to another
container in the daily report of the scan profile
"removedFromMicrosoft365OrOutofPolicy": 0, // The number of objects removed from
Microsoft 365 or out of policy in the daily report of the scan profile
"newRegisteredContent": [], // The information of the newly registered object in
the daily report; No data here
"removedFromMicrosoft365OrOutOfPolicyObjects": [], // The objects removed from
Microsoft 365 or out of policy in the daily report; No data here
"movedToAnotherContainerObjects": [] // The information of the objects moved to
another container in the daily report; No data here

## }

## 74 / 174
## Create Baseline
Use this API to create a baseline from a tenant to establish benchmarks for tenant
configurations.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPermission
## /partner/external/v3/bm/baselineselements.bm.baseline.readwrite.all
## Request
This section provides details on the HTTP method and endpoint used to create a baseline
from a tenant to establish benchmarks for tenant configurations.
MethodEndpointDescription
POST/partner/external/v3/bm/baselinesCreates a baseline from a tenant to
establish benchmarks for tenant
configurations.
## Request Body Parameters
The API requires multiple parameters to create a baseline from a tenant to establish
benchmarks for tenant configurations.
ParameterDescriptionTypeRequired?
nameThe name of the baseline.stringYes
colorThe color of the baseline.
## 0
## 1
## 2
## 3
## 4
## 5
integerYes

## 75 / 174
ParameterDescriptionTypeRequired?
## 6
## 7
## 8
## 9
## 10
## 11
## 12
## 13
## 14
## 15
## 16
## 17
## 18
## 19
## 20
## 21
descriptionThe description of the baseline.stringNo
customerIdThe ID of the customer.stringYes
tenantIdThe ID of the tenant.stringYes
## Response
If the request has been successfully processed, a 201 OK response will be returned along
with the ID of the newly created baseline displayed in the response body.
## NOTE
Tenants in the following status cannot be used to create a baseline.
## 3 - Deploying
## 6 - Expired
## 11 - Restoring
## 

## 76 / 174
ResponseDescriptionType
baselineIdThe ID of the newly created baseline.string
## Request Sample
To use this API, send a POST request to the specified endpoint.
## Response Sample
If the request has been successfully processed, a 201 OK response will be returned along
with the created baseline ID displayed in the response body. For more details on the HTTP
status code, refer to Http Status Code.
https://graph.avepointonlineservices.com/partner/external/v3/bm/baselines
## {
"name": "baseline A", // The name of the baseline
"color":"0", // The color of the baseline
"description":"baseline A's description", // The description of the baseline
"customerId":"ce43e186-****-98b4-****-86b51b0aef92", // The ID of the customer
"tenantId":"af83b8e1-****-8b70-****-970f92192dc5" // The ID of the tenant
## }
## {
"baselineId": "606f30c0-****-47b8-****-3a1c3a823ab5" // The ID of the newly
created baseline
## }

## 77 / 174
## Retrieve Baseline Information
Use this API to retrieve the general information of baselines.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPermission
/partner/external/v3/bm/baselines/batchelements.bm.baseline.read.all or
elements.bm.baseline.readwrite.all
## Request
This section provides details on the HTTP method and endpoint used to retrieve the general
information of baselines.
MethodEndpointDescription
POST/partner/external/v3/bm/baselines/batchRetrieves the general information of
baselines.
## Query Parameters
You can use the following optional query parameters in the URL to control pagination:
ParameterDescriptionTypeRequired?
pageIndexThe starting number of the page to retrieve
baselines. The default value is 1.
integerNo
pageSizeThe number of objects to display on one page. The
default value is 50 and the maximum value allowed
is 100.
integerNo
## Request Body Parameters
You can provide a list of baseline IDs in the request body to filter the results. This is
optional.

## 78 / 174
ParameterDescriptionTypeRequired?
baselineIdsThe IDs of the baselines.string[]No
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the general information of the queried baselines displayed in the response body.
ResponseDescriptionType
baselineIdThe ID of the baseline.string
baselineNameThe name of the baseline.string
createdTimeThe created time of the baseline in ISO 8601 format.string
modifiedTimeThe last modified time of the baseline in ISO 8601 format.string
statusThe status of the baseline.
1 - Retrieving settings
## 2 - Unused
## 3 - Active
4 - Settings retrieval failed
5 - Retrieved with exception
## 6 - Draft
integer
## Request Sample
To use this API, send a POST request to the specified endpoint.
https://graph-us.avepointonlineservices.com/partner/external/v3/bm/baselines/batch?
pageIndex=1&pageSize=50
## {
"baselineIds":
## [
"0f0cb41b-****-98b6-****-3a1c39554d0c", // The ID of the baseline
## "5aec2275-****-78n6-****-3a1c307a28fa"
## ]
## }

## 79 / 174
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the general information of the queried baselines in the response body. For more details
on the HTTP status code, refer to Http Status Code.
## {
## "data": [
## {
"baselineId": "0f0cb41b-****98b6-****-3a1c39554d0c", // The ID of
the baseline
"baselineName": "Baseline1", // The name of the baseline
"createdTime": "2025-09-04T10:30:00Z", // The created time of the
baseline in ISO 8601 format
"modifiedTime": "2025-09-05T10:30:00Z", // The last modified time of the
baseline in ISO 8601 format
"status": 1 // The status of the baseline. 1 represents
"Retrieving settings"
## },
## {
"baselineId": "5aec2275-****-78n6-****-3a1c307a28fa",
"name": "Baseline2",
"createdTime": "2025-09-06T10:30:00Z",
"modifiedTime": "2025-09-07T10:30:00Z",
## "status": 2
## }
## ],
## "metadata": {
"pageIndex": 1, // The current display page
"pageSize": 50, // The number of objects on the display page
"totalCount": 2 // The total number of objects matching the query parameters
## }
## }

## 80 / 174
## Retrieve Baseline Creation Job Report
Use this API to retrieve the report details of a baseline creation job.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPermission
/partner/external/v3/bm/baselines/{baselineId}/reportselements.bm.baseline.read.all or
elements.bm.baseline.readwrite
## Request
This section provides details on the HTTP method and endpoint used to retrieve the report
details of a baseline creation job.
MethodEndpointDescription
GET/partner/external/v3/bm/baselines/{baselineId}/reportsRetrieves the report
details of a baseline
creation job.
URL Parameters
This section describes the query parameters that can be added to the URL when sending a
GET request.
ParameterDescriptionTypeRequired
baselineIdThe ID of the baseline.stringYes
## Query Parameters
You can use the following optional query parameters in the URL to control pagination:

## 81 / 174
ParameterDescriptionTypeRequired?
pageIndexThe starting number of the page to get the report
details. The default value is 1
integerNo
pageSizeThe number of objects to display on one page. The
default value is 50 and the maximum value allowed
is 100.
integerNo
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the report details of the queried baseline creation job displayed in the response body.
ResponseDescriptionType
sourceThe source of the configuration.string
configurationThe name of the configuration.string
statusThe status of the configuration retrieval action.string
detailsThe detailed information to be displayed when a configuration
fails to be retrieved.
string
## Request Sample
To use this API, send a GET request to the specified endpoint.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the report details of the queried baseline creation job displayed in the response body.
For more details on the HTTP status code, refer to Http Status Code.
https://graph-
us.avepointonlineservices.com/partner/external/v3/bm/baselines/23351ee7-****-78n6-
****-e8e3ffc29cd7/reports?pageIndex=1&pageSize=50
## {
## "data": [
## {
"source": "Intune", // The source of the configuration

## 82 / 174
"configuration": "DeviceCompliancePolicies > MacOSCompliancePolicy", //
The name of the configuration
"status": "Successful", // The status of the configuration
retrieval action
"details": null // The detailed information to be displayed when a
configuration fails to be retrieved
## },
## {
"source": "Intune",
"configuration": "DeviceCompliancePolicies >
Windows10/11CompliancePolicy",
"status": "Successful",
"details": null
## },
## ...
## ],
## "metadata": {
"pageIndex": 1, // The current display page
"pageSize": 50, // The number of objects on the display page
"totalCount": 109 // The total number of objects matching the
query parameters
## }
## }

## 83 / 174
Retrieve Job Information from Process
## Center
Use this API to retrieve job information from the Process center page.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPermission
/partner/external/v3/bm/customers/{customerId}/tenants/{tenantId}/process-
center/jobs/batch
elements.bm
elements.bm
## Request
This section provides details on the HTTP method and endpoint used to retrieve job
information from the Process center page.
MethodEndpointD
POST/partner/external/v3/bm/customers/{customerId}/tenants/{tenantId}/process-
center/jobs/batch
## R
jo
in
f
## P
c
p
URL Parameters
This section describes the query parameters that can be added to the URL when sending a
POST request.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes
tenantIdThe ID of the tenant.stringYes

## 84 / 174
## Query Parameters
You can use the following optional query parameters in the URL to control pagination:
ParameterDescriptionTypeRequired?
pageIndexThe starting number of the page to get job
information. The default value is 1.
integerNo
pageSizeThe number of objects to display on one page. The
default value is 50 and the maximum value allowed
is 100.
integerNo
## Request Body Parameters
You can provide a list of job IDs in the request body to filter the results. This is optional.
ParameterDescriptionTypeRequired?
jobIdsThe IDs of the jobs.string[]No
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the retrieved job information displayed in the response body.
ResponseDescriptionType
jobIdThe ID of the job.string
typeThe type of the job.
1 - Apply baseline
## 2 - Auto-alignment
3 - Create baseline
4 - Detect drift
## 5 - Deploy
6 - Deploy detected deviations
7 - Daily tenant backup
8 - Edit tenant configurations
9 - Restore to a specific date
## 10 - Restore
integer

## 85 / 174
ResponseDescriptionType
statusThe status of the job.
## 0 - Waiting
1 - In progress
## 2 - Finished
## 3 - Failed
## 4 - Skipped
5 - Finished with exception
integer
## Request Sample
To use this API, send a POST request to the specified endpoint.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the job statuses retrieved from the Process center page displayed in the response
body. For more details on the HTTP status code, refer to Http Status Code.
https://graph-
us.avepointonlineservices.com/partner/external/v3/bm/customers/38c6a73d-****-98b6-
## ****-75b0f1959474/tenants/a2145aa5-****-76b8-****-7fffd6e0cc68/process-
center/jobs/batch?pageIndex=1&pageSize=50
## {
"jobIds":
## [
"a7bd3e1b-****-97d6-****-243c4df89a2d" // The ID of the job
## ]
## }
## {
## "data": [
## {
"jobId": "a7bd3e1b-****-97d6-****-243c4df89a2d", // The ID of the job
"type": 1, // The type of the job
"status": 2  // The status of the job
## }
## ],
## "metadata": {
"pageIndex": 1, // The current display page

## 86 / 174
"pageSize": 50, // The number of objects on the display page
"totalCount": 1 // The total number of objects matching the query parameters
## }
## }

## 87 / 174
## Retrieve Tenant Information
Use this API to retireve the general information of tenants added to the Baseline
Management module.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPermission
/partner/external/v3/bm/tenants/batchelements.bm.tenant.read.all or
elements.bm.tenant.readwrite.all
## Request
This section provides details on the HTTP method and endpoint used to retireve the general
information of tenants added to the Baseline Management module.
MethodEndpointDescription
POST/partner/external/v3/bm/tenants/batchRetireves the general information of
tenants added to the Baseline
Management module.
## Query Parameters
You can use the following optional query parameters in the URL to control pagination:
ParameterDescriptionTypeRequired?
pageIndexThe starting number of the page to get tenants. The
default value is 1.
integerNo
pageSizeThe number of objects to display on one page. The
default value is 50 and the maximum value allowed
is 100.
integerNo
## Request Body Parameters
You can provide a list of tenant IDs in the request body to filter the results. This is optional.

## 88 / 174
ParameterDescriptionTypeRequired?
tenantIdsThe IDs of the tenants.string[]No
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the general information of tenants added to the Baseline Management module
displayed in the response body.
ResponseDescriptionType
tenantNameThe name of the tenant.string
statusThe status of the tenant.
## 1 - Connected
2 - Deployed with exception
## 3 - Deploying
4 - Deployment draft saved
5 - Deployment failed
## 6 - Expired
## 7 - Deployed
8 - Restore failed
## 19 - Restored
10 - Restored with exception
## 11 - Restoring
12 - Retrieving setting
13 - Review deployment
14 - Review restore
15 - Scheduled deployment
16 - Schedule restore
17 - Settings retrieval failed
integer
driftDetectedThe number of configuration deviations that have been
detected for the tenant.
integer
driftDetectedTimeThe time in ISO 8601 format when configuration deviations
were detected.
string
lastDeployedTimeThe time in ISO 8601 format when the baseline was
deployed to the tenant.
string

## 89 / 174
ResponseDescriptionType
customerIdThe ID of the customer.string
tenantIdThe ID of the tenant.string
autoAlignmentThe status of the auto-alignment setting.
## 0 - Disabled
## 1 - Enabled
string
appliedBaselinesThe baselines that have been deployed to the tenant.string
baselineIdThe ID of the baseline.string
baselineNameThe name of the baseline.string
versionThe version of the baseline.integer
## Request Sample
To use this API, send a POST request to the specified endpoint.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the general information of tenants added to the Baseline Management module
displayed in the response body. For more details on the HTTP status code, refer to Http
## Status Code.
https://graph-us.avepointonlineservices.com/partner/external/v3/bm/baselines/batch?
pageIndex=1&pageSize=50
## {
"tenantIds":
## [
"af83b8e1-****-98a7-****-970f92192dc5" // The ID of the tenant
## ]
## }
## {
## "data": [
## {
"tenantName": "2****l", // The name of the tenant

## 90 / 174
"status": 5, // The status of the tenant. 5 represents
"Deployment failed"
"driftDetected": 51, // The number of configuration deviations that have
been detected for the tenant
"driftDetectedTime": "2025-09-05T10:30:00Z", // The time in ISO 8601
format when configuration deviations were detected
"customerId": "ce43e186-****-67v8-****-86b51b0aef92", // The ID of
the customer
"tenantId": "af83b8e1-****-98a7-****-970f92192dc5", // The ID of
the tenant
"autoAlignment": 1, // The status of the auto-alignment setting. 1
represents "Enabled"
"lastDeployedTime": "2025-09-11T02:26:34Z", // The time in ISO 8601
format when the baseline was deployed to the tenant
"appliedBaselines": [
## {
"baselineId": "de473862-****-45s6-****-3a1c20398d55", // The ID
of the baseline
"baselineName": "baseline1", // The name of the baseline
"version": "4" // The version of the baseline
## }
## ]
## }
## ],
## "metadata": {
"pageIndex": 1, // The current display page
"pageSize": 50, // The number of objects on the display page
"totalCount": 1 // The total number of objects matching the query parameters
## }
## }

## 91 / 174
## Monitor Tenant
Use this API to monitor a tenant by performing specific actions on the tenant. Currently,
you can use this API to apply baselines to a tenant.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPermission
/partner/external/v3/bm/customers/{customerId}/tenants/{tenantId}/actionselements.bm
## Request
This section provides details on the HTTP method and endpoint used to monitor a tenant by
performing specific actions on the tenant.
MethodEndpointDe
POST/partner/external/v3/bm/customers/{customerId}/tenants/{tenantId}/actionsM
te
pe
sp
ac
th
URL Parameters
This section describes the query parameters that can be added to the URL when sending a
POST request.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes
tenantIdThe ID of the tenant.stringYes
## Request Body Parameters
You can provide an object about the action.

## 92 / 174
ParameterDescriptionTypeRequired?
actionTypeThe action that you want to perform on a tenant.
(More actions will be supported in the future)
1 - Apply baselines to tenant
integerYes
dataThe parameters of the action.objectYes
Action data parameters
ParameterDescriptionTypeRequired?
baselineIdThe ID of the baseline.integerYes
rankingOrderThe ranking order of the baseline among all applied
baselines.
integerYes
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the action result in the response body.
ResponseDescriptionType
jobIdThe ID of the job to apply baselines to tenant.string
## NOTE
Tenants in the following status cannot perform the "Apply baselines to tenant" action.
## 3 - Deploying
## 6 - Expired
## 11 - Restoring
12 Retrieving setting
Baselines in the following status cannot be used for the "Apply baselines to tenant"
action.
1 - Retrieving settings
4 - Settings retrieval failed
## 6 - Draft
## 

## 93 / 174
## Request Sample
To use this API, send a POST request to the specified endpoint.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the ID of the applying baselines to tenant job displayed in the response body. For more
details on the HTTP status code, refer to Http Status Code.
https://graph-
us.avepointonlineservices.com/partner/external/v3/bm/customers/38c6a73d-****-57c6-
## ****-75b0f1959474/tenants/a2145aa5-****-26v7-****-7fffd6e0cc68/actions
## {
"actionType": "1", // The action that you want to perform on the tenant. 1
represents "Apply baselines to tenant"
## "data":
## [
## {
"baselineId": "e12922f4-****-45b7-****-3a1c162b4cf2", // The ID of
the baseline
"rankingOrder": 1 // The ranking order of the baseline among all
applied baselines
## },
## {
"baselineId": "b4c84bff-****-87b2-****-3a1c16243555",
"rankingOrder": 2
## }
## ]
## }
## {
"jobId": "7f3b241b-****-27s7-****-3a1c395524t6" // The ID of the applying
baselines to tenant job
## }

## 94 / 174
Retrieve Matched Risk Rules of Tenant
Use this API to retrieve all matched risk rules for a specific tenant in Elements.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPerm
/partner/external/v3/rm/customers/{customerId}/tenants/{tenantId}/detection/ruleselem
## Request
This section outlines the HTTP method and endpoint used to retrieve the matched risk rules
of a specific tenant.
MethodEndpoint
GET/partner/external/v3/rm/customers/{customerId}/tenants/{tenantId}/detection/r
URL Parameters
This section outlines the parameters required to specify which tenant's risk detection
details you want to retrieve.
ParameterDescriptionTypeRequired
customerIdThe customer IDstringYes
tenantIdThe tenant ID of the customerstringYes
## Query Parameters
This section outlines the parameters that can be used to specify the data source and status
of the risk rules you want to retrieve.

## 95 / 174
ParameterDescriptionTypeRequired
dataSourcesThe specific data sources to narrow down the results.
## 1 - Exchange
## 2 - Groups
## 3 - Teams
4 - SharePoint
5 - OneDrive
## 6 - Users
## 8 - Environments
## 9 - Connections
## 10 - Power Apps
## 11 - Power Automate
12 - Power BI
integerNo
statusThe status of risk rules.
## 0 - Disabled
## 1 - Enabled
integerNo
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.
ResponseDescriptionType
ruleIdThe ID of the rule.string
ruleNameThe display name of the rule.string
settingThe paramerter value configured for the rule.string
tenantIdThe tenant ID.string
customerIdThe customer ID.string
dataSourceThe data source of the matched objects.
## 1 - Exchange
## 2 - Groups
## 3 - Teams
4 - SharePoint
integer

## 96 / 174
ResponseDescriptionType
5 - OneDrive
## 6 - Users
## 8 - Environments
## 9 - Connections
## 10 - Power Apps
## 11 - Power Automate
12 - Power BI
hitItemCountThe number of objects that match the risk rule.integer
## Request Sample
To use this API, send a GET request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://graph-
us.avepointonlineservices.com/partner/external/v3/rm/customers/d926b068-****-4830-
## ****-fd2a****4e99/tenants/0eaab044-****-4a92-****-93c6****711e/detection/rules
## {
## "result": [
## {
"ruleId": "00000002-****-4830-****-00000019", // The ID of the rule
"ruleName": "Users without MFA enabled", // The display name of the rule
"setting": null, // The parameter value configured for the rule
"tenantId": "be4cdf40-****-4830-****-ab96****8246", // The tenant ID
"customerId": "292b68c5-****-0d40-****-2865****7eaf", // The customer ID
"dataSource": 6, // The data source of the matched objects, Users
"hitItemCount": 161 // The number of objects that match the risk rule
## },
## {
"ruleId": "00000002-****-4A52-****-00000023",
"ruleName": "Global administrator without a password expiration date",
"setting": null,

## 97 / 174
"tenantId": "be4cdf40-****-7eb7-****-ab96****8246",
"customerId": "292b68c5-****-0d40-****-2865****7eaf",
"dataSource": 6,
"hitItemCount": 1
## }
## ]
## }

## 98 / 174
Retrieve Matched Objects of Specific Risk
## Rule
Use this API to retrieve the objects that violate a specific risk rule within a specific tenant in
## Elements.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
## API
/partner/external/v3/rm/customers/{customerId}/tenants/{tenantId}/detection/rules/{rule
items
## Request
This section outlines the HTTP method and endpoint used to retrieve the violated objects
for a speific risk rule within a tenant.
MethodEndpoint
GET/partner/external/v3/rm/customers/{customerId}/tenants/{tenantId}/detection/r
items
URL Parameters
This section outlines the parameters required to specify which risk rule's detection details
you want to retrieve.
ParameterDescriptionTypeRequired
customerIdThe customer IDstringYes
tenantIdThe tenant ID of the customerstringYes
ruleIdThe ID of the risk rulestringYes

## 99 / 174
## Query Parameters
This section outlines the parameters that allow users to specify pagination.
ParameterDescriptionTypeRequired
pageIndexThe starting number of the page to get the violated
objects. The default value is 1.
integerNo
pageSizeThe number of objects to display on one page. The
default value is 50 and the maximum value allowed is
## 100.
integerNo
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.
ElementsDescriptionType
metaDataThe response's metadata.object
pageIndexThe current display page.integer
pageSizeThe number of objects on the display page.integer
totalCountThe total number of objects matching the query parameters.integer
idThe record ID.string
objectIdThe object ID.string
tenantIdThe tenant ID.string
customerIdThe customer ID.string
dataSourceThe object's data source.
## 1 - Exchange
## 2 - Groups
## 3 - Teams
4 - SharePoint
5 - OneDrive
## 6 - Users
## 8 - Environments
integer

## 100 / 174
ElementsDescriptionType
## 9 - Connections
## 10 - Power Apps
## 11 - Power Automate
12 - Power BI
detailThe detailed information of the object.object
Exchange mailbox details
PropertyDescriptionType
mailboxNameThe display name of the mailbox.string
mailboxEmailAddressThe email address.string
storageUsedThe used storage of the mailbox. The unit is MB.integer
prohibitSendReceiveQuotaThe prohibit send and recieve quota of the mailbox.
The unit is MB.
integer
recipientTypeThe recipient type of the mailbox.
1 - User mailbox
2 - Shared mailbox
4 - Room mailbox
8 - Equipment mailbox
16 - Mail contact
32 - Mail user
64 - Guest mail user
128 - Discovery mailbox
256 - Legacy mailbox
512 - Linked mailbox
1024 - Linked room mailbox
2048 - Team mailbox
4096 - Dynamic distribution group
8192 - Group mailbox
16384 - Mail forest contact
32768 - Mail-enabled non-universal group
65536 - Universal distribution group
131072 - Universal security group
262144 - Public folder
integer

## 101 / 174
PropertyDescriptionType
524288 - Public folder mailbox
1048576 - Remote equipment mailbox
2097152 - Remote room mailbox
4194304 - Remote shared mailbox
8388608 - Remote Team mailbox
16777216 - Remote user mailbox
33554432 - Room list
67108864 - Scheduling mailbox
createdDateThe created date and time of the mailbox in ISO
8601 format.
string
lastActivityDateThe date and time of the mailbox's last activity in
ISO 8601 format.
string
prohibitSendQuotaThe prohibit send quota of the mailbox. The unit is
## MB.
integer
markThe status of the mailbox whether it is marked as
fix ed.
## 0 - No
## 1 - Yes
integer
Group details
ResponseDescriptionType
groupNameThe display name of the group.string
groupEmailAddressThe email address of the group.string
createdByThe creator name of the group.string
groupTypeThe type of group.
## 1 - Microsoft 365 Group
2 - Security group
4 - Distribution group
8 - Mail-enabled security group
## -1 - Unknown
integer

## 102 / 174
ResponseDescriptionType
ownerCountThe number of owners in the group.integer
memberCountThe number of members in the group.integer
createdDateThe created date and time of the group in ISO 8601
format.
string
lastActivityDateThe date and tiem of the group's last activity in ISO 8601
format.
string
markThe status of the group whether it is marked as fixed.
## 0 - No
## 1 - Yes
integer
sourceTypeThe source type of the group.
## 0 - None
## 1 - Cloud
## 2 - On-premises
## 4 - Hybrid
integer
Team details
ResponseDescriptionType
teamsNameThe display name of the Team.string
teamsUrlThe URL of the Team site.string
createdByThe creator name of the Team.string
ownerCountThe number of owners in the Team.integer
memberCountThe number of members in the Team.integer
lastActivityDateThe date and time of the Team's last activity in ISO 8601
format.
string

## 103 / 174
ResponseDescriptionType
markThe status of the Team whether it is marked as fixed.
## 0 - No
## 1 - Yes
integer
latestCampaignInfoThe detailed information about the Team's campaign.string
Site details
ResponseDescriptionType
siteNameThe display name of the site.string
siteUrlThe site URL.string
createdByThe creator name of the site.string
storageUsedThe used storage of the site. The unit is MB.integer
ownerCountThe number of owners in the site.integer
memberCountThe number of members in the site.integer
createdDateThe created date and time of the site in ISO 8601 format.string
lastActivityDateThe date and time of the site's last activity in ISO 8601
format.
string
markThe status of the site whether it is marked as fixed.
## 0 - No
## 1 - Yes
integer
latestCampaignInfoThe detailed information about the site's campaign.string
lockStateThe lock status of the site.
## 0 - Unknown
## 1 - Unlocked
2 - Read only
3 - No access
integer
OneDrive details:

## 104 / 174
ResponseDescriptionType
displayNameThe display name of the OneDrive.string
urlThe OneDrive URL.string
adminCountThe number of admins.integer
storageUsedThe used storage of the OneDrive. The unit is MB.integer
storageLimitThe storage limit of the OneDrive. The unit is MB.integer
changeFileCountThe number of file modifications.integer
guestsCountThe number of guests in the OneDrive.integer
markThe status of the OneDrive whether it is marked as fixed.
## 0 - No
## 1 - Yes
integer
Environment details:
ResponseDescriptionType
environmentNameThe display name of the environment.string
environmentMakerCountThe number of environment makers.integer
regionThe environment's region.
## -1 - None
## 0 - United States
## 1 - Europe
## 2 - Asia
## 3 - Australia
## 4 - India
## 5 - Japan
## 6 - Canada
## 7 - United Kingdom
## 8 - United States
## 9 - South America
## 10 - France
## 11 - Switzerland
integer

## 105 / 174
ResponseDescriptionType
## 12 - Germany
## 13 - Korea
## 14 - Norway
## 15 - United Arab Emirates
16 - US Gov
## 17 - South Africa
## 18 - Sweden
19 - US Gov High
typeThe environment type.
## 1 - Default
## 2 - Trial
## 4 - Sandbox
## 8 - Production
## 16 - Teams
## 32 - Trial (subscription-based)
## 64 - Developer
integer
createdDateThe created date and time of the environment in ISO
8601 format.
string
lastActivityDateThe date and time of the environment's last activity
in ISO 8601 format.
string
totalUsageThe environment's total usage. The unit is Bytes.integer
markThe status of the environment whether it is marked
as fix   ed.
## 0 - No
## 1 - Yes
integer
creatorNameThe creator name of the environment.string
creatorEmailThe email address of the creator.string
adminCountThe number of admins in the environment.integer
guestUserCountThe number of guest users in the environment.integer

## 106 / 174
Connection details:
ResponseDescriptionType
connectionNameThe display name of the connection.string
parentEnvironmentThe parent environment of the connection.string
createdByThe creator name of the connectionstring
createdDateThe created date and time of the connection in ISO 8601
format.
string
markThe status of the connection whether it is marked as fixed.
## 0 - No
## 1 - Yes
integer
Power App details:
ResponseDescriptionType
appNameThe display name of the Power App.string
environmentThe environment of the Power App.string
createdByThe creator name of the Power App.string
guestUserCountThe number of guest users in the Power App.integer
includedInSolutionsThe status whether the Power App is included in a
solution.
## 0 - No
## 1 - Yes
integer
coOwnerCountThe number of co-owners in the app.integer
lastSignInThe time when users last signed in to the app in ISO 8601
format.
string
lastLaunchTimeThe time when users last launched the app in ISO 8601
format.
string
createdDateThe created date and time of the app in ISO 8601 format.string

## 107 / 174
ResponseDescriptionType
markThe status of the app whether it is marked as fixed.
## 0 - No
## 1 - Yes
integer
Flow details:
ResponseDescriptionType
flowNameThe display name of flow.string
environmentThe environment of the flow.string
guestsCountThe number of guests in the flow.integer
creatorNameThe creator name of the flow.string
typeThe flow type.
## 0 - Unknown
## 1 - Instant
## 2 - Automated
## 4 - Scheduled
8 - Desktop flow
integer
includedInSolutionsThe status whether the flow is included in a solution.
## 0 - No
## 1 - Yes
integer
coOwnerCountThe number of co-owners in the flow.integer
createdDateThe created date and time of the flow in ISO 8601 format.string
lastActivityDateThe date and time of the flow's last activity in ISO 8601
format.
string
lastSignInThe time when users last signed in to the flow.string

## 108 / 174
ResponseDescriptionType
markThe status of the flow whether it is marked as fixed.
## 0 - No
## 1 - Yes
integer
Power BI details:
ResponseDescriptionType
workspaceNameThe display name of the Power BI workspace/report.string
capacityNameThe capacity name of the Power BI workspace.string
artifactNameThe artifact name.string
workspaceThe parent workspace name.string
sensitivityThe sensitivity level of the Power BI workspace/report.string
adminCountThe number of admins.integer
lastActivityDateThe date and time of the last activity in the Power BI
workspace/report in ISO 8601 format.
string
createdDateThe created date and time of the Power BI workspace/report
in ISO 8601 format.
string
guestUserCountThe number of guest users.integer
reportCountThe number of Power BI reports.integer
markThe status of the workspace/report whether it is marked as
fix ed.
## 0 - No
## 1 - Yes
integer
userCountThe number of users in the Power BI workspace/report.integer
User details:

## 109 / 174
ResponseDescriptionType
userNameThe user's display name.string
userEmailAddressThe user's email address.string
userRolesThe user role.string
upnThe User Principal Name of the user.string
userTypeThe user type.
## 1 - Guest
## 2 - Member
integer
MFAControlledViaCapThe user's MFA status.bool
lastSignInThe time when the user last signed in to Microsoft 365 in
ISO 8601 format.
string
lastActivityDateThe date and time of the user's last activity in ISO 8601
format.
string
createdDateThe created date and time of the user in ISO 8601
format.
string
signInCountThe number of the user's sign-ins.integer
markThe status of the user whether it is marked as fixed.
## 0 - No
## 1 - Yes
integer
sourceTypeThe source type of the user.
## 0 - None
## 1 - Cloud
## 2 - On-premises
## 4 - Hybrid
integer
License details:

## 110 / 174
ResponseDescriptionType
licenseCountThe license count.integer
licenseDisplayNameThe license display name.string
licenseKeyNameThe license key name.string
markThe status of the license whether it is marked as fixed.
## 0 - No
## 1 - Yes
integer
## Request Sample
To use this API, send a GET request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://graph-
us.avepointonlineservices.com/partner/external/v3/rm/customers/d926b068-****-4830-
## ****-fd2a****4e99/tenants/0eaab044-****-4a92-
****-93c6****711e/detection/rules/00000002-9E63-4A52-9946-00000036/hit-items
## {
## "data": [
## {
## "detail": {
"groupName": "20240820 teamsite", // The display name of the group
"groupEmailAddress": "2024****@****.onmicrosoft.com", // The email
address of the group
"createdBy": "", // The creator of the group
"groupType": 1, // The type of group, Microsoft 365 Group
"ownerCount": 1, // The number of owners in the group
"memberCount": 4, // The number of members in the group
"createDate": "2024-08-20T10:55:29.0000000Z", // The created date
and time of the group
"lastActivityDate": "2025-07-10T00:00:00.0000000Z", // The date and
time of the group's last activity

## 111 / 174
"mark": 0, // The status of the group whether it is marked as fixed,
not fixed
"sourceType": 1 // The source type of the group, Cloud
## },
"id": "5824e186-****-9a60-****-e2aa****ac16", // The record ID
"objectid": "e6950ad1-****-1a06-****-151a****0d1f", // The object ID
"ruleId": "00000002-****-4A52-****-00000036", // The ID of the risk rule
"tenantId": "0eaab044-****-4a92-****-93c6****711e", // The tenant ID
"customerId": "d926b068-****-4830-****-fd2a****4e99", // The customer ID
"dataSource": 2 // The object's data source, Groups
## }
## ],
"metaData": {
"pageIndex": 1, // The current display page
"pageSize": 50, // The number of objects on the display page
"totalCount": 1 // The total number of objects matching the query parameters
## }
## }

## 112 / 174
Retrieve Information of Security Users
Use this API to retrieve information of security users in a customer's tenant.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
## API
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/overview/security/use
## Request
This section outlines the details of the HTTP method and endpoint used to retrieve
information of security users in a customer's tenant.
MethodEndpoint
GET/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/overview/se
URL Parameters
This section outlines the parameters required to specify the customer's tenant to retrieve
its secuirty users.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes
tenantIdThe ID of the tenant.stringYes
## Query Parameters
This section outlines the parameters optional required to specify paging information about
the users you want to retrieve.

## 113 / 174
ParameterDescriptionTypeRequired
pageIndexThe starting number of the page to get security users.
The default value is 1.
integerNo
pageSizeThe number of objects to display on one page. The
default value is 100.
integerNo
statusThe status of the user that you want to retrieve.
0 - MFA disabled
1 - Sign-in blocked
2 - Password expired
3 - High risk
4 - Medium risk
## 5 - Compliance
## 6 - Inactive
7 - Pending deletion
8 - Test user
integerNo
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.
ResponseDescriptionType
idThe ID of the user.string
userPrincipalNameThe user principle name.string
mailThe email of the user.string
displayNameThe display name of the user.string
firstNameThe first name of the user.string
lastNameThe last name of the user.string
employeeIdThe employee ID of the user.string
locationThe location of the user.string
companyThe company of the user.string

## 114 / 174
ResponseDescriptionType
departmentThe department of the user.string
mobileThe mobile of the user.string
jobTitleThe job title of the user.string
isTestUserIndicates whether this is a test user account for
development purposes.
bool
ageThe password age of the user.integer
startDateThe start date in ISO 8601 format when the user account
can sign in Microsoft 365.
string
endDateThe date in ISO 8601 format when the user account will be
blocked from signing in.
string
countryOrRegionThe country or region of the user.string
statusThe current status of the user.
0 - MFA disabled
1 - Sign-in blocked
2 - Password expired
3 - High risk
4 - Medium risk
## 5 - Compliance
## 6 - Inactive
7 - Pending deletion
8 - Test user
integer
pageIndexThe current display page.integer
pageSizeThe number of objects on the display page.integer
totalCountThe total number of objects matching the query
parameters.
integer
## Request Sample
To use this API, send a GET request to the specified endpoint, including necessary
parameters as defined in the references.

## 115 / 174
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://graph.avepointonlineservices.com/partner/external/v3/um/customers/966f35cc-
## ****-87b4-****-25cdbcf82a07/tenants/0c7715b3-****-81b6-****-
f3634dcfacec/overview/security/users
## {
## "data": [
## {
"id": "c2aa00d3-****-40aa-****-9e9c79232bff", // The ID of the user
"userPrincipalName": "kevin@domain.com", // The user principle name
"displayName": "Kevin Mark", // The display name of the user
"firstName": "Kevin", // The first name of the user
"lastName": "Mark", // The last name of the user
"department": "DEV", // The department of the user
"mobile": "11122", // The mobile of the user
"jobTitle": "Software developer", // The job title of the user
"mail": "tony@domain.com", // The mail of the user
"location": "location", // The office location of the user
"employeeId": "643477", // The employee ID of the user
## "status": [
0, // The status of the user. 0 represents "MFA disabled"
1 // The status of the user. 1 represents "Sign-in blocked"
## ],
"isTestUser": false, // Indicates whether this is a test user account
for development purposes
"age": 12, // The password age of the user
"startDate": "1970-01-01T00:00:00Z", // The start date in ISO 8601
format when the user account can sign in Microsoft 365
"endDate": "1970-01-01T00:00:00Z", // The date in ISO 8601 format when
the user account will be blocked from signing in
"company": "BK Company", // The company of the user
"countryOrRegion": "Slovenia" // The country or region of the user
## }
## ],
## "metadata": {
"pageIndex": 1, // The current display page
"pageSize": 50, // The number of objects on the display page
"totalCount": 1 // he total number of objects matching the query parameters

## 116 / 174
## }
## }

## 117 / 174
Retrieve Information of a Specific User
Use this API to retrieve information of a specific user in a customer's tenant.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration
APIPerm
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}eleme
## Request
This section outlines the details of the HTTP method and endpoint used to retrieve
information of a specific user in a customer's tenant.
MethodEndpoint
GET/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{user
URL Parameters
This section describes the query parameters that can be added to the URL when sending a
GET request, allowing you to retrieve information of a user according to your specific
requirements and preferences.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes
tenantIdThe ID of the tenant.stringYes
userIdThe unique identifier of the user.stringYes

## 118 / 174
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested user information displayed in the response body.
ResponseDescriptionType
idThe ID of the user.string
managerThe manager of the user.string
firstNameThe first name of the user.string
lastNameThe last name of the user.string
displayNameThe display name of the userstring
jobTitleThe job title of the user.string
employeeIdThe employee ID of the user.string
alternateEmailAddressThe alternate email address of the user.string
companyThe company of the user.string
departmentThe department of the user.string
locationThe location of the user.string
passwordNeverExpireIndicates whether the user's password is set to never
expire.
boolean
lastChangeDateThe date and time when the user account was last
modified.
string
ageThe calculated age of the user based on birthday.integer
isTestUserIndicates whether this is a test user account for
development purposes.
boolean
officePhoneThe business phone number of the user.string
mobileThe mobile phone number of the user.string
birthdayThe birthday of the user.string

## 119 / 174
ResponseDescriptionType
mailThe primary email address of the user.string
usageLocationThe usage location for the user account, typically a
country code (AF: Afghanistan).
string
preferredLanguageThe preferred language setting for the user interface.string
enforceStartIndicates whether account enforcement start date is
enabled.
boolean
enforceStartDateTimeThe date and time in ISO 8601 format when account
enforcement begins.
string
enforceEndIndicates whether account enforcement end date is
enabled.
boolean
enforceEndDateTimeThe date and time in ISO 8601 format when account
enforcement ends.
string
postalCodeThe postal code of the user.string
countryRegionThe country or region where the user is located.string
stateThe state or province where the user is located.string
addressThe street address of the user's location.string
loginNameThe login name or user principal name used for
authentication.
string
statusThe current status of the user account.
0 - MFA disabled
1 - Sign-in blocked
2 - Password expired
3 - High risk
4 - Medium risk
## 5 - Compliance
## 6 - Inactive
7 - Pending deletion
8 - Test user
integer

## 120 / 174
## Request Sample
To use this API, send a GET request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://graph.avepointonlineservices.com/partner/external/v3/um/customers/966f35cc-
## ****-****-****-25cdbcf82a07/tenants/0c7715b3-****-4c4c-****-
f3634dcfacec/users/7c18fd6f-****-89b6-****-5725fa9edc3f
## {
"id": "7c18fd6f-****-89b6-****-5725fa9edc3f", // The ID of the user
"manager": "user@domain.com", // The manager of the user
"firstName": "Tony", // The first name of the user
"lastName": "Brown", // The last name of the user
"displayName": "Tony Brown", // The display name of the user
"jobTitle": "IT", // The job title of the user
"employeeId": "099999", // The employee ID of the user
"alternateEmailAddress": [
"Tony_Al@domain.com" // The alternate email address of the user
## ],
"company": "Organization ABC", // The company of the user
"department": "DEV", // The department of the user
"location": "2298", // The location of the user
"passwordNeverExpire": true, // Indicates whether the user's password is set to
never expire
"lastChangeDate": "1970-01-01T00:00:00Z", // The date and time when the user
account was last modified
"age": 37, // The calculated age of the user based on birthday
"isTestUser": true, // Indicates whether this is a test user account for
development purposes
"officePhone": "232****9754", // The business phone number of the user
"mobile": "323****76", // The mobile phone number of the user.
"birthday": "1970-01-01T00:00:00Z", // The birthday of the user
"mail": "tony@domain.com", // The primary email address of the user
"usageLocation": "AF", // The usage location for the user account, typically a
country code
"preferredLanguage": "af-NA", // The preferred language setting for the
user interface

## 121 / 174
"enforceStart": false, // Indicates whether account enforcement start date
is enabled
"enforceStartDateTime": "1970-01-01T00:00:00Z", // The date and time in ISO 8601
format when account enforcement begins
"enforceEnd": false, // Indicates whether account enforcement end date
is enabled
"enforceEndDateTime": "1970-01-01T00:00:00Z", // The date and time in ISO 8601
format when account enforcement ends
"postalCode": "2121", // The postal code of the user
"countryRegion": "United States", // The country or region where the user
is located
"state": "Los Angeles", // The state or province where the user is located
"address": "Rothera Research Station", // The street address of the
user's location
"loginName": "tony@domain.com", // The login name or user principal name used
for authentication
## "status":  [
0, // The current status of the user. 0 represents "MFA disabled"
1 // The current status of the user. 1 represents "Sign-in blocked"
## ],
## }

## 122 / 174
Retrieve Information of Multiple Users
Use this API to retrieve information of multiple users in a customer's tenant.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPermiss
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/batchelement
## Request
This section outlines the HTTP method and endpoint used to retrieve information of
multiple users in a customer's tenant.
MethodEndpoint
POST/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/batch
URL Parameters
This section outlines the parameters required to specify which customer's tenant you want
to retrieve.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes
tenantIdThe ID of the tenant.stringYes
## Query Parameters
This section outlines the parameters optional required to specify paging information about
the users you want to retrieve.

## 123 / 174
ParameterDescriptionTypeRequired
pageIndexThe starting number of the page to get users. The
default value is 1.
integerNo
pageSizeThe default value is 50 and the maximum value
allowed is 100.
integerNo
## Request Body
This section outlines the request body required to specify which users you want to retrieve.
ParameterDescriptionTypeRequired
userIdsThe unique identifiers of users.string[]No
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.
ResponseDescriptionType
idThe ID of the user.string
userPrincipalNameThe user principle name.string
mailThe email of the user.string
displayNameThe display name of the user.string
firstNameThe first name of the user.string
lastNameThe last name of the user.string
employeeIdThe employee ID of the user.string
locationThe location of the user.string
companyThe company of the user.string
departmentThe department of the user.string
mobileThe mobile of the user.string

## 124 / 174
ResponseDescriptionType
jobTitleThe job title of the user.string
isTestUserIndicates whether the user account is a test user for
development purposes.
bool
ageThe password age of the user.integer
startDateThe start date in ISO 8601 format when the user account
can sign in to Microsoft 365.
string
endDateThe date in ISO 8601 format when the user account will be
blocked from signing in.
string
countryOrRegionThe country or region of the user.string
statusThe current status of the user account.
0 - MFA disabled
1 - Sign-in blocked
2 - Password expired
3 - High risk
4 - Medium risk
## 5 - Compliance
## 6 - Inactive
7 - Pending deletion
8 - Test user
integer
pageIndexThe page index of current request.integer
pageSizeThe user number will be retrieved in one request.integer
totalCountThe total number count that match the request.integer
## Request Sample
To use this API, send a GET request to the specified endpoint, including necessary
parameters as defined in the references.
https://graph.avepointonlineservices.com/partner/external/v3/um/customers/966f35cc-
****-25v7-****-25cdbcf82a07/tenants/0c7715b3-****-17b9-****-f3634dcfacec/users/batch

## 125 / 174
## Request Body Sample
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
## {
"userIds":["c2aa00d3-****-36v7-****-9e9c79232bff"]
## }
## {
## "data": [
## {
"id": "c2aa00d3-****-36v7-****-9e9c79232bff", // The ID of the user
"userPrincipalName": "tony@domain.com", // The user principle name
"displayName": "Kevin Mark", // The display name of the user
"firstName": "Kevin", // The first name of the user
"lastName": "Mark", // The last name of the user
"department": "DEV", // The department of the user
"mobile": "11122", // The mobile of the user
"jobTitle": "Software developer", // The job title of the user
"mail": "tony@domain.com", // The mail of the user
"location": "location", // The office location of the user
"employeeId": "643477", // The employee ID of the user
## "status": [
0, // The status of the user. 0 represents "MFA disabled"
1 // The status of the user. 1 represents "Sign-in blocked"
## ],
"isTestUser": false, // Indicates whether the user abbount is a test
user for development purposes
"age": 12, // The password age of the user
"startDate": "1970-01-01T00:00:00Z", // The start date in ISO 8601
format when the user account can sign in to Microsoft 365
"endDate": "1970-01-01T00:00:00Z", // The date in ISO 8601 format when
the user account will be blocked from signing in
"company": "Organization ABC", // The company of the user
"countryOrRegion": "Slovenia" // The country or region of the user
## }
## ],
## "metadata": {
"pageIndex": 1, // The current display page
"pageSize": 50, // The number of objects on the display page

## 126 / 174
"totalCount": 1 // The total number of objects matching the query parameters
## }
## }

## 127 / 174
Update Information of a Specific User
Use this API to update information of a specific user in a customer's tenant.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
## API
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}/accoun
information
## Request
This section outlines the details of the HTTP method and endpoint used to update
information of a specific user in a customer's tenant.
MethodEndpoint
PUT/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{user
information
URL Parameters
This section describes the query parameters that can be added to the URL when sending a
PUT request, allowing you to update information of a specific user in a customer's tenant
according to your specific requirements and preferences.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes
tenantIdThe ID of the tenant.stringYes
userIdThe unique identifier of the user.stringYes

## 128 / 174
## Request Body
This section outlines the required fields to update the information of a specific user in a
cutomer's tenant.
ParameterDescriptionTypeRequired
mailThe mail of the user. The maximum length is
256 characters.
stringYes
usageLocationThe usage location of the user. The
maximum length is 128 characters. For
details, refer to Usage Locations.
stringYes
preferredLanguageThe preferred language of the user. For
details, refer to Preferred Languages.
stringYes
enforceStartIndicates whether account enforcement start
date is enabled.
boolYes
enforceStartDateTimeThe date and time in ISO 8601 format when
account enforcement begins.
stringYes
enforceEndIndicates whether account enforcement end
date is enabled.
boolYes
enforceEndDateTimeThe date and time in ISO 8601 format when
account enforcement ends.
stringYes
## Response
If the request has been successfully processed, a 204 No Content response will be returned.
For more details on the HTTP status code, refer to Http Status Code.
## Request Sample
To use this API, send a PUT request to the specified endpoint, including necessary
parameters as defined in the references.
https://graph.avepointonlineservices.com/partner/external/v3/um/customers/966f35cc-
## ****-57v8-****-25cdbcf82a07/tenants/0c7715b3-****-25x9-****-
f3634dcfacec/users/7c18fd6f-****-24v6-****-5725fa9edc3f/account-information

## 129 / 174
## Request Body Sample
## {
"mail": "tony@domain.com", // The mail of the user
"usageLocation": "AF", // The usage location of the user
"preferredLanguage": "af-NA", // The preferred language of the user
"enforceStart": true, // Indicates whether account enforcement start date
is enabled
"enforceStartDateTime": "1970-01-01T00:00:00Z", // The date and time in ISO 8601
format when account enforcement begins
"enforceEnd": true, // Indicates whether account enforcement end date is enabled
"enforceEndDateTime": "1970-01-01T00:00:00Z" // The date and time in ISO 8601
format when account enforcement ends
## }

## 130 / 174
Update Birthday of a Specific User
Use this API to update the birthday of a specific user in a customer's tenant.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
## API
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}/birthd
## Request
This section outlines the details of the HTTP method and endpoint used to update the
birthday of a specific user in a customer's tenant.
MethodEndpoint
PUT/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{user
URL Parameters
This section describes the query parameters that can be added to the URL when sending a
PUT request, allowing you to update the birthday of a user according to your specific
requirements and preferences.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes
tenantIdThe ID of the tenant.stringYes
userIdThe unique identifier of the user.stringYes

## 131 / 174
## Request Body
This section outlines the required fields to update the birthday of a specific user in a
customer's tenant.
ParameterDescriptionTypeRequired
birthdayThe birthday of the user in ISO 8601 format.stringYes
## Response
If the request has been successfully processed, a 204 No Content response will be returned.
For more details on the HTTP status code, refer to Http Status Code.
## Request Sample
To use this API, send a PUT request to the specified endpoint, including necessary
parameters as defined in the references.
## Request Body Sample
https://graph.avepointonlineservices.com/partner/external/v3/um/customers/966f35cc-
## ****-36v6-****-25cdbcf82a07/tenants/0c7715b3-****-18a7-****-
f3634dcfacec/users/7c18fd6f-****-26c3-****-5725fa9edc3f/birthday
## {
"birthday": "1970-01-01T00:00:00Z" // The birthday of the user in ISO 8601 format
## }

## 132 / 174
Update Contact Information of a Specific
## User
Use this API to update the contact information of a specific user in a customer's tenant.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
## API
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}/contac
information
## Request
This section outlines the details of the HTTP method and endpoint used to update the
contact information of a specific user in a customer's tenant.
MethodEndpoint
PUT/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{user
information
URL Parameters
This section describes the query parameters that can be added to the URL when sending a
PUT request, allowing you to update the contact information of a user according to your
specific requirements and preferences.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes

## 133 / 174
ParameterDescriptionTypeRequired
tenantIdThe ID of the tenant.stringYes
userIdThe unique identifier of the user.stringYes
## Request Body
This section outlines the required fields to update the contact information of a specific user
in a cutomer's tenant.
ParameterDescriptionTypeRequired
officePhoneThe business phone number of the user. The maximum
length is 64 characters.
stringYes
mobileThe mobile phone number of the user. The maximum
length is 64 characters.
stringYes
## Response
If the request has been successfully processed, a 204 No Content response will be returned.
For more details on the HTTP status code, refer to Http Status Code.
## Request Sample
To use this API, send a PUT request to the specified endpoint, including necessary
parameters as defined in the references.
## Request Body Sample
https://graph.avepointonlineservices.com/partner/external/v3/um/customers/966f35cc-
## ****-25v6-****-25cdbcf82a07/tenants/0c7715b3-****-46s7-****-
f3634dcfacec/users/7c18fd6f-****-87c6-****-5725fa9edc3f/contact-information
## {
"officePhone": "323-333-111", // The business phone number of the user
"mobile": "323-344-409" // The mobile phone number of the user
## }

## 134 / 174
Update Alternate Email Address of a Specific
## User
Use this API to update the alternate email address of a specific user in a customer's tenant.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
## API
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}/altern
email-address
## Request
This section outlines the details of the HTTP method and endpoint used to update the
alternate email address of a specific user in a cutomer's tenant.
MethodEndpoint
PUT/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{user
email-address
URL Parameters
This section describes the query parameters that can be added to the URL when sending a
PUT request, allowing you to update the alternate email address of a user according to your
specific requirements and preferences.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes

## 135 / 174
ParameterDescriptionTypeRequired
tenantIdThe ID of the tenant.stringYes
userIdThe unique identifier of the user.stringYes
## Request Body
This section outlines the required fields to update the alternate email address of a specific
user in a cutomer's tenant.
ParameterDescriptionTypeRequired
alternateEmailAddressThe alternate email address of the user.string[]Yes
## Response
If the request has been successfully processed, a 204 No Content response will be returned.
For more details on the HTTP status code, refer to Http Status Code.
## Request Sample
To use this API, send a PUT request to the specified endpoint, including necessary
parameters as defined in the references.
## Request Body Sample
https://graph.avepointonlineservices.com/partner/external/v3/um/customers/966f35cc-
## ****-5902-****-25cd****2a07/tenants/0c7715b3-****-4dcf-****-
f363****acec/users/7c18fd6f-****-fa9e-****-5725****dc3f/alternate-email-address
## {
"alternateEmailAddress": [
"Tony@domain.com", // The alternate email address of the user
"Tony_alternate@domain.com"
## ]
## }

## 136 / 174
Update General Information of a Specific
## User
Use this API to update the general information of a specific user in a customer's tenant.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
## API
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}/genera
information
## Request
This section outlines the details of the HTTP method and endpoint used to update the
general information of a specific user in a customer's tenant.
MethodEndpoint
PUT/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{user
information
URL Parameters
This section describes the query parameters that can be added to the URL when sending a
PUT request, allowing you to update the general information of a user according to your
specific requirements and preferences.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes

## 137 / 174
ParameterDescriptionTypeRequired
tenantIdThe ID of the tenant.stringYes
userIdThe unique identifier of the user.stringYes
## Request Body
This section outlines the required fields to update the general information of a user.
ParameterDescriptionTypeRequired
firstNameThe first name of the user. The maximum length is 64
characters.
stringYes
lastNameThe last name of the user. The maximum length is 64
characters.
stringYes
displayNameThe display name of the user. The maximum length is
256 characters.
stringYes
jobTitleThe job title of the user.stringYes
employeeIdThe employee ID of the user. The maximum length is
16 characters.
stringYes
## Response
If the request has been successfully processed, a 204 No Content response will be returned.
For more details on the HTTP status code, refer to Http Status Code.
## Request Sample
To use this API, send a PUT request to the specified endpoint, including necessary
parameters as defined in the references.
## Request Body Sample
https://graph.avepointonlineservices.com/partner/external/v3/um/customers/966f35cc-
## ****-86a8-****-25cdbcf82a07/tenants/0c7715b3-****-35c6-****-
f3634dcfacec/users/7c18fd6f-****-98v3-****-5725fa9edc3f/general-information

## 138 / 174
## {
"firstName": "Tony", // The first name of the user
"lastName": "Brown", // The last name of the user
"displayName": "Tony Brown", // The display name of the user
"jobTitle" : "IT", // The job title of the user
"employeeId" : "e3f1a9b8-4d2c" // The employee ID of the user
## }

## 139 / 174
Update the Test User Property of a Specific
## User
Use this API to update the test user property of a specific user in a customer's tenant.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
## API
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}/istest
## Request
This section outlines the details of the HTTP method and endpoint used to update the test
user property of a specific user in a customer's tenant.
MethodEndpoint
PUT/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{user
URL Parameters
This section describes the query parameters that can be added to the URL when sending a
PUT request, allowing you to update the test user property of a user according to your
specific requirements and preferences.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes
tenantIdThe ID of the tenant.stringYes

## 140 / 174
ParameterDescriptionTypeRequired
userIdThe unique identifier of the user.stringYes
## Request Body
This section outlines the required fields to update the test user property of a specific user in
a customer's tenant.
ParameterDescriptionTypeRequired
isTestUserIndicates whether a user account is a test user for
development purposes.
boolYes
## Response
If the request has been successfully processed, a 204 No Content response will be returned.
For more details on the HTTP status code, refer to Http Status Code.
## Request Sample
To use this API, send a PUT request to the specified endpoint, including necessary
parameters as defined in the references.
## Request Body Sample
https://graph.avepointonlineservices.com/partner/external/v3/um/customers/966f35cc-
## ****-78d4-****-25cdbcf82a07/tenants/0c7715b3-****-89v1-****-
f3634dcfacec/users/7c18fd6f-****-86c9-****-5725fa9edc3f/istest
## {
"isTestUser" : true // Indicates whether a user account is a test user for
development purposes
## }

## 141 / 174
Update Manager of a Specific User
Use this API to update the manager of a specific user in a customer's tenant.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
## API
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}/manage
## Request
This section outlines the details of the HTTP method and endpoint used to update the
manager of a specific user in a customer's tenant.
MethodEndpoint
PUT/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{user
URL Parameters
This section describes the query parameters that can be added to the URL when sending a
PUT request, allowing you to update the manager of a user according to your specific
requirements and preferences.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes
tenantIdThe ID of the tenant.stringYes
userIdThe unique identifier of the user.stringYes

## 142 / 174
## Request Body
This section outlines the required fields to update the manager of a specific user in a
customer's tenant.
ParameterDescriptionTypeRequired
userPrincipalNameThe user principal name of the manager. The
maximum length is 1024 characters. For user
types other than cloud users, the
userPrincipalName property contains the
distinguished name (DN) of the manager.
Example: "userPrincipalName": "CN=Terry
Gu,DC=dev1,DC=com".
stringYes
## Response
If the request has been successfully processed, a 204 No Content response will be returned.
For more details on the HTTP status code, refer to Http Status Code.
## Request Sample
To use this API, send a PUT request to the specified endpoint, including necessary
parameters as defined in the references.
## Request Body Sample
https://graph.avepointonlineservices.com/partner/external/v3/um/customers/966f35cc-
## ****-4070-****-25cd****2a07/tenants/0c7715b3-****-4c4c-****-
f363****acec/users/7c18fd6f-****-4353-****-5725****dc3f/manager
## {
"userPrincipalName": "tony@domain.com" // The user principal name of the manager
## }

## 143 / 174
Update Office Information of a Specific User
Use this API to update the office information of a specific user in a customer's tenant.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
## API
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}/office
## Request
This section outlines the details of the HTTP method and endpoint used to update the office
information of a specific user in a cutomer's tenant.
MethodEndpoint
PUT/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{user
URL Parameters
This section describes the query parameters that can be added to the URL when sending a
PUT request, allowing you to update the office information of a user according to your
specific requirements and preferences.
ParameterDescriptionTypeRequired
customerIdThe customer ID of the customer.stringYes
tenantIdThe specific tenant ID of the customer.stringYes
userIdThe unique identifier of the user.stringYes

## 144 / 174
## Request Body
This section outlines the required fields to update the office information of a user.
ParameterDescriptionTypeRequired
companyThe company of the user. The maximum length is 64
characters.
stringYes
departmentThe department of the user. The maximum length is 64
characters.
stringYes
locationThe location of the user. The maximum length is 64
characters.
stringYes
## Response
If the request has been successfully processed, a 204 No Content response will be returned.
For more details on the HTTP status code, refer to Http Status Code.
## Request Sample
To use this API, send a PUT request to the specified endpoint, including necessary
parameters as defined in the references.
## Request Body Sample
https://graph.avepointonlineservices.com/partner/external/v3/um/customers/966f35cc-
## ****-98b1-****-25cdbcf82a07/tenants/0c7715b3-****-16b5-****-
f3634dcfacec/users/7c18fd6f-****-87b2-****-5725fa9edc3f/office
## {
"company": "Organization ABC", // The company of the user
"department": "09", // The department of the user
"location": "0711" // The location of the user
## }

## 145 / 174
Update Office Location Information of a
## Specific User
Use this API to update the office location information of a specific user in a customer's
tenant.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
## API
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}/office
information
## Request
This section outlines the details of the HTTP method and endpoint used to update the office
location information of a specific user in a cutomer's tenant.
MethodEndpoint
PUT/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{user
information
URL Parameters
This section describes the query parameters that can be added to the URL when sending a
PUT request, allowing you to update the office location information of a user according to
your specific requirements and preferences.

## 146 / 174
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes
tenantIdThe ID of the tenant.stringYes
userIdThe unique identifier of the user.stringYes
## Request Body
This section outlines the required fields to update the office location information of a user.
ParameterDescriptionTypeRequired
postalCodeThe postal code of the office. The maximum length
is 40 characters.
stringYes
countryRegionThe country or region of the office. The maximum
length is 255 characters. For details, refer to
Countries or Regions.
stringYes
stateThe state of the office. The maximum length is 128
characters.
stringYes
addressThe address of the office. The maximum length is
1024 characters.
stringYes
## Response
If the request has been successfully processed, a 204 No Content response will be returned.
For more details on the HTTP status code, refer to Http Status Code.
## Request Sample
To use this API, send a PUT request to the specified endpoint, including necessary
parameters as defined in the references.
## Request Body Sample
https://graph.avepointonlineservices.com/partner/external/um/v3/customers/966f35cc-
## ****-98b2-****-25cdbcf82a07/tenants/0c7715b3-****-16v8-****-
f3634dcfacec/users/7c18fd6f-****-91c6-****-5725fa9edc3f/office-information

## 147 / 174
## {
"postalCode": "2121", // The postal code of the office
"countryRegion": " Angola", // The country or region of the office
"state": "Luanda", // The state of the office
"address": "Dande" // The address of the office
## }

## 148 / 174
Update the Password Setting of a Specific
## User
Use this API to update the password setting of a specific user in a customer's tenant.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
## API
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{userId}/passwo
setting
## Request
This section outlines the details of the HTTP method and endpoint used to update the
password setting of a specific user in a customer's tenant.
MethodEndpoint
PUT/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/users/{user
setting
URL Parameters
This section describes the query parameters that can be added to the URL when sending a
PUT request, allowing you to update the password setting of a user according to your
specific requirements and preferences.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes

## 149 / 174
ParameterDescriptionTypeRequired
tenantIdThe ID of the tenant.stringYes
userIdThe unique identifier of the user.stringYes
## Request Body
This section outlines the required fields to update the password setting of a user.
ParameterDescriptionTypeRequired
passwordNeverExpireIndicates whether the user's password is set
to nerver expire.
boolYes
## Response
If the request has been successfully processed, a 204 No Content response will be returned.
For more details on the HTTP status code, refer to Http Status Code.
## Request Sample
To use this API, send a PUT request to the specified endpoint, including necessary
parameters as defined in the references.
## Request Body Sample
https://graph.avepointonlineservices.com/partner/external/v3/um/customers/966f35cc-
## ****-89b2-****-25cdbcf82a07/tenants/0c7715b3-****-27s3-****-
f3634dcfacec/users/7c18fd6f-****-36m7-****-5725fa9edc3f/password-setting
## {
"passwordNeverExpire" : true // Indicates whether the user's password is set to
nerver expire
## }

## 150 / 174
## Retrieve Workflow Information
Use this API to retrieve information of workflows in a customer's tenant.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
## API
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/overview/security/com
## Request
This section outlines the details of the HTTP method and endpoint used to retrieve
information of workflows in a customer's tenant.
MethodEndpoint
GET/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/overview/se
URL Parameters
This section describes the query parameters that can be added to the URL when sending a
GET request, allowing you to retrieve information of workflows in a customer's tenant
according to your specific requirements and preferences.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes
tenantIdThe ID of the tenant.stringYes
## Query Parameters

## 151 / 174
This section outlines the optional parameters used to specify the information for the type
you want to retrieve.
ParameterDescriptionTypeRequired
catagoryThe category of the risky actions.
1 - Network security
2 - Endpoint security
3 - Identity access
4 - Configuration security
integerNo
pageIndexThe starting number of the page to get objects. The
default value is 1.
integerNo
pageSizeThe default value is 50 and the maximum value
allowed is 100.
integerNo
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.
ResponseDescriptionType
workflowIdThe ID of the workflow.string
workflowDisplayNameThe display name of the workflow.string
## Request Sample
To use this API, send a GET request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://aostestpartnergcc.sharepointguild.com:5000/external/v3/um/customers/966f35cc
## -****-47vb-****-25cdbcf82a07/tenants/0c7715b3-****-91n4-****-
f3634dcfacec/overview/security/compliances/workflows

## 152 / 174
## {
## "data": [
## {
"workflowId": "8fc933ed-****-41fe-****-afbf326f27ff", // The ID of
the workflow
"workflowDisplayName": "User MFA disabled" // The display name of
the workflow
## }
## ],
## "metadata": {
"pageIndex": 1, // The current display page
"pageSize": 50, // The number of objects on the display page
"totalCount": 1 // The total number of objects matching the query parameters
## }
## }

## 153 / 174
## Retrieve Risky Action Count
Use this API to retrieve the risky action count in a customer's tenant.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
## API
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/overview/security/com
## Request
This section outlines the details of the HTTP method and endpoint used to retrieve the risky
action count in a customer's tenant.
MethodEndpoint
GET/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/overview/se
URL Parameters
This section describes the query parameters that can be added to the URL when sending a
GET request, allowing you to retrieve the risky action count in a customer's tenant
according to your specific requirements and preferences.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes
tenantIdThe ID of the tenant.stringYes
## Query Parameters

## 154 / 174
This section outlines the optional parameters used to specify the information for the type
you want to retrieve.
ParameterDescriptionTypeRequired
typesThe types of actions that you want to retrieve.
0 - Normal action
1 - Risky action
integerNo
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.
ResponseDescriptionType
riskyActionCountThe count of the risky actions in the tenant.integer
normalActionCountThe count of normal actions in the tenant.integer
## Request Sample
To use this API, send a GET request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://graph.avepointonlineservices.com/partner/external/v3/um/customers/966f35cc-
## ****-87b1-****-25cdbcf82a07/tenants/0c7715b3-****-88b2-****-
f3634dcfacec/overview/security/compliances/actions
## {
"riskyActionCount": 10, // The count of the risky actions in the tenant
"normalActionCount": 20 // The count of normal actions in the tenant
## }

## 155 / 174
## Retrieve Compliance Information
Use this API to retrieve compliance information of a specific workflow in a customer's
tenant.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
## API
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/overview/security/com
## Request
This section outlines the details of the HTTP method and endpoint used to retrieve
compliance information of a specific workflow in a customer's tennant.
MethodEndpoint
GET/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/overview/se
URL Parameters
This section describes the query parameters that can be added to the URL when sending a
GET request, allowing you to retrieve compliance information of a customer's tenant
according to your specific requirements and preferences.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes
tenantIdThe ID of the tenant.stringYes

## 156 / 174
ParameterDescriptionTypeRequired
workflowIdThe ID of the workflow.stringYes
## Query Parameters
This section outlines the parameters optional required to specify paging information about
the users you want to retrieve.
ParameterDescriptionTypeRequired
pageIndexThe starting number of the page to get objects. The
default value is 1.
integerNo
pageSizeThe default value is 50 and the maximum value
allowed is 100.
integerNo
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.
ResponseDescriptionType
riskUserCountThe number of users who trigger the risk based on the
workflow.
integer
last7DayFixCountThe number of fixed risky actions in last 7 days.integer
userDisplayNameThe display name of the risky user.string
userPrincipalNameThe user principal name of the risky user.string
userIdThe unique identifier of the risky user.string
loginIPThe IP address in which a user signs in to Microsoft 365.string
loginTimeThe sign-in time in ISO 8601 format when user signs in to
## Microsoft 365.
string
deviceNameThe name of the device that user uses to sign in to
## Microsoft 365.
string

## 157 / 174
ResponseDescriptionType
accessedFileNameThe name of the file that has been accessed.string
sensitiveInformationThe sensitive information of the file.string
accessTimeThe time in ISO 8601 format when the user accesses the
file.
string
## Request Sample
To use this API, send a GET request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://graph.avepointonlineservices.com/partner/external/v3/um/customers/966f35cc-
## ****-4070-****-25cd****2a07/tenants/0c7715b3-****-4dcf-****-
f363****acec/overview/security/compliances/workflows/4dbd4e4e-
## ****-4d38-****-2e22****b0c4
## {
"last7DayFixCount": 8, // The number of fixed risky actions in last 7 days
"riskUserCount": 12, // The number of users who trigger the risk based on
the workflow
## "data": [
## {
"userDisplayName": "Mark Kevin", // The display name of the risky user
"userPrincipalName": "mark@domain.onmicrosoft.com", // The user principal
name of the risky user
"userId": "c2aa00d3-****-40aa-****-9e9c79232bfe", // The unique identifier
of the risky user
"loginIps": [
## {
"loginIP": "23.98.***.140", // The IP address in which a user signs in
to Microsoft 365
"loginTime": "1970-01-01T00:00:00Z" // The sign-in time in ISO 8601
format when user signs in to Microsoft 365
## }

## 158 / 174
## ],
## "files": [
## {
"accessedFileName": "report.docx", // The name of the file that has
been accessed
"accessTime": "1970-01-01T00:00:00Z", // The in time in ISO 8601 format
when the user accesses the file
"sensitiveInformation": "Personal Data" // The sensitive information of
the file
## }
## ],
## "devices": [
## {
"deviceName": "DESKTOP-ABC123" // The name of the device that user uses
to sign into Microsoft 365
## }
## ]
## }
## ],
## "metadata": {
"pageIndex": 1, // The total number of objects matching the query parameters
"pageSize": 50, // The number of objects on the display page
"totalCount": 5 // The current display page
## }
## }

## 159 / 174
## Retrieve Sign-in Information
Use this API to retrieve users' sign-in information in a customer's tenant.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
## API
/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/overview/security/com
## Request
This section outlines the details of the HTTP method and endpoint used to retrieve users'
sign-in information in a customer's tenant.
MethodEndpoint
GET/partner/external/v3/um/customers/{customerId}/tenants/{tenantId}/overview/se
URL Parameters
This section describes the query parameters that can be added to the URL when sending a
GET request, allowing you to retrieve users' sign-in information in a customer's tenant
according to your specific requirements and preferences.
ParameterDescriptionTypeRequired
customerIdThe ID of the customer.stringYes
tenantIdThe ID of the tenant.stringYes
## Query Parameters

## 160 / 174
This section outlines the parameters optional required to specify paging information about
the users you want to retrieve.
ParameterDescriptionTypeRequired
pageIndexThe starting number of the page to get bjects. The
default value is 1.
integerNo
pageSizeThe default value is 50 and the maximum value
allowed is 100.
integerNo
riskyIndicate whether you want to retrieve only risky sign-
ins.
boolNo
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested user information displayed in the response body.
ResponseDescriptionType
idThe unique identifier of the sign-in record.string
loginTimeThe sign-in time in ISO 8601 format.long
userIdThe unique identifier of the user.string
userDisplayNameThe display name of the user.string
userPrincipalNameThe user principal name.string
ipThe IP address of the sign-in record.string
latThe latitude of the sign-in record.double
lonThe longitude of the sign-in record.double
countryThe country or region of the sign-in record.string
cityThe city of the sign-in record.string
isRiskThe risk status of the sign-in record.bool
## Request Sample

## 161 / 174
To use this API, send a GET request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://graph.avepointonlineservices.com/partner/external/v3/um/customers/966f35cc-
## ****-4070-****-25cd****2a07/tenants/0c7715b3-****-4c4c-****-
f363****acec/overview/security/compliances/signins
## {
## "data": [
## {
"id": "001f0090-****-60e5-****-b2c0****2500", // The unique identifier
of the sign-in record
"loginTime": "1970-01-01T00:00:00Z", //  The sign-in time in ISO
8601 format
"userId": "4140b563-****-dadc-****-5f44****f0fd", // The unique
identifier of the user
"userDisplayName": "Bob Mark", // The display name of the user.
"userPrincipalName": "Bob@domain.com", //  The user principal name
"ip": "74.207.240.85", // The IP address of the sign-in record
"lat": 37.56699, // The latitude of the sign-in record
"lon": -121.9827, // The longitude of the sign-in record
"country": "US", // The country or region of the sign-in record
"city": "Fremont", // The city of the sign-in record
"isRisk": false // The risk status of the sign-in record
## },
## ],
## "metadata": {
"pageIndex": 1, // The current display page
"pageSize": 50, // The number of objects on the display page
"totalCount": 1 // The total number of objects matching the query parameters
## }
## }

## 162 / 174
Retrieve Workspace Overview of Tenant
Use this API to retrieve the workspace overview statistics of a specific tenant in Elements.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
## APIP
/partner/external/v3/wm/customers/{customerId}/tenants/{tenantId}/overview/workspacee
## Request
This section outlines the HTTP method and endpoint used to retrieve the workspace
overview statistics. It provides a concise description of the action performed by the API call.
MethodEndpoint
GET/partner/external/v3/wm/customers/{customerId}/tenants/{tenantId}/overview/wo
URL Parameters
This section outlines the parameters required to specify which tenant's workspace overview
statistics you want to retrieve.
ParameterDescriptionTypeRequired
customerIdThe customer IDstringYes
tenantIdThe tenant ID of the customerstringYes
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.

## 163 / 174
ResponseDescriptionType
workspacesThe total number of workspaces.integer
teamsThe number of Teams.integer
sharePointSitesThe number of SharePoint sites.integer
oneDrivesThe number of OneDrives.integer
groupsThe number of groups.integer
exchangeMailboxesThe number of Exchange mailboxes.integer
activeWorkspacesThe number of active workspaces.integer
inactiveWorkspacesThe number of inactive workspaces.integer
orphanedWorkspacesThe total number of orphaned
workspaces.
integer
orphanedTeamsThe number of orphaned Teams.integer
orphanedSharePointSitesThe number of orphaned SharePoint
sites.
integer
orphanedOneDrivesThe number of orphaned OneDrives.integer
orphanedGroupsThe number of orphaned groups.integer
workspacesWithGuestUsersThe total number of workspaces with
guest users.
integer
teamsWithGuestUsersThe number of Teams with guest users.integer
sharePointSitesWithGuestUsersThe number of SharePoint sites with
guest users.
integer
oneDrivesWithGuestUsersThe number of OneDrives with guest
users.
integer
groupsWithGuestUsersThe number of groups with guest users.integer
reachingStorageLimitWorkspacesThe total number of workspaces that
have reached 90% of their storage limits.
integer

## 164 / 174
ResponseDescriptionType
reachingStorageLimitTeamsThe number of Teams that have reached
90% of their storage limits.
integer
reachingStorageLimitSharePointSitesThe number of SharePoint sites that have
reached 90% of their storage limits.
integer
reachingStorageLimitOneDrivesThe number of OneDrives that have
reached 90% of their storage limits.
integer
reachingStorageLimitGroupsThe number of groups that have reached
90% of their storage limits.
integer
reachingStorageLimitMailboxesThe number of mailboxes that have
reached 90% of their storage limits.
integer
## Request Sample
To use this API, send a GET request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://graph.avepointonlineservices.com/partner/external/v3/wm/customers/966f35cc-
## ****-4070-****-25cd****2a07/tenants/0c7715b3-****-4c4c-****-
f363****acec/overview/workspace
## {
"workspaces": 4285, // The total number of workspaces
"teams": 171, // The number of Teams
"sharePointSites": 865, // The number of SharePoint sites
"oneDrives": 12, // The number of OneDrives
"groups": 2989, // The number of groups
"exchangeMailboxes": 248, // The number of Exchange mailboxes
"activeWorkspaces": 159, // The number of active workspaces
"inactiveWorkspaces": 399, // The number of inactive workspaces
"orphanedWorkspaces": 264, // The total number of orphaned workspaces
"orphanedTeams": 56, // The number of orphaned Teams

## 165 / 174
"orphanedGroups": 192, // The number of orphaned groups
"orphanedSharePointSites": 15, // The number of orphaned SharePoint sites
"workspacesWithGuestUsers": 88, // The total number of workspaces with
guest users
"orphanedOneDrives": 1, // The number of orphaned OneDrives
"teamsWithGuestUsers": 13, // The number of Teams with guest users
"sharePointSitesWithGuestUsers": 37, // The number of SharePoint sites with
guest users
"oneDrivesWithGuestUsers": 0, // The number of OneDrives with guest users
"groupsWithGuestUsers": 38, // The number of groups with guest users
"reachingStorageLimitWorkspaces": 0, // The total number of workspaces that have
reached 90% of their storage limits
"reachingStorageLimitTeams": 0, // The number of Teams that have reached 90% of
their storage limits
"reachingStorageLimitSharePoint": 0, // The number of SharePoint sites that have
reached 90% of their storage limits
"reachingStorageLimitOneDrives": 0, // The number of OneDrives that have reached
90% of their storage limits
"reachingStorageLimitGroups": 0, // The number of groups that have reached 90%
of their storage limits
"reachingStorageLimitMailboxes": 0, // The number of mailboxes that have reached
90% of their storage limits
"reachingStorageLimitSharePointSites": 0 // The number of SharePoint sites that
have reached 90% of their storage limits
## }

## 166 / 174
Retrieve Workspace Compliance Statistics of
## Tenant
Use this API to retrieve the compliance statistics of workspaces for a specific tenant in
## Elements.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPerm
/partner/external/v3/wm/customers/{customerId}/tenants/{tenantId}/overview/data-
protection/compliance-rate
eleme
## Request
This section outlines the HTTP method and endpoint used to retrieve the compliance
statistics of workspaces. It provides a concise description of the action performed by the
API call.
MethodEndpoint
GET/partner/external/v3/wm/customers/{customerId}/tenants/{tenantId}/overview/da
protection/compliance-rate
URL Parameters
This section outlines the parameters required to specify which tenant's workspace
compliance statistics you want to retrieve.
ParameterDescriptionTypeRequired
customerIdThe customer IDstringYes
tenantIdThe tenant ID of the customerstringYes

## 167 / 174
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.
ResponseDescriptionType
workspacesInComplianceThe number of workspaces that are in
compliance.
integer
workspacesOutOfComplianceThe number of workspaces that are out of
compliance.
integer
## Request Sample
To use this API, send a GET request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://graph.avepointonlineservices.com/partner/external/v3/wm/customers/966f35cc-
## ****-4070-****-25cd****2a07/tenants/0c7715b3-****-4c4c-****-
f363****acec/overview/data-protection/compliance-rate
## {
"workspacesInCompliance": 2438, // The number of workspaces that are
in compliance
"workspacesOutOfCompliance": 1037 // The number of workspaces that are out
of compliance
## }

## 168 / 174
Retrieve Data Security Posture of Tenant
Use this API to retrieve the data security posture statistics of a specific tenant in Elements.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
## API
/partner/external/v3/wm/customers/{customerId}/tenants/{tenantId}/overview/dspm/insight
## Request
This section outlines the HTTP method and endpoint used to retrieve the data security
posture statistics of a specific tenant in Elements.
MethodEndpoint
GET/partner/external/v3/wm/customers/{customerId}/tenants/{tenantId}/overview/ds
URL Parameters
This section outlines the parameters required to specify which tenant's data security
posture statistics you want to retrieve.
ParameterDescriptionTypeRequired
customerIdThe customer IDstringYes
tenantIdThe tenant ID of the customerstringYes
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.

## 169 / 174
ResponseDescriptionType
sensitiveItemsSharedWithEveryoneThe number of
sensitive items that
are shared with the
Everyone group.
integer
sensitiveItemsSharedWithEveryoneExceptExternalUsersThe number of
sensitive items that
are shared with the
Everyone except
external users group.
integer
sensitiveItemsSharedViaAnyoneLinkThe number of
sensitive items that
are shared via anyone
links.
integer
sensitiveItemsSharedViaLinkForSpecificExternalUsersThe number of
sensitive items that
are shared via links
for specific external
users.
integer
sensitiveItemsSharedViaOrganizationLinkThe number of
sensitive items that
are shared via
organization links.
integer
## Request Sample
To use this API, send a GET request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
https://graph.avepointonlineservices.com/partner/external/v3/wm/customers/966f35cc-
## ****-4070-****-25cd****2a07/tenants/0c7715b3-****-4c4c-****-
f363****acec/overview/dspm/insights

## 170 / 174
HTTP status code, refer to Http Status Code.
## {
"sensitiveItemsSharedWithEveryone": 1, // The number of sensitive items that are
shared with the Everyone group
"sensitiveItemsSharedWithEveryoneExceptExternalUsers": 2, // The number of
sensitive items that are shared with the Everyone except external users group
"sensitiveItemsSharedViaAnyoneLink": 3, // The number of sensitive items that
are shared via anyone links
"sensitiveItemsSharedViaLinkForSpecificExternalUsers": 4, // The number of
sensitive items that are shared via links for specific external users
"sensitiveItemsSharedViaOrganizationLink": 5 // The number of sensitive items
that are shared via organization links
## }

## 171 / 174
Retrieve Data Protection Statistics of Tenant
Use this API to retrieve the data protection statistics of a specific tenant in Elements.
## Permission
The following permission is required to call the API.
You must register an app through Elements > API app registration to authenticate and
authorize your access to Elements API. For details, refer to App Registration.
APIPerm
/partner/external/v3/wm/customers/{customerId}/tenants/{tenantId}/overview/data-
protection/ransomware-detection
eleme
## Request
This section outlines the HTTP method and endpoint used to retrieve the data protection
statistics of a specific tenant in Elments.
MethodEndpoint
GET/partner/external/v3/wm/customers/{customerId}/tenants/{tenantId}/overview/da
protection/ransomware-detection
URL Parameters
This section outlines the parameters required to specify which tenant's data protection
statistics you want to retrieve.
ParameterDescriptionTypeRequired
customerIdThe customer IDstringYes
tenantIdThe tenant ID of the customerstringYes
## Response
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body.

## 172 / 174
ResponseDescriptionType
teamsUnderPotentialRansomwareAttackThe number of Teams under
potential ransomware attack
over the last 7 days.
integer
teamsWithUnusualActivitiesThe number of Teams with
unusual activities over the
last 7 days.
integer
sharePointSitesUnderPotentialRansomwareAttackThe number of SharePoint
sites under potential
ransomware attack over the
last 7 days.
integer
sharePointSitesWithUnusualActivitiesThe number of SharePoint
sites with unusual activities
over the last 7 days.
integer
oneDrivesUnderPotentialRansomwareAttackThe number of OneDrives
under potential ransomware
attack over the last 7 days.
integer
oneDrivesWithUnusualActivitiesThe number of OneDrives
with unusual activities over
the last 7 days.
integer
groupsUnderPotentialRansomwareAttackThe number of Groups under
potential ransomware attack
over the last 7 days.
integer
groupsWithUnusualActivitiesThe number of Groups with
unusual activities over the
last 7 days.
integer
teamsWithSuspiciousObjectsThe number of Teams with
suspicious objects over the
last 7 days.
integer
sharePointSitesWithSuspiciousObjectsThe number of SharePoint
sites with suspicious objects
over the last 7 days.
integer

## 173 / 174
ResponseDescriptionType
oneDrivesWithSuspiciousObjectsThe number of OneDrives
with suspicious objects over
the last 7 days.
integer
groupsWithSuspiciousObjectsThe number of Groups with
suspicious objects over the
last 7 days.
integer
## Request Sample
To use this API, send a GET request to the specified endpoint, including necessary
parameters as defined in the references.
## Response Sample
If the request has been successfully processed, a 200 OK response will be returned along
with the requested information displayed in the response body. For more details on the
HTTP status code, refer to Http Status Code.
https://graph.avepointonlineservices.com/partner/external/v3/wm/customers/966f35cc-
## ****-4070-****-25cd****2a07/tenants/0c7715b3-****-4c4c-****-
f363****acec/overview/data-protection/ransomware-detection
## {
"teamsUnderPotentialRansomwareAttack": 10, // The number of Teams under
potential ransomware attack over the last 7 days
"sharePointSitesUnderPotentialRansomwareAttack": 0, // The number of SharePoint
sites under potential ransomware attack over the last 7 days
"oneDrivesUnderPotentialRansomwareAttack": 0, // The number of OneDrives under
potential ransomware attack over the last 7 days
"groupsUnderPotentialRansomwareAttack": 16, // The number of Groups under
potential ransomware attack over the last 7 days
"teamsWithUnusualActivities": 0, // The number of Teams with unusual activities
over the last 7 days
"sharePointSitesWithUnusualActivities": 1, // The number of SharePoint sites
with unusual activities over the last 7 days
"oneDrivesWithUnusualActivities": 22, // The number of OneDrives with unusual
activities over the last 7 days
"groupsWithUnusualActivities": 0, // The number of Groups with unusual
activities over the last 7 days
"teamsWithSuspiciousObjects": 12, // The number of Teams with suspicious objects

## 174 / 174
over the last 7 days
"sharePointSitesWithSuspiciousObjects": 0, // The number of SharePoint sites
with suspicious objects over the last 7 days
"oneDrivesWithSuspiciousObjects": 0, // The number of OneDrives with suspicious
objects over the last 7 days
"groupsWithSuspiciousObjects": 1 // The number of Groups with suspicious objects
over the last 7 days
## }