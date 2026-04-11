import SwiftUI

struct MainTabView: View {
    @Environment(AppState.self) private var appState
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeScreen()
                .tag(0)
                .tabItem {
                    Label("Inicio", systemImage: "house.fill")
                }

            ModulesListScreen()
                .tag(1)
                .tabItem {
                    Label("Módulos", systemImage: "book.fill")
                }

            ProgressScreen()
                .tag(2)
                .tabItem {
                    Label("Progreso", systemImage: "chart.bar.fill")
                }

            ProfileScreen()
                .tag(3)
                .tabItem {
                    Label("Perfil", systemImage: "person.fill")
                }
        }
        .tint(Color.AG.accent)
        .onAppear {
            appState.participant?.recordActiveDay()
            if let p = appState.participant {
                appState.saveParticipant(p)
            }
            appState.checkSARTNeeded()
        }
    }
}
