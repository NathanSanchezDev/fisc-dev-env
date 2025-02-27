# PowerShell Profile Commands

Reference guide for all development environment commands.

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
| `fix-packages` | Deep clean and restore packages |

## Browser Commands

| Command | Description |
|---------|-------------|
| `web` | Open Portal in browser |
| `swagger` | Open Swagger in browser |

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
| `start-all` or `fiiup` | Start complete environment (see below) |

## Cleanup Commands

| Command | Description |
|---------|-------------|
| `cleanup` | Remove bin and obj folders from a path |

## Log Commands

| Command | Description |
|---------|-------------|
| `logs` | Show and follow Portal logs |
| `tomcat-logs` or `identity-logs` | View Tomcat/Identity server logs |

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
| `secrets-up` or `start-secrets` | Start LocalStack and load secrets |
| `devsecrets` | Initialize dev secrets (legacy command) |
| `ls-status` | Check LocalStack container status |

## Fisher Docker Commands

| Command | Description |
|---------|-------------|
| `cddocker` | Navigate to Docker project directory |
| `docker-up` | Start Fisher Docker containers |
| `docker-down` | Stop Fisher Docker containers |
| `docker-restart` | Restart Fisher Docker containers |

## Identity/Tomcat Commands

| Command | Description |
|---------|-------------|
| `cdtomcat` | Navigate to Tomcat directory |
| `cdtomcatbin` | Navigate to Tomcat bin directory |
| `identity` or `tomcat` or `identity-up` | Start Identity/Tomcat server |
| `identity-down` or `tomcat-down` | Stop Identity/Tomcat server |
| `identity-restart` or `tomcat-restart` | Restart Identity/Tomcat server |

## Complete Environment Startup

| Command | Description |
|---------|-------------|
| `start-all` or `fiiup` | Start the complete environment in the correct sequence |

The `start-all` command automatically starts the following in sequence:
1. LocalStack (secret store)
2. Loads JWT secrets
3. Starts Identity server (Tomcat)
4. Starts Fisher Docker containers
5. Starts API in a new window
6. Starts Portal

Each step includes appropriate wait times to ensure dependencies are ready.
