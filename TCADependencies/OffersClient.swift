import Dependencies
import XCTestDynamicOverlay

public enum OffersMode: Int {
    case none = 0
    case top = 2
    case all = 3
}

public class OffersClient {
    private let onLoadOffers: ((OffersMode) async throws -> Void)
    private let mode: OffersMode
    
    public init(
        mode: OffersMode = .none,
        onLoadOffers: @escaping (OffersMode) async throws -> Void
    ) {
        self.mode = mode
        self.onLoadOffers = onLoadOffers
    }
    
    private(set) public lazy var topOffers = OffersClient(mode: .top, onLoadOffers: onLoadOffers)
    
    public func loadOffers() async throws {
        precondition(mode != .none)
        
        try await onLoadOffers(mode)
    }
}

extension OffersClient {
    public static let unimplemented = OffersClient(
        onLoadOffers: XCTUnimplemented("onLoadOffers")
    )
}

private enum OffersClientKey: DependencyKey {
    static var liveValue = OffersClient.unimplemented
    static let previewValue = OffersClient.unimplemented
    static let testValue = OffersClient.unimplemented
}

extension DependencyValues {
    public var offersClient: OffersClient {
        get { self[OffersClientKey.self] }
        set { self[OffersClientKey.self] = newValue }
    }
}
