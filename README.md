PowerShell Development Profile
A configurable PowerShell profile for .NET development with API and Portal projects.
Quick Setup

Show your PowerShell profile path:

powershellCopy$PROFILE

Create or open your profile:

powershellCopy# Create if it doesn't exist
New-Item -Path $PROFILE -Type File -Force

# Open in notepad
notepad $PROFILE

Copy the contents of profile.ps1 into your PowerShell profile
Configure your paths in the $CONFIG section:

powershellCopy$CONFIG = @{
    API_PATH       = "YOUR_API_PATH"
    PORTAL_PATH    = "YOUR_PORTAL_PATH"
    API_PROJECT    = "src\YourApi.Project"
    PORTAL_PROJECT = "src\YourPortal.Project"
}
Available Commands
API Commands

api - Build and run API
apirun - Quick run API (no rebuild)
dbapi - Debug API
cdapi - Switch to API directory
reset-api - Clean and rebuild API
test-api - Run API tests

Portal Commands

portal - Build and run Portal
portalrun - Quick run Portal (no rebuild)
dbportal - Debug Portal
cdportal - Switch to Portal directory
reset-portal - Clean and rebuild Portal
test-portal - Run Portal tests

Environment Commands

reset-dev - Reset development environment (certificates and packages)
