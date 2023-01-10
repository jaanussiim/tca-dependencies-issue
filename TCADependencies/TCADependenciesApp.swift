import ComposableArchitecture
import SwiftUI

@main
struct TCADependenciesApp: App {
    var body: some Scene {
        WindowGroup {
            ApplicationView(
                store: Store(
                    initialState: Application.State(),
                    reducer: Application()
                        .dependency(\.offersClient, .live)
                )
            )
        }
    }
}
