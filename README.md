# PowerShell Development Profile

A configurable PowerShell profile for .NET development with API and Portal projects.

## Quick Setup

1. Show your PowerShell profile path:
```powershell
$PROFILE
```

2. Create or open your profile:
```powershell
# Create if it doesn't exist
New-Item -Path $PROFILE -Type File -Force

# Open in notepad
notepad $PROFILE
```

3. Copy the contents of `profile.ps1` into your PowerShell profile

4. Configure your paths and URLs in the `$CONFIG` section:
```powershell
$CONFIG = @{
    # Project Paths
    API_PATH     = "YOUR_API_PATH"
    PORTAL_PATH  = "YOUR_PORTAL_PATH"
    
    # Project Settings
    API_PROJECT    = "src\YourApi.Project"
    PORTAL_PROJECT = "src\YourPortal.Project"

    # URLs and Ports
    API_URL      = "https://localhost:YOUR_API_PORT"
    PORTAL_URL   = "https://localhost:YOUR_PORTAL_PORT"
    SWAGGER_URL  = "https://localhost:YOUR_API_PORT/swagger"
}
```

## Available Commands

### Navigation
- `cdapi` - Go to API directory
- `cdportal` - Go to Portal directory

### Run Applications
- `api` - Build and run API
- `apirun` - Quick run API (no rebuild)
- `portal` - Build and run Portal
- `portalrun` - Quick run Portal (no rebuild)
- `fullstack` - Run both API and Portal
- `dbapi` - Debug API
- `dbportal` - Debug Portal

### Browser Access
- `web` - Open Portal in browser
- `swagger` - Open Swagger documentation

### Visual Studio
- `openapi` - Open API solution
- `openportal` - Open Portal solution

### Build & Test
- `test-api` - Run API tests
- `test-portal` - Run Portal tests
- `fix-api` - Clean and rebuild API
- `fix-portal` - Clean and rebuild Portal
- `fix-packages` - Deep clean and restore NuGet packages

### Git Commands
- `gst` - Git status of current directory
- `gst-api` - Git status of API
- `gst-portal` - Git status of Portal
- `main` - Switch to main branch and pull

### Maintenance
- `cleanup` - Remove bin and obj folders
- `logs` - View Portal logs
- `reset-dev` - Reset development certificates

## Requirements
- PowerShell 5.1 or higher
- .NET SDK
- Git (for git commands)

## Troubleshooting

### SSL Certificate Issues
Use `reset-dev` to reset your development certificates

### Package Issues
Use `fix-packages` to perform a deep clean and restore of NuGet packages
