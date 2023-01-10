import ComposableArchitecture

public struct Application: ReducerProtocol {
    public struct State: Equatable {
        internal var bestOffersState = BestOffers.State()
        
        public init() {
            
        }
    }
    
    public enum Action {
        case bestOffers(BestOffers.Action)
    }
    
    public init() {
        
    }
    
    @Dependency(\.offersClient) var offersClient
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce {
            state, action in
            
            return .none
        }
        Scope(state: \.bestOffersState, action: /Action.bestOffers) {
            BestOffers()
                .dependency(\.offersClient, offersClient.topOffers)
        }
    }
}

