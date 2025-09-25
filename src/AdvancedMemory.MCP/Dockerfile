# Multi-stage build for MCP Server
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy solution and project files
COPY ["AdvancedMemoryUniform50.sln", "AdvancedMemoryUniform50.sln"]
COPY ["global.json", "global.json"]

# Copy project files for restore
COPY ["src/AdvancedMemory.Core/AdvancedMemory.Core.csproj", "src/AdvancedMemory.Core/"]
COPY ["src/AdvancedMemory.GraphRAG/AdvancedMemory.GraphRAG.csproj", "src/AdvancedMemory.GraphRAG/"]
COPY ["src/AdvancedMemory.Mem0/AdvancedMemory.Mem0.csproj", "src/AdvancedMemory.Mem0/"]
COPY ["src/AdvancedMemory.MCP/AdvancedMemory.MCP.csproj", "src/AdvancedMemory.MCP/"]
COPY ["src/AdvancedMemory.Verification/AdvancedMemory.Verification.csproj", "src/AdvancedMemory.Verification/"]

# Restore dependencies
RUN dotnet restore "src/AdvancedMemory.MCP/AdvancedMemory.MCP.csproj"

# Copy source code
COPY . .

# Build the application
WORKDIR "/src/src/AdvancedMemory.MCP"
RUN dotnet build "AdvancedMemory.MCP.csproj" -c Release -o /app/build --no-restore

FROM build AS publish
RUN dotnet publish "AdvancedMemory.MCP.csproj" -c Release -o /app/publish --no-restore

FROM base AS final
WORKDIR /app

# Install Python and dependencies for GraphRAG
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create Python virtual environment and install GraphRAG
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --upgrade pip && \
    pip install graphrag==0.3.6

# Copy application
COPY --from=publish /app/publish .

# Create non-root user
RUN adduser --disabled-password --gecos '' --shell /bin/bash --uid 1001 appuser
RUN chown -R appuser:appuser /app
USER appuser

ENTRYPOINT ["dotnet", "AdvancedMemory.MCP.dll"]