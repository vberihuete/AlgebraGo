import SwiftUI

struct ModuleDetailScreen: View {
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    let module: ModuleContent

    @State private var phase: ModulePhase = .explanation
    @State private var currentExplanationIndex = 0
    @State private var currentExampleStep = 0
    @State private var quizAnswers: [Int?] = []
    @State private var currentQuizIndex = 0
    @State private var showFeedback = false
    @State private var isCorrect = false
    @State private var attemptNumber = 1
    @State private var waitingForRetry = false
    @State private var quizScore = 0
    @State private var moduleStartTime = Date()
    @State private var showCognitiveLoad = false
    @State private var showSummary = false
    @State private var bonusAwarded = false
    @State private var showConfetti = false
    @State private var shakeWrong = false

    enum ModulePhase {
        case explanation
        case example
        case quiz
    }

    var body: some View {
        ZStack {
            Color.AG.background.ignoresSafeArea()

            VStack(spacing: 0) {
                // Phase indicator
                HStack(spacing: Spacing.xs) {
                    PhaseTab(title: "Teoría", isActive: phase == .explanation)
                    PhaseTab(title: "Ejemplo", isActive: phase == .example)
                    PhaseTab(title: "Quiz", isActive: phase == .quiz)
                }
                .padding(.horizontal, Spacing.screenHorizontal)
                .padding(.vertical, Spacing.sm)

                ScrollView {
                    VStack(spacing: Spacing.lg) {
                        switch phase {
                        case .explanation:
                            explanationView
                        case .example:
                            exampleView
                        case .quiz:
                            quizView
                        }
                    }
                    .padding(.horizontal, Spacing.screenHorizontal)
                    .padding(.bottom, 100)
                }

                Spacer()

                bottomButton
                    .padding(.horizontal, Spacing.screenHorizontal)
                    .padding(.bottom, Spacing.lg)
            }

            if showConfetti {
                ConfettiView()
                    .ignoresSafeArea()
            }
        }
        .navigationTitle("Módulo \(module.unitNumber).\(module.moduleNumber)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            moduleStartTime = Date()
            quizAnswers = Array(repeating: nil, count: module.quizQuestions.count)
            markModuleStarted()
        }
        .sheet(isPresented: $showCognitiveLoad) {
            CognitiveLoadScreen(moduleId: module.id) {
                showCognitiveLoad = false
                showSummary = true
            }
        }
        .sheet(isPresented: $showSummary) {
            ModuleSummaryView(
                module: module,
                score: Double(quizScore) / Double(module.quizQuestions.count),
                timeSpent: Int(Date().timeIntervalSince(moduleStartTime)),
                pointsEarned: calculatePoints(),
                bonusAwarded: bonusAwarded,
                onDismiss: {
                    showSummary = false
                    dismiss()
                }
            )
        }
    }

    // MARK: - Explanation View
    private var explanationView: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text(module.title)
                .font(.AG.title)
                .foregroundColor(Color.AG.primaryText)

            if currentExplanationIndex < module.explanation.count {
                let step = module.explanation[currentExplanationIndex]

                CardView {
                    VStack(alignment: .leading, spacing: Spacing.sm) {
                        Text(step.text)
                            .font(.AG.body)
                            .foregroundColor(Color.AG.primaryText)
                            .fixedSize(horizontal: false, vertical: true)

                        if let formula = step.formula {
                            MathText(text: formula, font: .AG.formulaLarge)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, Spacing.sm)
                                .background(Color.AG.lightAccent)
                                .cornerRadius(Spacing.xs)
                        }
                    }
                }

                // Page indicator
                HStack {
                    Text("\(currentExplanationIndex + 1) de \(module.explanation.count)")
                        .font(.AG.caption)
                        .foregroundColor(Color.AG.secondaryText)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }

    // MARK: - Example View
    private var exampleView: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text(module.example.title)
                .font(.AG.subtitle)
                .foregroundColor(Color.AG.primaryText)

