#!/usr/bin/env pwsh
<#
.SYNOPSIS
Updates all project files with required compiler settings.

.DESCRIPTION
Adds TreatWarningsAsErrors and GenerateDocumentationFile properties to all .csproj files in the solution.
#>

param(
    [string]$SolutionPath = "."
)

# Find all .csproj files
$projectFiles = Get-ChildItem -Path $SolutionPath -Recurse -Name "*.csproj"

Write-Host "Found $($projectFiles.Count) project files"

foreach ($projectFile in $projectFiles) {
    $fullPath = Join-Path $SolutionPath $projectFile
    Write-Host "Processing: $projectFile"

    try {
        $content = Get-Content $fullPath -Raw

        # Check if already has the settings
        if ($content -match "TreatWarningsAsErrors" -and $content -match "GenerateDocumentationFile") {
            Write-Host "  Already configured"
            continue
        }

        # Add settings after the first PropertyGroup
        $updated = $content -replace '(\s*<ImplicitUsings>enable</ImplicitUsings>\s*\n\s*<Nullable>enable</Nullable>)', '$1
    <TreatWarningsAsErrors>true</TreatWarningsAsErrors>
    <GenerateDocumentationFile>true</GenerateDocumentationFile>'

        # If that pattern didn't match, try a more general approach
        if ($updated -eq $content) {
            $updated = $content -replace '(\s*</PropertyGroup>)', '    <TreatWarningsAsErrors>true</TreatWarningsAsErrors>
    <GenerateDocumentationFile>true</GenerateDocumentationFile>
$1'
        }

        if ($updated -ne $content) {
            Set-Content $fullPath $updated -NoNewline
            Write-Host "  Updated successfully"
        } else {
            Write-Host "  No changes needed"
        }
    }
    catch {
        Write-Error "Failed to process $projectFile : $_"
    }
}

Write-Host "Project settings update completed"