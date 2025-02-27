# Main configuration - paths and settings for all projects
$CONFIG = @{
    # Project Paths
    API_PATH       = "C:\Users\nathan.s\Development\Repositories\DotNet-Identity-Api"
    PORTAL_PATH    = "C:\Users\nathan.s\Development\Repositories\DotNet-Identity-Portal"
    DOCKER_PATH    = "C:\Users\nathan.s\Development\Repositories\Fisher-Docker"
    
    # Project Settings
    API_PROJECT    = "src\Fii.Api.Web"
    PORTAL_PROJECT = "src\Fii.Web.Server"

    # URLs and Ports
    API_URL      = "https://localhost:44308"
    PORTAL_URL   = "https://localhost:5001"
    SWAGGER_URL  = "https://localhost:44308/swagger"
    
    # LocalStack and Secrets Paths
    LOCALSTACK_PATH = "C:\Users\nathan.s\Development\Setup"
    SECRETS_PATH    = "C:\Users\nathan.s\Development\Secrets"
}

# API COMMANDS

# Start the API with full build
function Start-Api {
    Set-Location $CONFIG.API_PATH
    dotnet build
    dotnet run --project $CONFIG.API_PROJECT
}
Set-Alias api Start-Api

# Start the API quickly without explicit build
function Start-ApiQuick {
    Set-Location $CONFIG.API_PATH
    Write-Host "API will be available at: $($CONFIG.API_URL)" -ForegroundColor Green
    Write-Host "Swagger available at: $($CONFIG.SWAGGER_URL)" -ForegroundColor Green
    dotnet run --project $CONFIG.API_PROJECT
}
Set-Alias apirun Start-ApiQuick

# Start API in debug mode
function Debug-Api {
    Set-Location $CONFIG.API_PATH
    dotnet build
    dotnet run --project $CONFIG.API_PROJECT --launch-profile "Debug"
}
Set-Alias dbapi Debug-Api

# Jump to API project directory
function Set-ApiProject {
    Set-Location $CONFIG.API_PATH
}
Set-Alias cdapi Set-ApiProject

# Reset API project (clean, restore, build)
function Reset-Api {
    Set-Location $CONFIG.API_PATH
    dotnet clean
    dotnet restore
    dotnet build
}
Set-Alias fix-api Reset-Api

# Run API tests
function Test-Api {
    Set-Location $CONFIG.API_PATH
    dotnet test
}
Set-Alias test-api Test-Api

# PORTAL COMMANDS

# Start the Portal with full build
function Start-Portal {
    Set-Location $CONFIG.PORTAL_PATH
    dotnet build
    dotnet run --project $CONFIG.PORTAL_PROJECT
}
Set-Alias portal Start-Portal

# Start the Portal quickly without explicit build
function Start-PortalQuick {
    Set-Location $CONFIG.PORTAL_PATH
    Write-Host "Portal will be available at: $($CONFIG.PORTAL_URL)" -ForegroundColor Green
    Write-Host "Press CTRL+Click to open in browser" -ForegroundColor Green
    dotnet run --project $CONFIG.PORTAL_PROJECT
}
Set-Alias portalrun Start-PortalQuick

# Start Portal in debug mode
function Debug-Portal {
    Set-Location $CONFIG.PORTAL_PATH
    dotnet build
    dotnet run --project $CONFIG.PORTAL_PROJECT --launch-profile "Debug"
}
Set-Alias dbportal Debug-Portal

# Jump to Portal project directory
function Set-PortalProject {
    Set-Location $CONFIG.PORTAL_PATH
}
Set-Alias cdportal Set-PortalProject

# Reset Portal project (clean, restore, build)
function Reset-Portal {
    Set-Location $CONFIG.PORTAL_PATH
    dotnet clean
    dotnet restore
    dotnet build
}
Set-Alias fix-portal Reset-Portal

# Run Portal tests
function Test-Portal {
    Set-Location $CONFIG.PORTAL_PATH
    dotnet test
}
Set-Alias test-portal Test-Portal

# PACKAGE MANAGEMENT

# Deep clean and restore for Portal
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

# BROWSER COMMANDS

# Open Portal in browser
function Open-Portal {
    Start-Process $CONFIG.PORTAL_URL
    Write-Host "Opening Portal at $($CONFIG.PORTAL_URL)" -ForegroundColor Green
}
Set-Alias web Open-Portal

# Open Swagger in browser
function Open-Swagger {
    Start-Process $CONFIG.SWAGGER_URL
    Write-Host "Opening Swagger at $($CONFIG.SWAGGER_URL)" -ForegroundColor Green
}
Set-Alias swagger Open-Swagger

# GIT COMMANDS

# Show API git status
function Get-ApiGitStatus {
    Set-Location $CONFIG.API_PATH
    Write-Host "API Git Status:" -ForegroundColor Yellow
    git branch --show-current
    Write-Host "`nStatus:" -ForegroundColor Yellow
    git status -s
}
Set-Alias gst-api Get-ApiGitStatus

# Show Portal git status
function Get-PortalGitStatus {
    Set-Location $CONFIG.PORTAL_PATH
    Write-Host "Portal Git Status:" -ForegroundColor Yellow
    git branch --show-current
    Write-Host "`nStatus:" -ForegroundColor Yellow
    git status -s
}
Set-Alias gst-portal Get-PortalGitStatus

# Show git status for current directory
function Get-GitStatus {
    Write-Host "Current Directory Git Status:" -ForegroundColor Yellow
    git branch --show-current
    Write-Host "`nStatus:" -ForegroundColor Yellow
    git status -s
}
Set-Alias gst Get-GitStatus

