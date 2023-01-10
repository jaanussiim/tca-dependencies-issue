import ComposableArchitecture

public struct BestOffers: ReducerProtocol {
    public struct State: Equatable {
        public init() {
            
        }
    }
    
    public enum Action {
        case loadOffers
    }
    
    public init() {
        
    }
    
    @Dependency(\.offersClient) var offersClient
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce {
            state, action in
            
            switch action {
            case .loadOffers:
                return EffectTask.fireAndForget {
                    try await offersClient.loadOffers()
                }
            }
        }
    }
}

