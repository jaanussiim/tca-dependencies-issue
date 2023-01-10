import ComposableArchitecture
import SwiftUI

public struct BestOffersView: View {
    let store: StoreOf<BestOffers>
    
    public var body: some View {
        WithViewStore(store) {
            viewStore in
            
            Text("Best offers")
                .onAppear {
                    viewStore.send(.loadOffers)
                }
        }
    }
}