# Switch to main branch and pull latest
function Switch-MainBranch {
    git checkout main
    git pull origin main
}
Set-Alias main Switch-MainBranch

# SOLUTION COMMANDS

# Open API solution in Visual Studio
function Open-ApiSolution {
    Set-Location $CONFIG.API_PATH
    Start-Process "Fischer-Identity-Api.sln"
}
Set-Alias openapi Open-ApiSolution

# Open Portal solution in Visual Studio
function Open-PortalSolution {
    Set-Location $CONFIG.PORTAL_PATH
    Start-Process "Fischer-Identity-Portal.sln"
}
Set-Alias openportal Open-PortalSolution

# FULL STACK COMMANDS

# Start both API and Portal
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

# CLEANUP COMMANDS

# Remove bin and obj folders from a path
function Clear-BinObj {
    param(
        [string]$path = "."
    )
    Write-Host "Removing bin and obj folders in $path..." -ForegroundColor Yellow
    Get-ChildItem -Path $path -Include bin,obj -Recurse -Directory | Remove-Item -Recurse -Force
}
Set-Alias cleanup Clear-BinObj

# LOG COMMANDS

# Show and follow Portal logs
function Get-PortalLogs {
    Set-Location "$($CONFIG.PORTAL_PATH)\logs"
    Get-Content -Path ".\portal-*.log" -Tail 50 -Wait
}
Set-Alias logs Get-PortalLogs

# ENVIRONMENT SETUP

# Reset dev environment (certs, packages, etc)
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

# LOCALSTACK AND SECRETS COMMANDS

# Start LocalStack container
function Start-LocalStack {
    Set-Location $CONFIG.LOCALSTACK_PATH
    Write-Host "Starting LocalStack container..." -ForegroundColor Cyan
    docker-compose up -d
    Write-Host "LocalStack started successfully!" -ForegroundColor Green
}
Set-Alias localstack Start-LocalStack

# Stop LocalStack container
function Stop-LocalStack {
    Set-Location $CONFIG.LOCALSTACK_PATH
    Write-Host "Stopping LocalStack container..." -ForegroundColor Cyan
    docker-compose down
    Write-Host "LocalStack stopped successfully!" -ForegroundColor Green
}
Set-Alias stoplocalstack Stop-LocalStack

# Load JWT secrets
function Load-Secrets {
    Set-Location $CONFIG.SECRETS_PATH
    Write-Host "Loading JWT secrets..." -ForegroundColor Cyan
    & .\LoadJwtSecretsLocal.bat
    Write-Host "Secrets loaded successfully!" -ForegroundColor Green
}
Set-Alias secrets Load-Secrets

# Start LocalStack and load secrets in one command
function Start-SecretStore {
    Write-Host "🚀 Starting secret store..." -ForegroundColor Cyan
    
    # Start LocalStack
    Set-Location $CONFIG.LOCALSTACK_PATH
    Write-Host "  ↪ Starting LocalStack container" -ForegroundColor Yellow
    docker-compose up -d
    
    # Wait for LocalStack to initialize
    Write-Host "  ↪ Waiting for LocalStack to initialize (10 seconds)" -ForegroundColor Yellow
    Start-Sleep -Seconds 10
    
    # Load secrets
    Set-Location $CONFIG.SECRETS_PATH
    Write-Host "  ↪ Loading JWT secrets" -ForegroundColor Yellow
    & .\LoadJwtSecretsLocal.bat
    
    Write-Host "✅ Secret store is up and running!" -ForegroundColor Green
}
Set-Alias secrets-up Start-SecretStore
Set-Alias start-secrets Start-SecretStore

# Legacy command that uses Start-SecretStore
function Initialize-DevSecrets {
    Start-SecretStore
}
Set-Alias devsecrets Initialize-DevSecrets

# Reset dev environment and initialize secrets
function Reset-DevWithSecrets {
    Reset-DevEnvironment
    Start-SecretStore
    Write-Host "Development environment has been reset with fresh secrets!" -ForegroundColor Green
}
Set-Alias reset-dev-all Reset-DevWithSecrets

# Check LocalStack container status
function Get-LocalStackStatus {
    docker ps --filter "name=localstack"
    Write-Host "`nTo check LocalStack services status, visit: http://localhost:4566/health" -ForegroundColor Cyan
}
Set-Alias ls-status Get-LocalStackStatus

# FISHER DOCKER COMMANDS

# Navigate to docker directory
function Set-DockerProject {
    Set-Location $CONFIG.DOCKER_PATH
}
Set-Alias cddocker Set-DockerProject

# Start Fisher Docker containers
function Start-FisherDocker {
    Set-Location $CONFIG.DOCKER_PATH
    Write-Host "Starting Fisher Docker containers..." -ForegroundColor Cyan
    docker-compose up -d
    Write-Host "Fisher Docker containers started successfully!" -ForegroundColor Green
}
Set-Alias docker-up Start-FisherDocker

# Stop Fisher Docker containers
function Stop-FisherDocker {
    Set-Location $CONFIG.DOCKER_PATH
    Write-Host "Stopping Fisher Docker containers..." -ForegroundColor Cyan
    docker-compose down
    Write-Host "Fisher Docker containers stopped successfully!" -ForegroundColor Green
}
Set-Alias docker-down Stop-FisherDocker

# Restart Fisher Docker containers
function Restart-FisherDocker {
    Stop-FisherDocker
    Start-Sleep -Seconds 3
    Start-FisherDocker
}
Set-Alias docker-restart Restart-FisherDocker