            ForEach(0...min(currentExampleStep, module.example.steps.count - 1), id: \.self) { index in
                let step = module.example.steps[index]
                CardView {
                    VStack(alignment: .leading, spacing: Spacing.sm) {
                        HStack {
                            Text("Paso \(step.stepNumber)")
                                .font(.AG.bodyBold)
                                .foregroundColor(Color.AG.accent)
                            Spacer()
                        }
                        Text(step.description)
                            .font(.AG.body)
                            .foregroundColor(Color.AG.primaryText)

                        if let formula = step.formula {
                            MathText(text: formula, font: .AG.formulaLarge)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, Spacing.xs)
                        }
                    }
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: currentExampleStep)
    }

    // MARK: - Quiz View
    private var quizView: some View {
        VStack(spacing: Spacing.md) {
            if currentQuizIndex < module.quizQuestions.count {
                let question = module.quizQuestions[currentQuizIndex]

                Text("Pregunta \(currentQuizIndex + 1) de \(module.quizQuestions.count)")
                    .font(.AG.caption)
                    .foregroundColor(Color.AG.secondaryText)

                CardView {
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        Text(question.question)
                            .font(.AG.bodyBold)
                            .foregroundColor(Color.AG.primaryText)
                            .fixedSize(horizontal: false, vertical: true)

                        ForEach(0..<question.options.count, id: \.self) { optionIndex in
                            QuizOptionButton(
                                text: question.options[optionIndex],
                                isSelected: quizAnswers[currentQuizIndex] == optionIndex,
                                isCorrect: showFeedback && optionIndex == question.correctIndex,
                                isWrong: showFeedback && quizAnswers[currentQuizIndex] == optionIndex && optionIndex != question.correctIndex,
                                action: {
                                    if !showFeedback {
                                        selectAnswer(optionIndex)
                                    }
                                }
                            )
                        }

                        if showFeedback && !isCorrect {
                            HStack(spacing: Spacing.xs) {
                                Image(systemName: "info.circle.fill")
                                    .foregroundColor(Color.AG.error)
                                Text(attemptNumber == 1 ? question.explanationOnWrong : question.explanationOnWrongRetry)
                                    .font(.AG.caption)
                                    .foregroundColor(Color.AG.error)
                            }
                            .padding(Spacing.sm)
                            .background(Color.AG.error.opacity(0.1))
                            .cornerRadius(Spacing.xs)
                        }

                        if showFeedback && isCorrect {
                            HStack(spacing: Spacing.xs) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color.AG.success)
                                Text("¡Correcto!")
                                    .font(.AG.bodyBold)
                                    .foregroundColor(Color.AG.success)
                            }
                            .padding(Spacing.sm)
                            .background(Color.AG.success.opacity(0.1))
                            .cornerRadius(Spacing.xs)
                        }
                    }
                }
                .modifier(ShakeEffect(animatableData: shakeWrong ? 1 : 0))
            }
        }
    }

    // MARK: - Bottom Button
    private var bottomButton: some View {
        Group {
            switch phase {
            case .explanation:
                if currentExplanationIndex < module.explanation.count - 1 {
                    PrimaryButton(title: "Siguiente") {
                        withAnimation { currentExplanationIndex += 1 }
                    }
                } else {
                    PrimaryButton(title: "Ver Ejemplo") {
                        withAnimation { phase = .example }
                    }
                }
            case .example:
                if currentExampleStep < module.example.steps.count - 1 {
                    PrimaryButton(title: "Siguiente Paso") {
                        withAnimation { currentExampleStep += 1 }
                    }
                } else {
                    PrimaryButton(title: "Iniciar Quiz") {
                        withAnimation { phase = .quiz }
                    }
                }
            case .quiz:
                if showFeedback && isCorrect {
                    // Correct answer — advance or finish
                    if currentQuizIndex < module.quizQuestions.count - 1 {
                        PrimaryButton(title: "Siguiente Pregunta") {
                            advanceQuiz()
                        }
                    } else {
                        PrimaryButton(title: "Finalizar") {
                            finishModule()
                        }
                    }
                } else if showFeedback && !isCorrect && attemptNumber < 2 {
                    // Wrong on first attempt — offer retry
                    PrimaryButton(title: "Reintentar") {
                        attemptNumber = 2
                        showFeedback = false
                        isCorrect = false
                        waitingForRetry = false
                        quizAnswers[currentQuizIndex] = nil
                    }
                } else if showFeedback && !isCorrect && attemptNumber >= 2 {
                    // Wrong on second attempt — move on
                    if currentQuizIndex < module.quizQuestions.count - 1 {
                        PrimaryButton(title: "Siguiente Pregunta") {
                            advanceQuiz()
                        }
                    } else {
                        PrimaryButton(title: "Finalizar") {
                            finishModule()
                        }
                    }
                } else {
                    // No feedback yet — confirm answer
                    PrimaryButton(title: "Confirmar", isEnabled: quizAnswers[currentQuizIndex] != nil) {
                        checkAnswer()
                    }
                }
            }
        }
    }

    // MARK: - Actions

    private func selectAnswer(_ index: Int) {
        quizAnswers[currentQuizIndex] = index
    }

    private func checkAnswer() {
        guard let selected = quizAnswers[currentQuizIndex] else { return }
        let question = module.quizQuestions[currentQuizIndex]
        isCorrect = selected == question.correctIndex

        if isCorrect {
            quizScore += 1
        } else {
            withAnimation {
                shakeWrong = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                shakeWrong = false
            }
        }
        showFeedback = true
    }

    private func advanceQuiz() {
        currentQuizIndex += 1
        showFeedback = false
        isCorrect = false
        attemptNumber = 1
        waitingForRetry = false
    }

    private func markModuleStarted() {
        guard var participant = appState.participant else { return }
        if !participant.moduleProgress.contains(where: { $0.moduleId == module.id }) {
            var progress = ModuleProgress(moduleId: module.id)
            progress.status = .inProgress
            progress.startDate = Date()
            participant.moduleProgress.append(progress)
            appState.participant = participant
        }
    }

    private func finishModule() {
        guard var participant = appState.participant else { return }
        let timeSpent = Int(Date().timeIntervalSince(moduleStartTime))

        if let index = participant.moduleProgress.firstIndex(where: { $0.moduleId == module.id }) {
            participant.moduleProgress[index].status = .completed
            participant.moduleProgress[index].completionDate = Date()
            participant.moduleProgress[index].timeSpentSeconds += timeSpent

            let attempt = QuizAttempt(
                attemptNumber: 1,
                answers: quizAnswers.map { $0 ?? -1 },
                correctAnswers: module.quizQuestions.map { $0.correctIndex },
                score: Double(quizScore) / Double(module.quizQuestions.count),
                timestamp: Date()
            )
            participant.moduleProgress[index].quizAttempts.append(attempt)
        }

        // Award points
        let points = calculatePoints()
        participant.points += points
        participant.level = UserLevel.calculate(points: participant.points)

        // Check badges
        awardBadges(participant: &participant)

        appState.participant = participant
        showCognitiveLoad = true
    }

    private func calculatePoints() -> Int {
        var points = 10 // Module completion
        let score = Double(quizScore) / Double(module.quizQuestions.count)
        if score == 1.0 {
            points += 5
            // 20% chance of bonus
            if Double.random(in: 0...1) < 0.2 {
                points += 5
                bonusAwarded = true
            }
        }
        return points
    }

    private func awardBadges(participant: inout Participant) {
        // Module badge
        let badgeId = "m\(module.unitNumber)_\(module.moduleNumber)"
        if var badge = Badge.allBadges.first(where: { $0.id == badgeId }) {
            badge.isUnlocked = true
            badge.unlockedDate = Date()
            if let existingIndex = participant.badges.firstIndex(where: { $0.id == badgeId }) {
                participant.badges[existingIndex] = badge
            } else {
                participant.badges.append(badge)
            }
        }

        // Unit completion badge
        let unitModuleIds = ModuleContentData.allModules
            .filter { $0.unitNumber == module.unitNumber }
            .map { $0.id }
        let completedInUnit = unitModuleIds.filter { id in
            participant.moduleProgress.first(where: { $0.moduleId == id })?.status == .completed
        }
        if completedInUnit.count == unitModuleIds.count {
            let unitBadgeId = "unit_\(module.unitNumber)"
            if var badge = Badge.allBadges.first(where: { $0.id == unitBadgeId }) {
                badge.isUnlocked = true
                badge.unlockedDate = Date()
                if !participant.badges.contains(where: { $0.id == unitBadgeId }) {
                    participant.badges.append(badge)
                }
            }
        }

        // Streak badge
        if participant.currentStreak() >= 3 {
            if var badge = Badge.allBadges.first(where: { $0.id == "streak_3" }) {
                badge.isUnlocked = true
                badge.unlockedDate = Date()
                if !participant.badges.contains(where: { $0.id == "streak_3" }) {
                    participant.badges.append(badge)
                }
            }
        }

        // Perfect quiz badge
        let score = Double(quizScore) / Double(module.quizQuestions.count)
        if score == 1.0 {
            if var badge = Badge.allBadges.first(where: { $0.id == "perfect_first" }) {
                badge.isUnlocked = true
                badge.unlockedDate = Date()
                if !participant.badges.contains(where: { $0.id == "perfect_first" }) {
                    participant.badges.append(badge)
                }
            }
        }

        // Active day points
        participant.points += 2
        participant.recordActiveDay()
    }
}

