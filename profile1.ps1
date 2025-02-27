# Main configuration
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

    # Tomcat Path
    TOMCAT_PATH = "C:\Users\nathan.s\Development\apache-tomcat-10.1.36-windows-x64\apache-tomcat-10.1.36"
}

# API COMMANDS
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

# PORTAL COMMANDS
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

# PACKAGE MANAGEMENT
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

# GIT COMMANDS
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

# SOLUTION COMMANDS
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

# FULL STACK COMMANDS
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
function Clear-BinObj {
    param(
        [string]$path = "."
    )
    Write-Host "Removing bin and obj folders in $path..." -ForegroundColor Yellow
    Get-ChildItem -Path $path -Include bin,obj -Recurse -Directory | Remove-Item -Recurse -Force
}
Set-Alias cleanup Clear-BinObj

# LOG COMMANDS
function Get-PortalLogs {
    Set-Location "$($CONFIG.PORTAL_PATH)\logs"
    Get-Content -Path ".\portal-*.log" -Tail 50 -Wait
}
Set-Alias logs Get-PortalLogs

# ENVIRONMENT SETUP
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
function Start-LocalStack {
    Set-Location $CONFIG.LOCALSTACK_PATH
    Write-Host "Starting LocalStack container..." -ForegroundColor Cyan
    docker-compose up -d
    Write-Host "LocalStack started successfully!" -ForegroundColor Green
}
Set-Alias localstack Start-LocalStack

function Stop-LocalStack {
    Set-Location $CONFIG.LOCALSTACK_PATH
    Write-Host "Stopping LocalStack container..." -ForegroundColor Cyan
    docker-compose down
    Write-Host "LocalStack stopped successfully!" -ForegroundColor Green
}
Set-Alias stoplocalstack Stop-LocalStack

function Load-Secrets {
    Set-Location $CONFIG.SECRETS_PATH
    Write-Host "Loading JWT secrets..." -ForegroundColor Cyan
    & .\LoadJwtSecretsLocal.bat
    Write-Host "Secrets loaded successfully!" -ForegroundColor Green
}
Set-Alias secrets Load-Secrets

function Start-SecretStore {
    Write-Host "Starting secret store..." -ForegroundColor Cyan
    
    # Start LocalStack
    Set-Location $CONFIG.LOCALSTACK_PATH
    Write-Host "Starting LocalStack container" -ForegroundColor Yellow
    docker-compose up -d
    
    # Wait for LocalStack to initialize
    Write-Host "Waiting for LocalStack to initialize (10 seconds)" -ForegroundColor Yellow
    Start-Sleep -Seconds 10
    
    # Load secrets
    Set-Location $CONFIG.SECRETS_PATH
    Write-Host "Loading JWT secrets" -ForegroundColor Yellow
    & .\LoadJwtSecretsLocal.bat
    
    Write-Host "Secret store is up and running!" -ForegroundColor Green
}
Set-Alias secrets-up Start-SecretStore
Set-Alias start-secrets Start-SecretStore

function Initialize-DevSecrets {
    Start-SecretStore
}
Set-Alias devsecrets Initialize-DevSecrets

function Reset-DevWithSecrets {
    Reset-DevEnvironment
    Start-SecretStore
    Write-Host "Development environment has been reset with fresh secrets!" -ForegroundColor Green
}
Set-Alias reset-dev-all Reset-DevWithSecrets

function Get-LocalStackStatus {
    docker ps --filter "name=localstack"
    Write-Host "`nTo check LocalStack services status, visit: http://localhost:4566/health" -ForegroundColor Cyan
}
Set-Alias ls-status Get-LocalStackStatus

# FISHER DOCKER COMMANDS
function Set-DockerProject {
    Set-Location $CONFIG.DOCKER_PATH
}
Set-Alias cddocker Set-DockerProject

function Start-FisherDocker {
    Set-Location $CONFIG.DOCKER_PATH
    Write-Host "Starting Fisher Docker containers..." -ForegroundColor Cyan
    docker-compose up -d
    Write-Host "Fisher Docker containers started successfully!" -ForegroundColor Green
}
Set-Alias docker-up Start-FisherDocker

function Stop-FisherDocker {
    Set-Location $CONFIG.DOCKER_PATH
    Write-Host "Stopping Fisher Docker containers..." -ForegroundColor Cyan
    docker-compose down
    Write-Host "Fisher Docker containers stopped successfully!" -ForegroundColor Green
}
Set-Alias docker-down Stop-FisherDocker

function Restart-FisherDocker {
    Stop-FisherDocker
    Start-Sleep -Seconds 3
    Start-FisherDocker
}
Set-Alias docker-restart Restart-FisherDocker

# IDENTITY/TOMCAT COMMANDS
function Set-TomcatDirectory {
    Set-Location $CONFIG.TOMCAT_PATH
}
Set-Alias cdtomcat Set-TomcatDirectory

function Set-TomcatBinDirectory {
    Set-Location "$($CONFIG.TOMCAT_PATH)\bin"
}
Set-Alias cdtomcatbin Set-TomcatBinDirectory

function Start-IdentityServer {
    Write-Host "Starting Identity server (Tomcat)..." -ForegroundColor Cyan
    Set-Location "$($CONFIG.TOMCAT_PATH)\bin"
    Start-Process -FilePath ".\startup.bat" -NoNewWindow
    Write-Host "Identity server is starting!" -ForegroundColor Green
    Write-Host "Tomcat will be available at: http://localhost:8080" -ForegroundColor Green
}
Set-Alias identity Start-IdentityServer
Set-Alias tomcat Start-IdentityServer
Set-Alias identity-up Start-IdentityServer

