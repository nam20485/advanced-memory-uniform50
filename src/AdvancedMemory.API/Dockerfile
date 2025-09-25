# Multi-stage build for API Gateway
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy solution and project files
COPY ["AdvancedMemoryUniform50.sln", "AdvancedMemoryUniform50.sln"]
COPY ["global.json", "global.json"]

# Copy project files for restore
COPY ["src/AdvancedMemory.Core/AdvancedMemory.Core.csproj", "src/AdvancedMemory.Core/"]
COPY ["src/AdvancedMemory.API/AdvancedMemory.API.csproj", "src/AdvancedMemory.API/"]

# Restore dependencies
RUN dotnet restore "src/AdvancedMemory.API/AdvancedMemory.API.csproj"

# Copy source code
COPY . .

# Build the application
WORKDIR "/src/src/AdvancedMemory.API"
RUN dotnet build "AdvancedMemory.API.csproj" -c Release -o /app/build --no-restore

FROM build AS publish
RUN dotnet publish "AdvancedMemory.API.csproj" -c Release -o /app/publish --no-restore

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Create non-root user
RUN adduser --disabled-password --gecos '' --shell /bin/bash --uid 1001 appuser
RUN chown -R appuser:appuser /app
USER appuser

ENTRYPOINT ["dotnet", "AdvancedMemory.API.dll"]