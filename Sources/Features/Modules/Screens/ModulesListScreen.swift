import SwiftUI

struct ModulesListScreen: View {
    @Environment(AppState.self) private var appState
    @State private var selectedUnit = 0

    private let units = ["Ecuaciones Lineales", "Polinomios", "Sistemas de Ecuaciones"]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Level header
                if let participant = appState.participant {
                    LevelHeaderView(
                        level: participant.level,
                        points: participant.points,
                        levelName: UserLevel.name(for: participant.level),
                        progress: UserLevel.progressInLevel(points: participant.points)
                    )
                }

                // Unit picker
                Picker("Unidad", selection: $selectedUnit) {
                    ForEach(0..<3) { index in
                        Text("Unidad \(index + 1)")
                            .tag(index)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, Spacing.screenHorizontal)
                .padding(.vertical, Spacing.sm)

                // Unit title
                Text(units[selectedUnit])
                    .font(.AG.subtitle)
                    .foregroundColor(Color.AG.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, Spacing.screenHorizontal)
                    .padding(.bottom, Spacing.sm)

                ScrollView {
                    LazyVStack(spacing: Spacing.md) {
                        let unitModules = ModuleContentData.allModules.filter { $0.unitNumber == selectedUnit + 1 }
                        ForEach(unitModules) { module in
                            NavigationLink(destination: ModuleDetailScreen(module: module)) {
                                ModuleCard(
                                    module: module,
                                    progress: appState.participant?.moduleProgress.first(where: { $0.moduleId == module.id })
                                )
                            }
                        }
                    }
                    .padding(.horizontal, Spacing.screenHorizontal)
                    .padding(.bottom, Spacing.xxl)
                }
            }
            .background(Color.AG.background)
            .navigationTitle("Módulos")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ModuleCard: View {
    let module: ModuleContent
    let progress: ModuleProgress?

    private var statusIcon: String {
        switch progress?.status {
        case .completed: return "checkmark.circle.fill"
        case .inProgress: return "clock.fill"
        default: return "circle"
        }
    }

    private var statusColor: Color {
        switch progress?.status {
        case .completed: return Color.AG.success
        case .inProgress: return Color.AG.accent
        default: return Color.AG.secondaryText
        }
    }

    var body: some View {
        CardView {
            HStack(spacing: Spacing.md) {
                // Status icon
                Image(systemName: statusIcon)
                    .foregroundColor(statusColor)
                    .font(.title2)

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text("Módulo \(module.unitNumber).\(module.moduleNumber)")
                        .font(.AG.caption)
                        .foregroundColor(Color.AG.secondaryText)
                    Text(module.title)
                        .font(.AG.bodyBold)
                        .foregroundColor(Color.AG.primaryText)
                        .multilineTextAlignment(.leading)

                    if let progress, progress.status == .completed {
                        let score = progress.quizAttempts.first?.score ?? 0
                        Text("Puntaje: \(Int(score * 100))%")
                            .font(.AG.caption)
                            .foregroundColor(Color.AG.success)
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(Color.AG.secondaryText)
            }
        }
    }
}