function Stop-IdentityServer {
    Write-Host "Stopping Identity server (Tomcat)..." -ForegroundColor Cyan
    Set-Location "$($CONFIG.TOMCAT_PATH)\bin"
    Start-Process -FilePath ".\shutdown.bat" -NoNewWindow
    Write-Host "Identity server has been stopped!" -ForegroundColor Green
}
Set-Alias identity-down Stop-IdentityServer
Set-Alias tomcat-down Stop-IdentityServer

function Restart-IdentityServer {
    Stop-IdentityServer
    Write-Host "Waiting for Tomcat to shut down..." -ForegroundColor Yellow
    Start-Sleep -Seconds 5
    Start-IdentityServer
}
Set-Alias identity-restart Restart-IdentityServer
Set-Alias tomcat-restart Restart-IdentityServer

function Get-TomcatLogs {
    param(
        [int]$Lines = 50
    )
    Set-Location "$($CONFIG.TOMCAT_PATH)\logs"
    Get-Content -Path ".\catalina.out" -Tail $Lines -Wait
}
Set-Alias tomcat-logs Get-TomcatLogs
Set-Alias identity-logs Get-TomcatLogs

# COMPLETE ENVIRONMENT STARTUP
function Start-FullEnvironment {
    param(
        [int]$SecretWaitTime = 10,
        [int]$IdentityWaitTime = 60,
        [int]$DockerWaitTime = 10,
        [int]$ApiWaitTime = 30
    )
    
    Write-Host "STARTING COMPLETE ENVIRONMENT" -ForegroundColor Cyan
    Write-Host "===============================" -ForegroundColor Cyan
    
    # Start Secrets Manager (LocalStack)
    Write-Host "STEP 1: Starting Secret Store" -ForegroundColor Green
    Set-Location $CONFIG.LOCALSTACK_PATH
    Write-Host "Starting LocalStack container" -ForegroundColor Yellow
    docker-compose up -d
    
    Write-Host "Waiting for LocalStack to initialize ($SecretWaitTime seconds)" -ForegroundColor Yellow
    Start-Sleep -Seconds $SecretWaitTime
    
    # Check if LocalStack is running
    $localstackContainer = docker ps --filter "name=localstack" --format "{{.Names}}"
    if (-not $localstackContainer) {
        Write-Host "LocalStack failed to start! Environment setup aborted." -ForegroundColor Red
        return
    }
    
    # Load Secrets
    Write-Host "STEP 2: Loading Secrets" -ForegroundColor Green
    Set-Location $CONFIG.SECRETS_PATH
    Write-Host "Running LoadJwtSecretsLocal.bat" -ForegroundColor Yellow
    & .\LoadJwtSecretsLocal.bat
    
    # Start Identity Server (Tomcat)
    Write-Host "STEP 3: Starting Identity Server" -ForegroundColor Green
    Set-Location "$($CONFIG.TOMCAT_PATH)\bin"
    Write-Host "Starting Tomcat" -ForegroundColor Yellow
    Start-Process -FilePath ".\startup.bat" -NoNewWindow
    
    Write-Host "Waiting for Identity Server to initialize ($IdentityWaitTime seconds)" -ForegroundColor Yellow
    Start-Sleep -Seconds $IdentityWaitTime
    
    # Start Fisher Docker containers
    Write-Host "STEP 4: Starting Docker Containers" -ForegroundColor Green
    Set-Location $CONFIG.DOCKER_PATH
    Write-Host "Starting Fisher Docker containers" -ForegroundColor Yellow
    docker-compose up -d
    
    Write-Host "Waiting for Docker containers to initialize ($DockerWaitTime seconds)" -ForegroundColor Yellow
    Start-Sleep -Seconds $DockerWaitTime
    
    # Start API and Portal
    Write-Host "STEP 5: Starting API and Portal" -ForegroundColor Green
    
    # Start API in new window
    Write-Host "Starting API (in new window)" -ForegroundColor Yellow
    Start-Process powershell -ArgumentList "-NoExit -Command `"cd '$($CONFIG.API_PATH)'; Write-Host 'Starting API...' -ForegroundColor Cyan; dotnet run --project $($CONFIG.API_PROJECT)`""
    
    Write-Host "Waiting for API to initialize ($ApiWaitTime seconds)" -ForegroundColor Yellow
    Start-Sleep -Seconds $ApiWaitTime
    
    # Start Portal
    Write-Host "Starting Portal" -ForegroundColor Yellow
    Set-Location $CONFIG.PORTAL_PATH
    
    Write-Host "ENVIRONMENT STARTUP COMPLETE!" -ForegroundColor Green
    Write-Host "===============================" -ForegroundColor Green
    Write-Host "Secret Store:     Running" -ForegroundColor Green
    Write-Host "Identity Server:  Running (http://localhost:8080)" -ForegroundColor Green
    Write-Host "Docker:           Running" -ForegroundColor Green
    Write-Host "API:              Running ($($CONFIG.API_URL))" -ForegroundColor Green
    Write-Host "Swagger:          Available ($($CONFIG.SWAGGER_URL))" -ForegroundColor Green
    Write-Host "Portal:           Starting" -ForegroundColor Green
    Write-Host "Starting Portal now..." -ForegroundColor Cyan
    
    # Now start the Portal
    dotnet run --project $CONFIG.PORTAL_PROJECT
}

Set-Alias start-all Start-FullEnvironment
Set-Alias fiiup Start-FullEnvironment
