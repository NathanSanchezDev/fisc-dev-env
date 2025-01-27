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

4. Configure your paths in the `$CONFIG` section:
```powershell
$CONFIG = @{
    API_PATH       = "YOUR_API_PATH"
    PORTAL_PATH    = "YOUR_PORTAL_PATH"
    API_PROJECT    = "src\YourApi.Project"
    PORTAL_PROJECT = "src\YourPortal.Project"
}
```

## Available Commands

### API Commands
- `api` - Build and run API
- `apirun` - Quick run API (no rebuild)
- `dbapi` - Debug API
- `cdapi` - Switch to API directory
- `reset-api` - Clean and rebuild API
- `test-api` - Run API tests

### Portal Commands
- `portal` - Build and run Portal
- `portalrun` - Quick run Portal (no rebuild)
- `dbportal` - Debug Portal
- `cdportal` - Switch to Portal directory
- `reset-portal` - Clean and rebuild Portal
- `test-portal` - Run Portal tests

### Environment Commands
- `reset-dev` - Reset development environment (certificates and packages)

## Requirements
- PowerShell 5.1 or higher
- .NET SDK
