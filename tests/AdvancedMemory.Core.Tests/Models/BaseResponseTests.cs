using AdvancedMemory.Core.Models;
using Xunit;

namespace AdvancedMemory.Core.Tests.Models;

/// <summary>
/// Unit tests for the BaseResponse class.
/// </summary>
public class BaseResponseTests
{
    /// <summary>
    /// Test implementation of BaseResponse for testing purposes.
    /// </summary>
    private class TestResponse : BaseResponse
    {
        /// <summary>
        /// Gets or sets test data.
        /// </summary>
        public string? TestData { get; set; }
    }

    /// <summary>
    /// Tests that BaseResponse initializes with default values correctly.
    /// </summary>
    [Fact]
    public void BaseResponse_InitializesWithDefaults()
    {
        var response = new TestResponse();

        Assert.True(response.Success);
        Assert.Null(response.ErrorMessage);
        Assert.True(response.Timestamp > DateTime.UtcNow.AddMinutes(-1));
    }
}