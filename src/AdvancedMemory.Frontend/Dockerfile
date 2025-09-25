# Multi-stage build for Blazor WebAssembly Frontend
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 8082

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy solution and project files
COPY ["AdvancedMemoryUniform50.sln", "AdvancedMemoryUniform50.sln"]
COPY ["global.json", "global.json"]

# Copy project files for restore
COPY ["src/AdvancedMemory.Core/AdvancedMemory.Core.csproj", "src/AdvancedMemory.Core/"]
COPY ["src/AdvancedMemory.Frontend/AdvancedMemory.Frontend.csproj", "src/AdvancedMemory.Frontend/"]

# Restore dependencies
RUN dotnet restore "src/AdvancedMemory.Frontend/AdvancedMemory.Frontend.csproj"

# Copy source code
COPY . .

# Build the application
WORKDIR "/src/src/AdvancedMemory.Frontend"
RUN dotnet build "AdvancedMemory.Frontend.csproj" -c Release -o /app/build --no-restore

FROM build AS publish
RUN dotnet publish "AdvancedMemory.Frontend.csproj" -c Release -o /app/publish --no-restore

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Create non-root user
RUN adduser --disabled-password --gecos '' --shell /bin/bash --uid 1001 appuser
RUN chown -R appuser:appuser /app
USER appuser

ENTRYPOINT ["dotnet", "AdvancedMemory.Frontend.dll"]