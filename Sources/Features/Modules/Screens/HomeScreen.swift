import SwiftUI

struct HomeScreen: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Spacing.lg) {
                    // Level header
                    if let participant = appState.participant {
                        LevelHeaderView(
                            level: participant.level,
                            points: participant.points,
                            levelName: UserLevel.name(for: participant.level),
                            progress: UserLevel.progressInLevel(points: participant.points)
                        )
                    }

                    // Welcome card
                    CardView {
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            HStack {
                                if let participant = appState.participant {
                                    Image(systemName: avatarIcon(participant.avatar))
                                        .font(.system(size: 32))
                                        .foregroundColor(Color.AG.accent)
                                }
                                VStack(alignment: .leading) {
                                    Text("¡Hola, \(appState.participant?.id ?? "")!")
                                        .font(.AG.title)
                                        .foregroundColor(Color.AG.primaryText)
                                    Text("Continúa aprendiendo álgebra")
                                        .font(.AG.caption)
                                        .foregroundColor(Color.AG.secondaryText)
                                }
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal, Spacing.screenHorizontal)

                    // Overall progress
                    CardView {
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            Text("Progreso General")
                                .font(.AG.subtitle)
                                .foregroundColor(Color.AG.primaryText)

                            ProgressBarView(
                                progress: appState.participant?.overallProgress ?? 0,
                                height: 10
                            )

                            HStack {
                                Text("\(appState.participant?.completedModuleCount ?? 0) de 12 módulos")
                                    .font(.AG.caption)
                                    .foregroundColor(Color.AG.secondaryText)
                                Spacer()
                                Text("\(Int((appState.participant?.overallProgress ?? 0) * 100))%")
                                    .font(.AG.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.AG.accent)
                            }
                        }
                    }
                    .padding(.horizontal, Spacing.screenHorizontal)

                    // Streak info
                    if let participant = appState.participant {
                        CardView {
                            HStack {
                                Image(systemName: "flame.fill")
                                    .foregroundColor(.orange)
                                    .font(.title2)
                                VStack(alignment: .leading) {
                                    Text("Racha: \(participant.currentStreak()) días")
                                        .font(.AG.bodyBold)
                                        .foregroundColor(Color.AG.primaryText)
                                    Text("Mantén tu racha estudiando cada día")
                                        .font(.AG.caption)
                                        .foregroundColor(Color.AG.secondaryText)
                                }
                                Spacer()
                            }
                        }
                        .padding(.horizontal, Spacing.screenHorizontal)
                    }

                    // Next module suggestion
                    if let nextModule = findNextModule() {
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            Text("Continuar con:")
                                .font(.AG.subtitle)
                                .foregroundColor(Color.AG.primaryText)
                                .padding(.horizontal, Spacing.screenHorizontal)

                            NavigationLink(destination: ModuleDetailScreen(module: nextModule)) {
                                ModuleCard(
                                    module: nextModule,
                                    progress: appState.participant?.moduleProgress.first(where: { $0.moduleId == nextModule.id })
                                )
                            }
                            .padding(.horizontal, Spacing.screenHorizontal)
                        }
                    }

                    // Recent badges
                    if let participant = appState.participant {
                        let unlockedBadges = participant.badges.filter { $0.isUnlocked }
                        if !unlockedBadges.isEmpty {
                            VStack(alignment: .leading, spacing: Spacing.sm) {
                                Text("Insignias Recientes")
                                    .font(.AG.subtitle)
                                    .foregroundColor(Color.AG.primaryText)
                                    .padding(.horizontal, Spacing.screenHorizontal)

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: Spacing.sm) {
                                        ForEach(unlockedBadges.suffix(5)) { badge in
                                            BadgeMiniView(badge: badge)
                                        }
                                    }
                                    .padding(.horizontal, Spacing.screenHorizontal)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, Spacing.xxl)
            }
            .background(Color.AG.background)
            .navigationTitle("AlgebraGo")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    private func findNextModule() -> ModuleContent? {
        let allModules = ModuleContentData.allModules
        guard let participant = appState.participant else {
            return allModules.first
        }
        for module in allModules {
            let progress = participant.moduleProgress.first(where: { $0.moduleId == module.id })
            if progress == nil || progress?.status != .completed {
                return module
            }
        }
        return nil
    }
}

struct BadgeMiniView: View {
    let badge: Badge

    var body: some View {
        VStack(spacing: Spacing.xxs) {
            ZStack {
                Circle()
                    .fill(Color.AG.accent.opacity(0.15))
                    .frame(width: 50, height: 50)
                Image(systemName: badge.iconName)
                    .foregroundColor(Color.AG.accent)
                    .font(.title3)
            }
            Text(badge.name)
                .font(.AG.caption)
                .foregroundColor(Color.AG.primaryText)
                .lineLimit(1)
                .frame(width: 70)
        }
    }
}
