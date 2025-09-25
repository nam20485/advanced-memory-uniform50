# Advanced Memory Uniform50

An MCP server-based advanced memory/recall/verification/reasoning system that combines GraphRAG structured knowledge retrieval with Mem0 agentic memory layer for enhanced AI reasoning capabilities.

## Overview

This system implements the "Two Brains" architecture:
- **GraphRAG Knowledge Service**: Structured domain expertise (the "digital library expert")
- **Mem0 Memory Service**: Personal, evolving user context (the "personal assistant memory")
- **MCP Server**: Unified tool orchestration layer for AI agents
- **Blazor WebAssembly Frontend**: Real-time monitoring and management interface

## 🏗️ Architecture

```
┌─────────────────┐    ┌──────────────────────────────────────┐
│   AI Agents     │────│            MCP Server               │
│ (Claude, etc.)  │    │     ┌─────────────────────────────┐  │
└─────────────────┘    │     │    Tool Orchestrator       │  │
                       │     └─────────────────────────────┘  │
                       │     ┌─────────────┬─────────────────┐│
                       │     │ Knowledge   │ Memory Service  ││
                       │     │ Service     │    (Mem0)       ││
                       │     │ (GraphRAG)  │                 ││
                       │     └─────────────┴─────────────────┘│
                       └──────────────────────────────────────┘
                                    │
                       ┌─────────────────────────────────────┐
                       │     Blazor WebAssembly Frontend     │
                       │     (Real-time Monitoring)          │
                       └─────────────────────────────────────┘
```

## 🚀 Quick Start

### Prerequisites

- .NET 9.0 SDK
- Docker Desktop
- OpenAI API Key

### Development Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/nam20485/advanced-memory-uniform50.git
   cd advanced-memory-uniform50
   ```

2. **Set up environment variables**:
   ```bash
   # Create .env file
   echo "OPENAI_API_KEY=your-openai-api-key" > .env
   ```

3. **Start infrastructure services**:
   ```bash
   cd docker
   docker-compose up -d neo4j qdrant redis
   ```

4. **Build and run the solution**:
   ```bash
   dotnet build
   dotnet run --project src/AdvancedMemory.MCP
   ```

5. **Access the application**:
   - MCP Server: http://localhost:8080
   - API Gateway: http://localhost:8081
   - Frontend Dashboard: http://localhost:8082
   - Neo4j Browser: http://localhost:7474
   - Qdrant Dashboard: http://localhost:6333/dashboard

### Docker Development

For a complete containerized development environment:

```bash
cd docker
docker-compose up --build
```

## 📁 Project Structure

```
AdvancedMemoryUniform50/
├─ src/
│  ├─ AdvancedMemory.Core/           # Shared models, interfaces, utilities
│  ├─ AdvancedMemory.GraphRAG/       # GraphRAG knowledge graph service
│  ├─ AdvancedMemory.Mem0/           # Mem0 agentic memory integration
│  ├─ AdvancedMemory.MCP/            # MCP server and tool orchestration
│  ├─ AdvancedMemory.Verification/   # Fact-checking and grounding service
│  ├─ AdvancedMemory.API/            # API gateway and service coordination
│  └─ AdvancedMemory.Frontend/       # Blazor WebAssembly monitoring UI
├─ tests/                            # Test projects
├─ docs/                             # Documentation and specifications
├─ scripts/                          # Build, deployment, and utility scripts
├─ docker/                           # Docker configurations
└─ assets/                           # Static assets and resources
```

## 🛠️ Technology Stack

### Backend
- **C# .NET 9.0** - Primary language and runtime
- **ASP.NET Core** - Web APIs and services
- **GraphRAG** - Knowledge graph construction and querying
- **Mem0** - Agentic memory management
- **Neo4j** - Graph database for knowledge and relationships
- **Qdrant** - Vector database for semantic search
- **Redis** - Caching and session state

### Frontend
- **Blazor WebAssembly** - Real-time monitoring interface
- **SignalR** - Real-time communication
- **Bootstrap 5** - UI framework
- **Chart.js** - Data visualization

### Infrastructure
- **Docker & Docker Compose** - Containerization
- **Terraform** - Infrastructure as Code
- **GitHub Actions** - CI/CD pipelines

## 📊 Core Features

### GraphRAG Knowledge Service
- **Document Processing**: Automated ingestion and chunking
- **Entity Extraction**: LLM-powered entity and relationship identification
- **Graph Construction**: Neo4j-based knowledge graph building
- **Community Detection**: Hierarchical clustering of related concepts
- **Multi-Modal Search**: Global (thematic) and local (entity-specific) queries

### Mem0 Memory Service
- **Multi-User Isolation**: Secure per-user memory spaces
- **Memory Types**: Working, episodic, factual, and semantic memory
- **Relationship Tracking**: Graph-based memory interconnections
- **Temporal Scoring**: Recency and importance-weighted retrieval

### MCP Server Integration
- **Standardized Protocol**: Model Context Protocol compliance
- **Tool Orchestration**: Composite operations and workflow management
- **Streaming Responses**: Real-time feedback via Server-Sent Events
- **Error Handling**: Robust error recovery and logging

### Monitoring Dashboard
- **System Metrics**: Performance, health, and resource utilization
- **User Activity**: Active sessions and operation tracking
- **Knowledge Status**: Graph statistics and indexing progress
- **Memory Analytics**: User memory growth and search patterns

## 🔧 Configuration

### Environment Variables

```env
# OpenAI Configuration
OPENAI_API_KEY=your-openai-api-key
OPENAI_MODEL=gpt-4o-mini
OPENAI_EMBEDDING_MODEL=text-embedding-3-small

