# Technology Stack

## Overview
This document outlines the complete technology stack for the advanced-memory-uniform50 project, implementing an MCP server-based advanced memory/recall/verification/reasoning system.

## Core Technologies

### Language & Runtime
- **C# .NET 9.0** - Primary development language
- **SDK Version**: 9.0.0 with "latestFeature" rollForward policy
- **Target Framework**: net9.0

### Frontend Framework
- **Blazor WebAssembly** - Real-time monitoring dashboard
- **SignalR** - Real-time communication between backend services and frontend
- **Bootstrap 5** - UI styling and components
- **Chart.js** - Data visualization and metrics display

### Backend Architecture
- **ASP.NET Core** - API services and web hosts
- **FastAPI-style MCP Server** - Model Context Protocol implementation
- **Microservices Architecture** - Separate services for each logical domain
- **REST APIs** - Inter-service communication
- **Server-Sent Events (SSE)** - MCP transport layer

### AI & Machine Learning
- **OpenAI API / Azure OpenAI** - Language model services
- **GraphRAG** - Knowledge graph construction and querying
  - Microsoft graphrag library (primary)
  - neo4j-graphrag library (alternative)
  - LlamaIndex GraphRAG (modular option)
- **Mem0** - Agentic memory management
  - Python SDK integration via REST bridge
  - Multi-user memory isolation
- **Model Context Protocol (MCP)** - Standardized agent-tool communication

### Databases & Storage
- **Neo4j** - Graph database for knowledge graphs and memory relationships
  - AuraDB (managed) or self-hosted
  - Cypher query language
  - Community detection algorithms
- **Qdrant** - Vector database for semantic search
  - Vector embeddings storage
  - Similarity search operations
- **Parquet Files** - GraphRAG artifact storage
- **SQLite** - Local configuration and metadata storage

### Embedding & Vector Processing
- **OpenAI Embeddings** - text-embedding-3-small/large
- **Sentence Transformers** - Alternative embedding models
- **FAISS** - Vector similarity search (backup option)

### Observability & Logging
- **Serilog** - Structured logging
- **OpenTelemetry** - Distributed tracing and metrics
- **Application Insights** - Azure-based monitoring (optional)
- **Prometheus** - Metrics collection
- **Grafana** - Metrics visualization

### Containerization & Infrastructure
- **Docker** - Container runtime
- **Docker Compose** - Local development orchestration
- **Multi-stage builds** - Optimized container images
- **Terraform** - Infrastructure as Code
- **Kubernetes** - Production orchestration (optional)

### Development Tools
- **MSBuild** - Build system
- **NuGet** - Package management
- **GitHub Actions** - CI/CD pipeline
- **SonarQube** - Code quality analysis
- **OWASP Dependency Check** - Security scanning

### Testing Framework
- **xUnit** - Unit testing framework
- **Moq** - Mocking framework
- **TestContainers** - Integration testing with real databases
- **Playwright** - End-to-end testing
- **NBomber** - Performance/load testing

## Service Dependencies

### GraphRAG Service Dependencies
```xml
<PackageReference Include="Microsoft.Extensions.Hosting" Version="8.0.0" />
<PackageReference Include="Microsoft.Extensions.Logging" Version="8.0.0" />
<PackageReference Include="Neo4j.Driver" Version="5.25.0" />
<PackageReference Include="System.CommandLine" Version="2.0.0" />
<PackageReference Include="CsvHelper" Version="33.0.1" />
```

### Mem0 Service Dependencies
```xml
<PackageReference Include="RestSharp" Version="111.4.1" />
<PackageReference Include="Microsoft.Extensions.Http" Version="8.0.0" />
<PackageReference Include="System.Text.Json" Version="8.0.0" />
```

### MCP Service Dependencies
```xml
<PackageReference Include="Microsoft.AspNetCore.App" Version="9.0.0" />
<PackageReference Include="Microsoft.AspNetCore.SignalR" Version="8.0.0" />
<PackageReference Include="Swashbuckle.AspNetCore" Version="6.8.1" />
```

### Frontend Dependencies
```xml
<PackageReference Include="Microsoft.AspNetCore.Components.WebAssembly" Version="9.0.0" />
<PackageReference Include="Microsoft.AspNetCore.Components.WebAssembly.DevServer" Version="9.0.0" />
<PackageReference Include="Microsoft.AspNetCore.SignalR.Client" Version="8.0.0" />
```

## External Service Dependencies

### Required External Services
- **OpenAI API** - Language model access (GPT-4, embeddings)
- **Neo4j Database** - Graph storage (AuraDB recommended for production)
- **Qdrant Vector Database** - Vector storage and search

### Optional External Services
- **Azure OpenAI** - Alternative to OpenAI API
- **Application Insights** - Azure monitoring
- **Azure Container Registry** - Container image storage

## Development Environment Setup

### Prerequisites
- .NET 9.0 SDK
- Docker Desktop
- Neo4j (via Docker or AuraDB)
- Qdrant (via Docker or cloud)
- Visual Studio 2022 / VS Code
- Git

### Environment Variables
```env
OPENAI_API_KEY=your-openai-key
NEO4J_URI=bolt://localhost:7687
NEO4J_USERNAME=neo4j
NEO4J_PASSWORD=password
QDRANT_HOST=localhost
QDRANT_PORT=6333
MEM0_API_KEY=your-mem0-key (if using managed)
```

## Architecture Decisions

### Why C# over Python?
- Better enterprise integration and tooling
- Strongly typed system reduces runtime errors
- Superior performance for API services
- Seamless integration with existing .NET ecosystems

### Why Neo4j for Graph Storage?
- Native graph database with Cypher query language
- Excellent GraphRAG integration
- Community detection algorithms built-in
- Scales well for production workloads

### Why Blazor WebAssembly?
- Real-time updates via SignalR
- Shared C# codebase between frontend and backend
- Rich ecosystem of .NET UI components
- Strong TypeScript interop for chart libraries

### Why MCP over REST?
- Standardized agent-tool communication protocol
- Streaming support for real-time interactions
- Better suited for agentic workflows
- Future-proof for AI ecosystem evolution