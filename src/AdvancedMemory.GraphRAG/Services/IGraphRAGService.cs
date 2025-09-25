namespace AdvancedMemory.GraphRAG.Services;

/// <summary>
/// Service for GraphRAG knowledge graph operations.
/// </summary>
public interface IGraphRAGService
{
    /// <summary>
    /// Queries the knowledge graph using the specified search type.
    /// </summary>
    /// <param name="query">The natural language query.</param>
    /// <param name="searchType">The type of search to perform (global or local).</param>
    /// <param name="userContext">Optional user context for personalization.</param>
    /// <returns>The search results.</returns>
    Task<string> QueryAsync(string query, string searchType, string? userContext = null);

    /// <summary>
    /// Indexes documents into the knowledge graph.
    /// </summary>
    /// <param name="documents">The documents to index.</param>
    /// <returns>A task representing the indexing operation.</returns>
    Task IndexDocumentsAsync(IEnumerable<string> documents);
}