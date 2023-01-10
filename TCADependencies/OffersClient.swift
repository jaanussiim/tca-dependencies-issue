import Dependencies
import XCTestDynamicOverlay

public enum OffersMode: Int {
    case none = 0
    case top = 2
    case all = 3
}

public struct OffersClient {
    private let handler: Handler
    
    private let allHandler: Handler?
    private let topHandler: Handler?
    
    public init(
        mode: OffersMode = .none,
        onLoadOffers: @escaping (OffersMode) async throws -> Void
    ) {
        self.handler = Handler(
            mode: .none,
            onLoadOffers: unimplemented()
        )
        
        allHandler = Handler(mode: .all, onLoadOffers: onLoadOffers)
        topHandler = Handler(mode: .top, onLoadOffers: onLoadOffers)
    }
    
    private init(handler: Handler) {
        self.handler = handler
        
        allHandler = nil
        topHandler = nil
    }

    public var allOffers: OffersClient {
        OffersClient(
            handler: allHandler!
        )
    }
    
    public var topOffers: OffersClient {
        OffersClient(
            handler: topHandler!
        )
    }

    public func loadOffers() async throws {
        try await handler.loadOffers()
    }
    
    public func loadNextPage() async {
        await handler.loadNextPage()
    }
}

private class Handler {
    private let onLoadOffers: ((OffersMode) async throws -> Void)
    private let mode: OffersMode

    private var loadedPage = 0
    private var hasMore = false
    
    init(
        mode: OffersMode = .none,
        onLoadOffers: @escaping (OffersMode) async throws -> Void
    ) {
        self.mode = mode
        self.onLoadOffers = onLoadOffers
    }
    
    public func loadOffers() async throws {
        precondition(mode != .none)
        
        try await onLoadOffers(mode)
    }
    
    public func loadNextPage() async {
        await load(page: loadedPage + 1)
    }
    
    private func load(page: Int) async {
        
    }
}

extension OffersClient {
    public static let failing = OffersClient(
        onLoadOffers: unimplemented("onLoadOffers")
    )
}

private enum OffersClientKey: DependencyKey {
    static var liveValue = OffersClient.failing
    static let previewValue = OffersClient.failing
    static let testValue = OffersClient.failing
}

extension DependencyValues {
    public var offersClient: OffersClient {
        get { self[OffersClientKey.self] }
        set { self[OffersClientKey.self] = newValue }
    }
}