// MARK: - Quiz Option Button

struct QuizOptionButton: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let isWrong: Bool
    let action: () -> Void

    private var backgroundColor: Color {
        if isCorrect { return Color.AG.success.opacity(0.15) }
        if isWrong { return Color.AG.error.opacity(0.15) }
        if isSelected { return Color.AG.lightAccent }
        return Color.AG.cardBackground
    }

    private var borderColor: Color {
        if isCorrect { return Color.AG.success }
        if isWrong { return Color.AG.error }
        if isSelected { return Color.AG.accent }
        return Color.AG.progressBarBackground
    }

    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .font(.AG.body)
                    .foregroundColor(Color.AG.primaryText)
                    .multilineTextAlignment(.leading)
                Spacer()
                if isCorrect {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color.AG.success)
                } else if isWrong {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.AG.error)
                }
            }
            .padding(Spacing.sm)
            .background(backgroundColor)
            .cornerRadius(Spacing.xs)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.xs)
                    .stroke(borderColor, lineWidth: 1.5)
            )
        }
        .accessibilityLabel(text)
    }
}

// MARK: - Phase Tab

struct PhaseTab: View {
    let title: String
    let isActive: Bool

    var body: some View {
        Text(title)
            .font(.AG.caption)
            .fontWeight(isActive ? .semibold : .regular)
            .foregroundColor(isActive ? Color.AG.accent : Color.AG.secondaryText)
            .padding(.vertical, Spacing.xs)
            .frame(maxWidth: .infinity)
            .background(isActive ? Color.AG.lightAccent : Color.clear)
            .cornerRadius(Spacing.xs)
    }
}

// MARK: - Shake Effect

struct ShakeEffect: GeometryEffect {
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        let translation = sin(animatableData * .pi * 4) * 10
        return ProjectionTransform(CGAffineTransform(translationX: translation, y: 0))
    }
}
