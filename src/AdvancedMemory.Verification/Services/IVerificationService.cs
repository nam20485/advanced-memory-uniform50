namespace AdvancedMemory.Verification.Services;

/// <summary>
/// Service for fact verification and grounding operations.
/// </summary>
public interface IVerificationService
{
    /// <summary>
    /// Verifies a factual statement against trusted sources.
    /// </summary>
    /// <param name="statement">The statement to verify.</param>
    /// <param name="sources">Optional specific sources to check against.</param>
    /// <returns>The verification result.</returns>
    Task<VerificationResult> VerifyAsync(string statement, IEnumerable<string>? sources = null);

    /// <summary>
    /// Gets a confidence score for a factual claim.
    /// </summary>
    /// <param name="claim">The claim to evaluate.</param>
    /// <returns>A confidence score between 0 and 1.</returns>
    Task<float> GetConfidenceScoreAsync(string claim);
}

/// <summary>
/// Represents the result of a fact verification operation.
/// </summary>
public class VerificationResult
{
    /// <summary>
    /// Gets or sets a value indicating whether the statement is verified.
    /// </summary>
    public bool IsVerified { get; set; }

    /// <summary>
    /// Gets or sets the confidence score for the verification.
    /// </summary>
    public float Confidence { get; set; }

    /// <summary>
    /// Gets or sets the sources used for verification.
    /// </summary>
    public IEnumerable<string> Sources { get; set; } = Enumerable.Empty<string>();

    /// <summary>
    /// Gets or sets additional verification details.
    /// </summary>
    public string? Details { get; set; }
}