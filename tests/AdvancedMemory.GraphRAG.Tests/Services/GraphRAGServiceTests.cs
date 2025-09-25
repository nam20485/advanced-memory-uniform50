using AdvancedMemory.GraphRAG.Services;
using Xunit;

namespace AdvancedMemory.GraphRAG.Tests.Services;

/// <summary>
/// Unit tests for GraphRAG service implementations.
/// </summary>
public class GraphRAGServiceTests
{
    /// <summary>
    /// Tests that the service interface is properly defined.
    /// </summary>
    [Fact]
    public void IGraphRAGService_HasRequiredMethods()
    {
        var serviceType = typeof(IGraphRAGService);

        Assert.NotNull(serviceType.GetMethod("QueryAsync"));
        Assert.NotNull(serviceType.GetMethod("IndexDocumentsAsync"));
    }
}