namespace AdvancedMemory.Mem0.Services;

/// <summary>
/// Service for Mem0 agentic memory operations.
/// </summary>
public interface IMemoryService
{
    /// <summary>
    /// Searches the user's memory for relevant information.
    /// </summary>
    /// <param name="userId">The unique identifier for the user.</param>
    /// <param name="query">The search query.</param>
    /// <param name="limit">The maximum number of results to return.</param>
    /// <returns>The search results.</returns>
    Task<IEnumerable<MemoryResult>> SearchAsync(string userId, string query, int limit = 5);

    /// <summary>
    /// Adds a new memory for the specified user.
    /// </summary>
    /// <param name="userId">The unique identifier for the user.</param>
    /// <param name="content">The memory content to store.</param>
    /// <param name="metadata">Optional metadata for the memory.</param>
    /// <returns>A task representing the add operation.</returns>
    Task AddMemoryAsync(string userId, string content, IDictionary<string, object>? metadata = null);
}

/// <summary>
/// Represents a memory search result.
/// </summary>
public class MemoryResult
{
    /// <summary>
    /// Gets or sets the memory identifier.
    /// </summary>
    public string Id { get; set; } = string.Empty;

    /// <summary>
    /// Gets or sets the memory content.
    /// </summary>
    public string Content { get; set; } = string.Empty;

    /// <summary>
    /// Gets or sets the relevance score.
    /// </summary>
    public float Score { get; set; }

    /// <summary>
    /// Gets or sets the memory metadata.
    /// </summary>
    public IDictionary<string, object> Metadata { get; set; } = new Dictionary<string, object>();
}