import SwiftUI
import SwiftData

@main
struct AlgebraGoApp: App {
    @State private var appState = AppState.shared

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(appState)
        }
    }
}
