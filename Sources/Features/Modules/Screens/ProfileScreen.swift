import SwiftUI

struct ProfileScreen: View {
    @Environment(AppState.self) private var appState
    @State private var showResearcherPanel = false
    @State private var showReflexiveSurvey = false
    @State private var showLogoutConfirmation = false

    var body: some View {
        NavigationStack {
            ScrollView {
                if let participant = appState.participant {
                    profileContent(participant: participant)
                } else {
                    Text("Sin datos")
                        .font(.AG.body)
                        .foregroundColor(Color.AG.secondaryText)
                        .padding(.top, Spacing.xxl)
                }
            }
            .background(Color.AG.background)
            .navigationTitle("Perfil")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showResearcherPanel) {
                ResearcherPanelScreen()
            }
            .sheet(isPresented: $showReflexiveSurvey) {
                ReflexiveSurveyScreen(
                    isExperimental: appState.participant?.groupType == .experimental,
                    onComplete: {
                        showReflexiveSurvey = false
                    }
                )
            }
        }
    }

    @ViewBuilder
    private func profileContent(participant: Participant) -> some View {
        VStack(spacing: Spacing.lg) {
            // Avatar and info
            CardView {
                VStack(spacing: Spacing.md) {
                    ZStack {
                        Circle()
                            .fill(Color.AG.accent.opacity(0.15))
                            .frame(width: 80, height: 80)
                        Image(systemName: avatarIcon(participant.avatar))
                            .font(.system(size: 36))
                            .foregroundColor(Color.AG.accent)
                    }

                    Text(participant.id)
                        .font(.AG.title)
                        .foregroundColor(Color.AG.primaryText)

                    HStack(spacing: Spacing.xl) {
                        VStack {
                            Text("\(participant.points)")
                                .font(.AG.subtitle)
                                .foregroundColor(Color.AG.accent)
                            Text("Puntos")
                                .font(.AG.caption)
                                .foregroundColor(Color.AG.secondaryText)
                        }
                        VStack {
                            Text(UserLevel.name(for: participant.level))
                                .font(.AG.subtitle)
                                .foregroundColor(Color.AG.accent)
                            Text("Nivel")
                                .font(.AG.caption)
                                .foregroundColor(Color.AG.secondaryText)
                        }
                        VStack {
                            Text("\(participant.currentStreak())")
                                .font(.AG.subtitle)
                                .foregroundColor(.orange)
                            Text("Racha")
                                .font(.AG.caption)
                                .foregroundColor(Color.AG.secondaryText)
                        }
                    }

                    ProgressBarView(
                        progress: UserLevel.progressInLevel(points: participant.points),
                        height: 8
                    )
                    Text("Progreso al siguiente nivel")
                        .font(.AG.caption)
                        .foregroundColor(Color.AG.secondaryText)
                }
            }
            .padding(.horizontal, Spacing.screenHorizontal)

            // Badges gallery
            badgesGallery(participant: participant)

            // Info section
            CardView {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Label("Nivel: \(participant.algebraLevel.displayName)", systemImage: "chart.bar")
                    Label("Grupo: \(participant.groupType == .experimental ? "Experimental" : "Control")", systemImage: "person.2")
                    Label("Semana: \(participant.currentWeekNumber())", systemImage: "calendar")
                }
                .font(.AG.body)
                .foregroundColor(Color.AG.primaryText)
            }
            .padding(.horizontal, Spacing.screenHorizontal)

            // Reflexive survey (only available after week 6)
            if participant.currentWeekNumber() >= 6 && participant.reflexiveResponse == nil {
                PrimaryButton(title: "Encuesta Reflexiva Final") {
                    showReflexiveSurvey = true
                }
                .padding(.horizontal, Spacing.screenHorizontal)
            }

            // Post-test
            if participant.currentWeekNumber() >= 6 && !participant.retentionTests.contains(where: { $0.form == "B" }) {
                SecondaryButton(title: "Realizar Post-Test") {
                    appState.showPostTest = true
                }
                .padding(.horizontal, Spacing.screenHorizontal)
            }

            // Researcher panel
            SecondaryButton(title: "Panel del Investigador") {
                showResearcherPanel = true
            }
            .padding(.horizontal, Spacing.screenHorizontal)

            // Logout
            Button {
                showLogoutConfirmation = true
            } label: {
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text("Cerrar Sesión")
                }
                .font(.AG.body)
                .foregroundColor(Color.AG.error)
                .frame(maxWidth: .infinity)
                .padding(.vertical, Spacing.md)
            }
            .padding(.horizontal, Spacing.screenHorizontal)
        }
        .padding(.bottom, Spacing.xxl)
        .alert("Cerrar Sesión", isPresented: $showLogoutConfirmation) {
            Button("Cancelar", role: .cancel) {}
            Button("Cerrar Sesión", role: .destructive) {
                appState.logout()
            }
        } message: {
            Text("Tus datos se conservan en el dispositivo. Podrás iniciar sesión con otro código de participante.")
        }
    }

    @ViewBuilder
    private func badgesGallery(participant: Participant) -> some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Insignias")
                .font(.AG.subtitle)
                .foregroundColor(Color.AG.primaryText)
                .padding(.horizontal, Spacing.screenHorizontal)

            let allBadges = Badge.allBadges.map { badge -> Badge in
                if let unlocked = participant.badges.first(where: { $0.id == badge.id }), unlocked.isUnlocked {
                    return unlocked
                }
                return badge
            }

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: Spacing.md) {
                ForEach(allBadges) { badge in
                    BadgeView(badge: badge)
                }
            }
            .padding(.horizontal, Spacing.screenHorizontal)
        }
    }
}

struct BadgeView: View {
    let badge: Badge

    var body: some View {
        VStack(spacing: Spacing.xxs) {
            ZStack {
                Circle()
                    .fill(badge.isUnlocked ? Color.AG.accent.opacity(0.15) : Color.AG.progressBarBackground)
                    .frame(width: 56, height: 56)

                Image(systemName: badge.iconName)
                    .foregroundColor(badge.isUnlocked ? Color.AG.accent : Color.AG.secondaryText.opacity(0.4))
                    .font(.title2)

                if !badge.isUnlocked {
                    Image(systemName: "lock.fill")
                        .font(.caption2)
                        .foregroundColor(Color.AG.secondaryText)
                        .offset(x: 16, y: 16)
                }
            }

            Text(badge.name)
                .font(.system(size: 10))
                .foregroundColor(badge.isUnlocked ? Color.AG.primaryText : Color.AG.secondaryText)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(width: 70, height: 28)
        }
        .accessibilityLabel("\(badge.name), \(badge.isUnlocked ? "desbloqueada" : "bloqueada")")
    }
}
