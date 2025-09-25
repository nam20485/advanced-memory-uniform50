# Project Context for AI Assistant

## Project Overview

This repository serves as a template for creating new AI-powered applications and repositories. It implements a sophisticated workflow orchestration system that follows strict AI instruction modules and automation protocols.

The project is designed to work with AI agents that follow specific instructions and workflows, with a focus on maximizing automation and tool usage in GitHub-based workflows.

## Key Components

### AI Instruction Framework
- **Core AI Instructions**: Located in the remote repository `nam20485/agent-instructions`
- **Local AI Instruction Modules**: Stored in `local_ai_instruction_modules/` directory
- **Dynamic Workflows**: Predefined workflows for common tasks like repository initialization
- **Workflow Assignments**: Specific task assignments that reference remote canonical sources

### Automation & Tooling
- **Mandatory Tool Discovery Protocol**: Requires 90%+ automation coverage for all GitHub operations
- **Tool Hierarchy**: 
  1. MCP GitHub tools (priority)
  2. VS Code GitHub integration
  3. Terminal GitHub CLI (last resort)
- **Prohibited**: Manual GitHub web interface operations

### Scripts & Orchestration
- PowerShell scripts for repository initialization and automation
- GitHub CLI integration for remote operations
- Dev container configuration for consistent development environments

## Development Environment

### Prerequisites
- Node.js (v22.18.0 as pinned in .nvmrc)
- .NET SDK (v9.0.102 as defined in global.json)
- PowerShell v7+ for Windows environments
- Git
- GitHub CLI (gh)

### Dev Container
The project includes a dev container configuration that uses `ghcr.io/nam20485/dotnet-prebuild:latest` as the base image, ensuring a consistent development environment.

## Key Workflows

### Repository Initialization
The `initiate-new-repo.ps1` script orchestrates the entire process of creating a new repository from this template, including:
- Creating owner-level GitHub Project
- Creating repository from template
- Cloning the repository
- Importing labels and creating milestones
- Running post-clone initialization

### Dynamic Workflows
The system supports dynamic workflows that are resolved from the remote canonical repository:
- `initiate-new-repo`
- `new-project`
- `project-setup`
- `sample-minimal`

## Important Conventions

### Automation Requirements
- Minimum 90% automation coverage for all GitHub operations
- Always prefer automated approaches over manual execution
- Document justification for any manual steps

### Tool Usage
- Use MCP GitHub tools first for all repository operations
- Use VS Code GitHub integration next
- Only use terminal `gh` as a last resort with explicit justification

### File Structure
- `.github/`: GitHub configuration including labels, workflows, and issue templates
- `local_ai_instruction_modules/`: Local AI instruction files that reference remote canonical sources
- `scripts/`: PowerShell scripts for automation
- `docs/`: Documentation files

## Key Files

### Configuration Files
- `package.json`: Node.js package manifest (currently a dummy for CI caching)
- `global.json`: .NET SDK version pinning
- `.nvmrc`: Node.js version pinning
- `.devcontainer/devcontainer.json`: Dev container configuration

### AI Instruction Files
- `local_ai_instruction_modules/ai-tools-and-automation.md`: Automation rules and tool discovery protocol
- `local_ai_instruction_modules/ai-workflow-assignments.md`: Index of workflow assignments
- `local_ai_instruction_modules/ai-dynamic-workflows.md`: Index of dynamic workflows
- `local_ai_instruction_modules/toolset.selected.json`: List of enabled/disabled tools

### Scripts
- `scripts/initiate-new-repo.ps1`: Orchestrates the "initiate-new-repository" dynamic workflow
- Various helper scripts for labels, milestones, and repository setup

## Constraints & Rules

### Critical Rules
1. Don't assume your shell is bash - it's probably PowerShell
2. The web-fetch tool is disabled; use PowerShell or curl to fetch files from the web
3. Dynamic workflow files and workflow assignment files in the remote canonical repository are the ONLY authoritative sources
4. Local mirrors must not be used to derive steps or acceptance criteria

### GitHub Automation Rules
1. Every GitHub task can be automated
2. Always attempt automated solution first
3. Manual execution requires documented tool limitation
4. Maintain updated inventory of all available GitHub automation tools

## Remote Repository

The main set of AI instruction modules is located in the remote repository:
- Repository: `nam20485/agent-instructions`
- Branch: `main`
- URL: https://github.com/nam20485/agent-instructions

When accessing files in the remote repository, always use the RAW URL format:
- GitHub UI: `https://github.com/nam20485/agent-instructions/blob/main/<file-path>`
- RAW URL: `https://raw.githubusercontent.com/nam20485/agent-instructions/main/<file-path>`

## Technology Stack

- **Primary Languages**: PowerShell, JavaScript/Node.js, C#/.NET
- **Automation Tools**: GitHub CLI, MCP tools, VS Code integration
- **Containerization**: Docker via dev container
- **Package Management**: pnpm (via Corepack)
- **Version Control**: Git with GitHub integration