import SwiftUI

struct OnboardingFlow: View {
    @Environment(AppState.self) private var appState
    @State private var step: OnboardingStep = .welcome
    @State private var participantId = ""
    @State private var selectedAvatar = 1
    @State private var algebraLevel: AlgebraLevel = .basico
    @State private var groupType: GroupType = .experimental
    @State private var showError = false

    enum OnboardingStep {
        case welcome
        case participantCode
        case avatarSelection
        case levelSelection
        case groupSelection
        case ready
    }

    var body: some View {
        ZStack {
            Color.AG.background.ignoresSafeArea()

            VStack(spacing: 0) {
                // Progress indicators
                HStack(spacing: Spacing.xs) {
                    ForEach(0..<6) { index in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(index <= stepIndex ? Color.AG.accent : Color.AG.progressBarBackground)
                            .frame(height: 4)
                    }
                }
                .padding(.horizontal, Spacing.screenHorizontal)
                .padding(.top, Spacing.md)

                ScrollView {
                    VStack(spacing: Spacing.xl) {
                        switch step {
                        case .welcome:
                            welcomeView
                        case .participantCode:
                            participantCodeView
                        case .avatarSelection:
                            avatarSelectionView
                        case .levelSelection:
                            levelSelectionView
                        case .groupSelection:
                            groupSelectionView
                        case .ready:
                            readyView
                        }
                    }
                    .padding(.horizontal, Spacing.screenHorizontal)
                    .padding(.top, Spacing.xxl)
                    .padding(.bottom, 100)
                }

                Spacer()

                // Bottom button
                VStack {
                    if step == .ready {
                        PrimaryButton(title: "Comenzar") {
                            completeOnboarding()
                        }
                    } else {
                        PrimaryButton(
                            title: "Continuar",
                            isEnabled: canProceed
                        ) {
                            advanceStep()
                        }
                    }
                }
                .padding(.horizontal, Spacing.screenHorizontal)
                .padding(.bottom, Spacing.xl)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: step)
    }

    private var stepIndex: Int {
        switch step {
        case .welcome: return 0
        case .participantCode: return 1
        case .avatarSelection: return 2
        case .levelSelection: return 3
        case .groupSelection: return 4
        case .ready: return 5
        }
    }

    private var canProceed: Bool {
        switch step {
        case .participantCode:
            return !participantId.trimmingCharacters(in: .whitespaces).isEmpty
        default:
            return true
        }
    }

    // MARK: - Step Views

    private var welcomeView: some View {
        VStack(spacing: Spacing.lg) {
            Image(systemName: "function")
                .font(.system(size: 60))
                .foregroundColor(Color.AG.accent)

            Text("¡Bienvenido a AlgebraGo!")
                .font(.AG.largeTitle)
                .foregroundColor(Color.AG.primaryText)
                .multilineTextAlignment(.center)

            Text("Esta aplicación forma parte de una investigación académica sobre el aprendizaje de álgebra. Tu participación es completamente anónima.")
                .font(.AG.body)
                .foregroundColor(Color.AG.secondaryText)
                .multilineTextAlignment(.center)

            CardView {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Label("Aprenderás álgebra con módulos interactivos", systemImage: "book")
                    Label("Completarás quizzes para practicar", systemImage: "checkmark.circle")
                    Label("Tu progreso se guarda localmente", systemImage: "iphone")
                    Label("No se recopila información personal", systemImage: "lock.shield")
                }
                .font(.AG.body)
                .foregroundColor(Color.AG.primaryText)
            }
        }
    }

