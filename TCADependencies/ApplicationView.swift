import ComposableArchitecture
import SwiftUI

public struct ApplicationView: View {
    let store: StoreOf<Application>
    
    public var body: some View {
        BestOffersView(
            store: store.scope(state: \.bestOffersState, action: Application.Action.bestOffers)
        )
    }
}
