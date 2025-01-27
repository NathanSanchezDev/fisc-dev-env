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

    # URLs and Ports
    API_URL      = "https://localhost:44308"
    PORTAL_URL   = "https://localhost:5001"
    SWAGGER_URL  = "https://localhost:44308/swagger"
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
    Write-Host "API will be available at: $($CONFIG.API_URL)" -ForegroundColor Green
    Write-Host "Swagger available at: $($CONFIG.SWAGGER_URL)" -ForegroundColor Green
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
Set-Alias fix-api Reset-Api

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
    Write-Host "Portal will be available at: $($CONFIG.PORTAL_URL)" -ForegroundColor Green
    Write-Host "Press CTRL+Click to open in browser" -ForegroundColor Green
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
Set-Alias fix-portal Reset-Portal

function Test-Portal {
    Set-Location $CONFIG.PORTAL_PATH
    dotnet test
}
Set-Alias test-portal Test-Portal

#-----------------------------------------------------------------------------
# Package Management Commands
#-----------------------------------------------------------------------------
function Restore-PortalPackages {
    Set-Location $CONFIG.PORTAL_PATH
    Write-Host "Clearing NuGet cache..." -ForegroundColor Yellow
    dotnet nuget locals all --clear
    
    Write-Host "Removing bin and obj folders..." -ForegroundColor Yellow
    Get-ChildItem -Path $CONFIG.PORTAL_PATH -Include bin,obj -Recurse -Directory | Remove-Item -Recurse -Force
    
    Write-Host "Restoring NuGet packages..." -ForegroundColor Yellow
    dotnet restore
    
    Write-Host "Building solution..." -ForegroundColor Yellow
    dotnet build
}
Set-Alias fix-packages Restore-PortalPackages

#-----------------------------------------------------------------------------
# Browser Commands
#-----------------------------------------------------------------------------
function Open-Portal {
    Start-Process $CONFIG.PORTAL_URL
    Write-Host "Opening Portal at $($CONFIG.PORTAL_URL)" -ForegroundColor Green
}
Set-Alias web Open-Portal

function Open-Swagger {
    Start-Process $CONFIG.SWAGGER_URL
    Write-Host "Opening Swagger at $($CONFIG.SWAGGER_URL)" -ForegroundColor Green
}
Set-Alias swagger Open-Swagger

#-----------------------------------------------------------------------------
# Git Commands
#-----------------------------------------------------------------------------
function Get-ApiGitStatus {
    Set-Location $CONFIG.API_PATH
    Write-Host "API Git Status:" -ForegroundColor Yellow
    git branch --show-current
    Write-Host "`nStatus:" -ForegroundColor Yellow
    git status -s
}
Set-Alias gst-api Get-ApiGitStatus

function Get-PortalGitStatus {
    Set-Location $CONFIG.PORTAL_PATH
    Write-Host "Portal Git Status:" -ForegroundColor Yellow
    git branch --show-current
    Write-Host "`nStatus:" -ForegroundColor Yellow
    git status -s
}
Set-Alias gst-portal Get-PortalGitStatus

function Get-GitStatus {
    Write-Host "Current Directory Git Status:" -ForegroundColor Yellow
    git branch --show-current
    Write-Host "`nStatus:" -ForegroundColor Yellow
    git status -s
}
Set-Alias gst Get-GitStatus

function Switch-MainBranch {
    git checkout main
    git pull origin main
}
Set-Alias main Switch-MainBranch

#-----------------------------------------------------------------------------
# Solution Commands
#-----------------------------------------------------------------------------
function Open-ApiSolution {
    Set-Location $CONFIG.API_PATH
    Start-Process "Fischer-Identity-Api.sln"
}
Set-Alias openapi Open-ApiSolution

function Open-PortalSolution {
    Set-Location $CONFIG.PORTAL_PATH
    Start-Process "Fischer-Identity-Portal.sln"
}
Set-Alias openportal Open-PortalSolution

#-----------------------------------------------------------------------------
# Full Stack Commands
#-----------------------------------------------------------------------------
function Start-FullStack {
    # Start API in new window
    Start-Process powershell -ArgumentList "-NoExit -Command `"cd '$($CONFIG.API_PATH)'; dotnet run --project $($CONFIG.API_PROJECT)`""
    
    # Wait for API to start
    Start-Sleep -Seconds 5
    
    # Start Portal
    Set-Location $CONFIG.PORTAL_PATH
    dotnet run --project $CONFIG.PORTAL_PROJECT
}
Set-Alias fullstack Start-FullStack

#-----------------------------------------------------------------------------
# Cleanup Commands
#-----------------------------------------------------------------------------
function Clear-BinObj {
    param(
        [string]$path = "."
    )
    Write-Host "Removing bin and obj folders in $path..." -ForegroundColor Yellow
    Get-ChildItem -Path $path -Include bin,obj -Recurse -Directory | Remove-Item -Recurse -Force
}
Set-Alias cleanup Clear-BinObj

#-----------------------------------------------------------------------------
# Log Commands
#-----------------------------------------------------------------------------
function Get-PortalLogs {
    Set-Location "$($CONFIG.PORTAL_PATH)\logs"
    Get-Content -Path ".\portal-*.log" -Tail 50 -Wait
}
Set-Alias logs Get-PortalLogs

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
