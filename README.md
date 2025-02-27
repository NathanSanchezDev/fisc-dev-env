# PowerShell Profile Commands

Easy reference guide for all custom commands in the development profile.

## API Commands

| Command | Description |
|---------|-------------|
| `api` | Start the API with full build |
| `apirun` | Start the API quickly (no explicit build) |
| `dbapi` | Start API in debug mode |
| `cdapi` | Navigate to API project directory |
| `fix-api` | Reset API project (clean, restore, build) |
| `test-api` | Run API tests |

## Portal Commands

| Command | Description |
|---------|-------------|
| `portal` | Start the Portal with full build |
| `portalrun` | Start the Portal quickly (no explicit build) |
| `dbportal` | Start Portal in debug mode |
| `cdportal` | Navigate to Portal project directory |
| `fix-portal` | Reset Portal project (clean, restore, build) |
| `test-portal` | Run Portal tests |

## Package Management

| Command | Description |
|---------|-------------|
| `fix-packages` | Deep clean and restore Portal packages |

## Browser Commands

| Command | Description |
|---------|-------------|
| `web` | Open Portal in default browser |
| `swagger` | Open Swagger in default browser |

## Git Commands

| Command | Description |
|---------|-------------|
| `gst-api` | Show API git status |
| `gst-portal` | Show Portal git status |
| `gst` | Show git status for current directory |
| `main` | Switch to main branch and pull latest |

## Solution Commands

| Command | Description |
|---------|-------------|
| `openapi` | Open API solution in Visual Studio |
| `openportal` | Open Portal solution in Visual Studio |

## Full Stack Commands

| Command | Description |
|---------|-------------|
| `fullstack` | Start both API and Portal |

## Cleanup Commands

| Command | Description |
|---------|-------------|
| `cleanup` | Remove bin and obj folders from a path |

## Log Commands

| Command | Description |
|---------|-------------|
| `logs` | Show and follow Portal logs |

## Environment Setup

| Command | Description |
|---------|-------------|
| `reset-dev` | Reset dev environment (certs, packages) |
| `reset-dev-all` | Reset dev environment and initialize secrets |

## LocalStack and Secrets Commands

| Command | Description |
|---------|-------------|
| `localstack` | Start LocalStack container |
| `stoplocalstack` | Stop LocalStack container |
| `secrets` | Load JWT secrets |
| `secrets-up` | Start LocalStack and load secrets (one command) |
| `start-secrets` | Same as secrets-up |
| `devsecrets` | Initialize dev secrets (legacy command) |
| `ls-status` | Check LocalStack container status |

## Fisher Docker Commands

| Command | Description |
|---------|-------------|
| `cddocker` | Navigate to Docker project directory |
| `docker-up` | Start Fisher Docker containers |
| `docker-down` | Stop Fisher Docker containers |
| `docker-restart` | Restart Fisher Docker containers |