    private var participantCodeView: some View {
        VStack(spacing: Spacing.lg) {
            Image(systemName: "person.badge.key")
                .font(.system(size: 50))
                .foregroundColor(Color.AG.accent)

            Text("Código de Participante")
                .font(.AG.title)
                .foregroundColor(Color.AG.primaryText)

            Text("Ingresa el código que te fue asignado por el investigador (ej: P01, P02...)")
                .font(.AG.body)
                .foregroundColor(Color.AG.secondaryText)
                .multilineTextAlignment(.center)

            TextField("Código (ej: P01)", text: $participantId)
                .textFieldStyle(.roundedBorder)
                .font(.AG.subtitle)
                .multilineTextAlignment(.center)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.characters)
                .padding(.horizontal, Spacing.xxl)
        }
    }

    private var avatarSelectionView: some View {
        VStack(spacing: Spacing.lg) {
            Text("Elige tu Avatar")
                .font(.AG.title)
                .foregroundColor(Color.AG.primaryText)

            Text("Selecciona un ícono que te represente")
                .font(.AG.body)
                .foregroundColor(Color.AG.secondaryText)

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: Spacing.md) {
                ForEach(1...6, id: \.self) { index in
                    AvatarOption(
                        index: index,
                        isSelected: selectedAvatar == index,
                        onSelect: { selectedAvatar = index }
                    )
                }
            }
            .padding(.horizontal, Spacing.md)
        }
    }

    private var levelSelectionView: some View {
        VStack(spacing: Spacing.lg) {
            Image(systemName: "chart.bar")
                .font(.system(size: 50))
                .foregroundColor(Color.AG.accent)

            Text("Nivel en Álgebra")
                .font(.AG.title)
                .foregroundColor(Color.AG.primaryText)

            Text("¿Cómo describes tu nivel actual en álgebra?")
                .font(.AG.body)
                .foregroundColor(Color.AG.secondaryText)
                .multilineTextAlignment(.center)

            VStack(spacing: Spacing.sm) {
                ForEach(AlgebraLevel.allCases, id: \.self) { level in
                    SelectionRow(
                        title: level.rawValue,
                        subtitle: levelSubtitle(level),
                        isSelected: algebraLevel == level,
                        onSelect: { algebraLevel = level }
                    )
                }
            }
        }
    }

    private var groupSelectionView: some View {
        VStack(spacing: Spacing.lg) {
            Image(systemName: "person.2")
                .font(.system(size: 50))
                .foregroundColor(Color.AG.accent)

            Text("Grupo de Estudio")
                .font(.AG.title)
                .foregroundColor(Color.AG.primaryText)

            Text("El investigador te indicará a qué grupo perteneces.")
                .font(.AG.body)
                .foregroundColor(Color.AG.secondaryText)
                .multilineTextAlignment(.center)

            VStack(spacing: Spacing.sm) {
                SelectionRow(
                    title: "Grupo Experimental",
                    subtitle: "Aprenderás con la app interactiva",
                    isSelected: groupType == .experimental,
                    onSelect: { groupType = .experimental }
                )
                SelectionRow(
                    title: "Grupo Control",
                    subtitle: "Aprenderás con material de estudio",
                    isSelected: groupType == .control,
                    onSelect: { groupType = .control }
                )
            }
        }
    }

    private var readyView: some View {
        VStack(spacing: Spacing.lg) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(Color.AG.success)

            Text("¡Todo listo!")
                .font(.AG.largeTitle)
                .foregroundColor(Color.AG.primaryText)

            CardView {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    HStack {
                        Text("Código:")
                            .fontWeight(.semibold)
                        Text(participantId)
                    }
                    HStack {
                        Text("Avatar:")
                            .fontWeight(.semibold)
                        Image(systemName: avatarIcon(selectedAvatar))
                    }
                    HStack {
                        Text("Nivel:")
                            .fontWeight(.semibold)
                        Text(algebraLevel.rawValue)
                    }
                    HStack {
                        Text("Grupo:")
                            .fontWeight(.semibold)
                        Text(groupType == .experimental ? "Experimental" : "Control")
                    }
                }
                .font(.AG.body)
                .foregroundColor(Color.AG.primaryText)
            }

            Text("A continuación realizarás un test de conocimientos iniciales antes de comenzar.")
                .font(.AG.caption)
                .foregroundColor(Color.AG.secondaryText)
                .multilineTextAlignment(.center)
        }
    }

    // MARK: - Actions

    private func advanceStep() {
        switch step {
        case .welcome: step = .participantCode
        case .participantCode: step = .avatarSelection
        case .avatarSelection: step = .levelSelection
        case .levelSelection: step = .groupSelection
        case .groupSelection: step = .ready
        case .ready: break
        }
    }

    private func completeOnboarding() {
        let participant = Participant(
            id: participantId.trimmingCharacters(in: .whitespaces),
            avatar: selectedAvatar,
            algebraLevel: algebraLevel,
            groupType: groupType
        )
        appState.completeOnboarding(participant: participant)
        appState.showPreTest = true
    }

    private func levelSubtitle(_ level: AlgebraLevel) -> String {
        switch level {
        case .basico: return "Poca o ninguna experiencia con álgebra"
        case .intermedio: return "Conozco conceptos básicos de ecuaciones"
        case .avanzado: return "Me siento cómodo resolviendo problemas algebraicos"
        }
    }
}

func avatarIcon(_ index: Int) -> String {
    switch index {
    case 1: return "brain.head.profile"
    case 2: return "graduationcap.fill"
    case 3: return "atom"
    case 4: return "lightbulb.fill"
    case 5: return "star.fill"
    case 6: return "bolt.fill"
    default: return "person.fill"
    }
}
