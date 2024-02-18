import CoreGraphics

/// `SwiftyCropConfiguration` is a struct that defines the configuration for cropping behavior.
public struct SwiftyCropConfiguration {
    let maxMagnificationScale: CGFloat
    let maskRadius: CGFloat
    
    /// Creates a new instance of `SwiftyCropConfiguration`.
    ///
    /// - Parameters:
    ///   - maxMagnificationScale: The maximum scale factor that the image can be magnified while cropping. Defaults to `4.0`.
    ///   - maskRadius: The radius of the mask used for cropping. Defaults to `130`.
    public init(maxMagnificationScale: CGFloat = 4.0, maskRadius: CGFloat = 150) {
        self.maxMagnificationScale = maxMagnificationScale
        self.maskRadius = maskRadius
    }
}
