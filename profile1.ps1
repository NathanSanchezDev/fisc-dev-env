#-----------------------------------------------------------------------------
# PowerShell Development Profile for .NET Projects
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Configuration
# Modify these paths according to your environment
#-----------------------------------------------------------------------------
$CONFIG = @{
    # Project Paths
    API_PATH     = "C:\Users\nathan.s\source\repos\DotNet-Identity-Api"
    PORTAL_PATH  = "C:\Users\nathan.s\source\repos\DotNet-Identity-Portal"
    
    # Project Settings
    API_PROJECT    = "src\Fii.Api.Web"
    PORTAL_PROJECT = "src\Fii.Web.Server"
}

#-----------------------------------------------------------------------------
# API Commands
#-----------------------------------------------------------------------------
function Start-Api {
    Set-Location $CONFIG.API_PATH
    dotnet build
    dotnet run --project $CONFIG.API_PROJECT
}
Set-Alias api Start-Api

function Start-ApiQuick {
    Set-Location $CONFIG.API_PATH
    dotnet run --project $CONFIG.API_PROJECT
}
Set-Alias apirun Start-ApiQuick

function Debug-Api {
    Set-Location $CONFIG.API_PATH
    dotnet build
    dotnet run --project $CONFIG.API_PROJECT --launch-profile "Debug"
}
Set-Alias dbapi Debug-Api

function Set-ApiProject {
    Set-Location $CONFIG.API_PATH
}
Set-Alias cdapi Set-ApiProject

function Reset-Api {
    Set-Location $CONFIG.API_PATH
    dotnet clean
    dotnet restore
    dotnet build
}
Set-Alias reset-api Reset-Api

function Test-Api {
    Set-Location $CONFIG.API_PATH
    dotnet test
}
Set-Alias test-api Test-Api

#-----------------------------------------------------------------------------
# Portal Commands
#-----------------------------------------------------------------------------
function Start-Portal {
    Set-Location $CONFIG.PORTAL_PATH
    dotnet build
    dotnet run --project $CONFIG.PORTAL_PROJECT
}
Set-Alias portal Start-Portal

function Start-PortalQuick {
    Set-Location $CONFIG.PORTAL_PATH
    dotnet run --project $CONFIG.PORTAL_PROJECT
}
Set-Alias portalrun Start-PortalQuick

function Debug-Portal {
    Set-Location $CONFIG.PORTAL_PATH
    dotnet build
    dotnet run --project $CONFIG.PORTAL_PROJECT --launch-profile "Debug"
}
Set-Alias dbportal Debug-Portal

function Set-PortalProject {
    Set-Location $CONFIG.PORTAL_PATH
}
Set-Alias cdportal Set-PortalProject

function Reset-Portal {
    Set-Location $CONFIG.PORTAL_PATH
    dotnet clean
    dotnet restore
    dotnet build
}
Set-Alias reset-portal Reset-Portal

function Test-Portal {
    Set-Location $CONFIG.PORTAL_PATH
    dotnet test
}
Set-Alias test-portal Test-Portal

#-----------------------------------------------------------------------------
# Development Environment Setup
#-----------------------------------------------------------------------------
function Reset-DevEnvironment {
    Write-Host "Cleaning dev certificates..." -ForegroundColor Yellow
    dotnet dev-certs https --clean
    
    Write-Host "Creating and trusting new dev certificates..." -ForegroundColor Yellow
    dotnet dev-certs https --trust
    
    Write-Host "Cleaning solutions..." -ForegroundColor Yellow
    Set-Location $CONFIG.API_PATH
    dotnet clean
    Set-Location $CONFIG.PORTAL_PATH
    dotnet clean
    
    Write-Host "Restoring packages..." -ForegroundColor Yellow
    Set-Location $CONFIG.API_PATH
    dotnet restore
    Set-Location $CONFIG.PORTAL_PATH
    dotnet restore
}
Set-Alias reset-dev Reset-DevEnvironment
