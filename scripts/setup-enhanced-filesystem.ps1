#!/usr/bin/env pwsh
<#
.SYNOPSIS
Sets up enhanced filesystem capabilities for Claude Code by configuring MCP servers.

.DESCRIPTION
This script configures MCP servers to provide enhanced filesystem operations beyond the default capabilities.
It sets up filesystem, desktop-commander, and other file-related MCP servers with optimal configurations.

.PARAMETER ConfigPath
The path to the Claude Desktop MCP configuration file. Defaults to the standard location.

.PARAMETER AllowedPaths
Comma-separated list of paths to allow filesystem access to. Defaults to common development directories.

.EXAMPLE
.\setup-enhanced-filesystem.ps1
Sets up with default configuration

.EXAMPLE
.\setup-enhanced-filesystem.ps1 -AllowedPaths "/home/user/projects,/workspace,/tmp"
Sets up with custom allowed paths
#>

param(
    [string]$ConfigPath = (Join-Path $env:USERPROFILE ".config\claude-desktop\mcp_servers.json"),
    [string]$AllowedPaths = "$env:USERPROFILE\projects,$env:USERPROFILE\Documents,$env:TEMP"
)

# Ensure config directory exists
$configDir = Split-Path $ConfigPath -Parent
if (-not (Test-Path $configDir)) {
    New-Item -ItemType Directory -Path $configDir -Force | Out-Null
    Write-Host "Created configuration directory: $configDir"
}

# Enhanced MCP server configuration
$mcpConfig = @{
    mcpServers = @{
        "filesystem" = @{
            command = "npx"
            args = @("-y", "@modelcontextprotocol/server-filesystem")
            env = @{
                "FILESYSTEM_ALLOWED_PATHS" = $AllowedPaths
            }
        }
        "filesystem-extended" = @{
            command = "npx"
            args = @("-y", "@modelcontextprotocol/server-filesystem")
            env = @{
                "FILESYSTEM_ALLOWED_PATHS" = $AllowedPaths
                "FILESYSTEM_ENABLE_WRITE" = "true"
                "FILESYSTEM_ENABLE_SEARCH" = "true"
                "FILESYSTEM_MAX_FILE_SIZE" = "10485760"  # 10MB
            }
        }
        "desktop-commander" = @{
            command = "desktop-commander"
            args = @("--mcp")
            env = @{
                "LOG_LEVEL" = "info"
                "CHUNK_SIZE" = "30"
                "ENABLE_STREAMING_SEARCH" = "true"
            }
        }
    }
}

try {
    # Read existing configuration if it exists
    $existingConfig = @{ mcpServers = @{} }
    if (Test-Path $ConfigPath) {
        $existingContent = Get-Content $ConfigPath -Raw | ConvertFrom-Json
        if ($existingContent.mcpServers) {
            $existingConfig.mcpServers = $existingContent.mcpServers
        }
        Write-Host "Found existing MCP configuration"
    }

    # Merge configurations (new servers override existing ones with same name)
    foreach ($serverName in $mcpConfig.mcpServers.Keys) {
        $existingConfig.mcpServers.$serverName = $mcpConfig.mcpServers.$serverName
        Write-Host "Configured MCP server: $serverName"
    }

    # Write the updated configuration
    $existingConfig | ConvertTo-Json -Depth 10 | Set-Content $ConfigPath -Encoding UTF8

    Write-Host "✅ Enhanced filesystem MCP configuration saved to: $ConfigPath"
    Write-Host ""
    Write-Host "📋 Configured MCP Servers:"
    foreach ($serverName in $mcpConfig.mcpServers.Keys) {
        Write-Host "   • $serverName"
    }
    Write-Host ""
    Write-Host "🔧 Configuration Details:"
    Write-Host "   • Allowed paths: $AllowedPaths"
    Write-Host "   • Max file size: 10MB"
    Write-Host "   • Streaming search enabled"
    Write-Host "   • Chunked operations (30 lines per chunk)"
    Write-Host ""
    Write-Host "⚠️  Next Steps:"
    Write-Host "   1. Restart Claude Code to apply MCP server configuration"
    Write-Host "   2. Verify tools are available by running filesystem operations"
    Write-Host "   3. Check tool availability with dynamic discovery commands"
    Write-Host ""
    Write-Host "📚 Usage Guide: See local_ai_instruction_modules/ai-enhanced-filesystem.md"

} catch {
    Write-Error "Failed to configure MCP servers: $_"
    Write-Host ""
    Write-Host "🔍 Troubleshooting:"
    Write-Host "   • Ensure Claude Desktop is not running during configuration"
    Write-Host "   • Check that the configuration directory is writable"
    Write-Host "   • Verify Node.js is installed for npx commands"
    Write-Host "   • Install desktop-commander if using that MCP server"
    exit 1
}

# Verify Node.js availability for MCP servers
if (-not (Get-Command "npx" -ErrorAction SilentlyContinue)) {
    Write-Warning "Node.js/npx not found. MCP servers requiring npx will not work."
    Write-Host "Install Node.js from: https://nodejs.org/"
}

# Check if desktop-commander is available
if (-not (Get-Command "desktop-commander" -ErrorAction SilentlyContinue)) {
    Write-Warning "desktop-commander not found. Installing via npm..."
    try {
        if (Get-Command "npm" -ErrorAction SilentlyContinue) {
            npm install -g @desktop-commander/cli
            Write-Host "✅ desktop-commander installed successfully"
        } else {
            Write-Warning "npm not available. Install desktop-commander manually if needed."
        }
    } catch {
        Write-Warning "Failed to install desktop-commander: $_"
    }
}

Write-Host "🎉 Enhanced filesystem setup completed!"
Write-Host "   Restart Claude Code to activate the new MCP servers."