# Database Configuration
NEO4J_URI=bolt://localhost:7687
NEO4J_USERNAME=neo4j
NEO4J_PASSWORD=password

QDRANT_HOST=localhost
QDRANT_PORT=6333

REDIS_CONNECTION_STRING=localhost:6379

# MCP Server Configuration
MCP_SERVER_PORT=8080
MCP_TOOLS_ENABLED=true

# Logging
SERILOG_MINIMUM_LEVEL=Information
ASPNETCORE_ENVIRONMENT=Development
```

### GraphRAG Settings

The GraphRAG service can be configured through `appsettings.json`:

```json
{
  "GraphRAG": {
    "ChunkSize": 1024,
    "ChunkOverlap": 200,
    "EmbeddingModel": "text-embedding-3-small",
    "ExtractionModel": "gpt-4o-mini",
    "CommunityReportModel": "gpt-4o-mini",
    "MaxTokens": 4000
  }
}
```

## 🧪 Testing

### Unit Tests
```bash
dotnet test tests/AdvancedMemory.Core.Tests
dotnet test tests/AdvancedMemory.GraphRAG.Tests
dotnet test tests/AdvancedMemory.MCP.Tests
```

### Integration Tests
```bash
dotnet test tests/AdvancedMemory.Integration.Tests
```

### Load Testing
```bash
# Install NBomber globally
dotnet tool install -g NBomber.Runner

# Run performance tests
nbomber run tests/AdvancedMemory.Performance.Tests
```

## 📖 API Documentation

### MCP Tools

The system exposes the following MCP tools for AI agents:

#### Knowledge Tools
- `query_knowledge_base(query, search_type, user_context?)` - Query the GraphRAG knowledge graph
- `get_knowledge_summary()` - Get overview of indexed knowledge

#### Memory Tools
- `search_user_memory(user_id, query, limit?)` - Search user's personal memory
- `add_interaction_memory(user_id, conversation_turn, metadata?)` - Store conversation context
- `get_user_profile(user_id)` - Get user preferences and context summary

#### Verification Tools
- `grounding_check(statement, sources?)` - Verify facts against trusted sources
- `confidence_score(claim)` - Get confidence level for factual claims

#### Composite Tools
- `get_comprehensive_answer(user_id, query)` - Orchestrated knowledge + memory + verification

### REST API Endpoints

The API Gateway exposes RESTful endpoints for direct service access:

```
GET  /api/health              # System health check
GET  /api/metrics             # Performance metrics
POST /api/knowledge/query     # Direct knowledge queries
POST /api/memory/search       # Direct memory searches
GET  /api/users/{id}/profile  # User profile information
```

## 🚢 Deployment

### Local Development
```bash
docker-compose -f docker/docker-compose.yml up --build
```

### Production Deployment

1. **Configure environment**:
   ```bash
   # Production environment variables
   export ASPNETCORE_ENVIRONMENT=Production
   export NEO4J_URI=neo4j+s://your-aura-instance.databases.neo4j.io
   export QDRANT_HOST=your-qdrant-cloud-cluster.qdrant.io
   ```

2. **Deploy with Terraform**:
   ```bash
   cd terraform
   terraform init
   terraform plan -var-file="production.tfvars"
   terraform apply
   ```

### Health Checks

The system includes comprehensive health checks:
- **Database Connectivity**: Neo4j, Qdrant, Redis
- **External APIs**: OpenAI API availability
- **Memory Usage**: System resource monitoring
- **Service Dependencies**: Cross-service communication

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes and add tests
4. Ensure all tests pass: `dotnet test`
5. Commit your changes: `git commit -m 'Add amazing feature'`
6. Push to the branch: `git push origin feature/amazing-feature`
7. Open a Pull Request

### Development Guidelines

- Follow C# coding standards and conventions
- Add XML documentation for all public APIs
- Include unit tests for new functionality
- Update integration tests for API changes
- Add appropriate logging and error handling

## 📋 Roadmap

### Phase 1: Foundation & Setup ✅
- [x] Project structure and solution setup
- [x] Core service scaffolding
- [x] Docker containerization
- [x] Basic CI/CD pipeline

### Phase 2: Core Services Implementation 🚧
- [ ] GraphRAG service with Neo4j integration
- [ ] Mem0 service with multi-user support
- [ ] MCP server with tool definitions
- [ ] Basic API gateway functionality

### Phase 3: MCP Integration & API Layer
- [ ] Complete MCP protocol implementation
- [ ] Tool orchestration and composite operations
- [ ] Authentication and authorization
- [ ] Error handling and resilience

### Phase 4: Frontend & Monitoring
- [ ] Blazor WebAssembly dashboard
- [ ] Real-time metrics and visualizations
- [ ] User management interface
- [ ] System configuration UI

### Phase 5: Advanced Features & Production Readiness
- [ ] Verification and grounding service
- [ ] Performance optimization and caching
- [ ] Security hardening
- [ ] Load testing and scalability validation

### Phase 6: Testing, Documentation & Deployment
- [ ] Comprehensive test coverage
- [ ] API documentation and developer guides
- [ ] Production deployment automation
- [ ] Performance monitoring and alerting

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Microsoft GraphRAG](https://github.com/microsoft/graphrag) for knowledge graph implementation
- [Mem0](https://mem0.ai) for agentic memory capabilities
- [Neo4j](https://neo4j.com) for graph database technology
- [Qdrant](https://qdrant.tech) for vector search capabilities
- [Model Context Protocol](https://modelcontextprotocol.io) for agent integration standards

## 📞 Support

- **Documentation**: [docs/](docs/)
- **Issues**: [GitHub Issues](https://github.com/nam20485/advanced-memory-uniform50/issues)
- **Discussions**: [GitHub Discussions](https://github.com/nam20485/advanced-memory-uniform50/discussions)

---

**Advanced Memory Uniform50** - Bridging the gap between structured knowledge and personal memory for next-generation AI agents.