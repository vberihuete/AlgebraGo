import SwiftUI

struct SARTScreen: View {

    // MARK: - Parameters

    let version: String          // "A" or "B"
    let weekNumber: Int
    let sessionNumber: Int
    let onComplete: () -> Void

    // MARK: - Environment

    @Environment(AppState.self) private var appState

    // MARK: - State

    @State private var phase: Phase = .instructions
    @State private var currentDigit: Int? = nil
    @State private var digitVisible: Bool = false
    @State private var currentIndex: Int = 0
    @State private var stimulusOnsetDate: Date = .now
    @State private var respondedToCurrentStimulus: Bool = false

    @State private var practiceStimuli: [SARTStimulus] = []
    @State private var realStimuli: [SARTStimulus] = []
    @State private var session: SARTSession? = nil

    @State private var timer: Timer? = nil

    // MARK: - Constants

    private let stimulusDisplayTime: TimeInterval = 0.250  // 250ms
    private let interStimulusInterval: TimeInterval = 0.900 // 900ms

    // MARK: - Phase

    private enum Phase {
        case instructions
        case practice
        case practiceComplete
        case realTask
        case completed
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            switch phase {
            case .instructions:
                instructionsView
            case .practice:
                taskView
            case .practiceComplete:
                practiceCompleteView
            case .realTask:
                taskView
            case .completed:
                completedView
            }
        }
        .animation(.easeInOut(duration: 0.2), value: phase)
        .onDisappear {
            timer?.invalidate()
            timer = nil
        }
    }

    // MARK: - Instructions

    private var instructionsView: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: Spacing.xl) {
                Spacer()

                Image(systemName: "hand.tap.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.white.opacity(0.7))

                Text("Mini-SART")
                    .font(.AG.largeTitle)
                    .foregroundStyle(.white)

                VStack(spacing: Spacing.md) {
                    Text("Toca la pantalla cuando veas un número.")
                        .font(.AG.body)
                        .foregroundStyle(.white.opacity(0.9))
                        .multilineTextAlignment(.center)

                    Text("NO toques cuando veas el número 3.")
                        .font(.AG.subtitle)
                        .foregroundStyle(Color.AG.error)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, Spacing.screenHorizontal)

                VStack(spacing: Spacing.xs) {
                    Text("Los números aparecerán brevemente.")
                        .font(.AG.caption)
                        .foregroundStyle(.white.opacity(0.6))

                    Text("Primero harás una práctica de 10 estímulos.")
                        .font(.AG.caption)
                        .foregroundStyle(.white.opacity(0.6))
                }

                Spacer()

                PrimaryButton(title: "Comenzar práctica") {
                    startPractice()
                }
                .padding(.horizontal, Spacing.screenHorizontal)
                .padding(.bottom, Spacing.xxl)
            }
        }
    }

    // MARK: - Task View (shared by practice & real)

    private var taskView: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if digitVisible, let digit = currentDigit {
                Text("\(digit)")
                    .font(.AG.sartDigit)
                    .foregroundStyle(.white)
                    .monospacedDigit()
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            handleTap()
        }
    }

    // MARK: - Practice Complete

    private var practiceCompleteView: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: Spacing.xl) {
                Spacer()

                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 50))
                    .foregroundStyle(Color.AG.success)

                Text("La práctica ha terminado.")
                    .font(.AG.title)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)

                Text("La tarea real comenzará ahora.\nRecuerda: toca para todos los números excepto el 3.")
                    .font(.AG.body)
                    .foregroundStyle(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, Spacing.screenHorizontal)

                Spacer()

                PrimaryButton(title: "Comenzar tarea") {
                    startRealTask()
                }
                .padding(.horizontal, Spacing.screenHorizontal)
                .padding(.bottom, Spacing.xxl)
            }
        }
    }

    // MARK: - Completed

    private var completedView: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: Spacing.xl) {
                Spacer()

                Image(systemName: "star.fill")
                    .font(.system(size: 50))
                    .foregroundStyle(Color.AG.accent)

                Text("Tarea completada")
                    .font(.AG.largeTitle)
                    .foregroundStyle(.white)

                Text("Puedes continuar.")
                    .font(.AG.body)
                    .foregroundStyle(.white.opacity(0.8))

                Spacer()

                PrimaryButton(title: "Continuar") {
                    onComplete()
                }
                .padding(.horizontal, Spacing.screenHorizontal)
                .padding(.bottom, Spacing.xxl)
            }
        }
    }

    // MARK: - Practice Logic

    private func startPractice() {
        let digits = SARTData.practice
        practiceStimuli = digits.map { SARTStimulus(digit: $0) }
        currentIndex = 0
        phase = .practice
        presentNextStimulus(digits: digits)
    }

    // MARK: - Real Task Logic

    private func startRealTask() {
        let digits = SARTData.sequence(for: version)
        realStimuli = digits.map { SARTStimulus(digit: $0) }
        session = SARTSession(
            weekNumber: weekNumber,
            sessionNumberInWeek: sessionNumber,
            version: version
        )
        currentIndex = 0
        phase = .realTask
        presentNextStimulus(digits: digits)
    }

    // MARK: - Stimulus Presentation

    private func presentNextStimulus(digits: [Int]) {
        guard currentIndex < digits.count else {
            finishCurrentPhase()
            return
        }

        let digit = digits[currentIndex]
        currentDigit = digit
        digitVisible = true
        respondedToCurrentStimulus = false
        stimulusOnsetDate = Date()

        // Update timestamp on the stimulus
        if phase == .practice {
            practiceStimuli[currentIndex].timestamp = stimulusOnsetDate
        } else {
            realStimuli[currentIndex].timestamp = stimulusOnsetDate
        }

        // Hide digit after 250ms
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: stimulusDisplayTime, repeats: false) { _ in
            DispatchQueue.main.async {
                digitVisible = false
                // Wait ISI (900ms) then advance
                timer?.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: interStimulusInterval, repeats: false) { _ in
                    DispatchQueue.main.async {
                        currentIndex += 1
                        presentNextStimulus(digits: digits)
                    }
                }
                timer?.tolerance = 0.005
            }
        }
        timer?.tolerance = 0.005
    }

    // MARK: - Tap Handling

    private func handleTap() {
        guard !respondedToCurrentStimulus else { return }
        guard digitVisible || true else { return } // allow taps during ISI too

        respondedToCurrentStimulus = true
        let reactionTime = Date().timeIntervalSince(stimulusOnsetDate) * 1000.0 // ms

        if phase == .practice {
            guard currentIndex < practiceStimuli.count else { return }
            practiceStimuli[currentIndex].userResponded = true
            practiceStimuli[currentIndex].reactionTime = reactionTime
        } else if phase == .realTask {
            guard currentIndex < realStimuli.count else { return }
            realStimuli[currentIndex].userResponded = true
            realStimuli[currentIndex].reactionTime = reactionTime
        }
    }

    // MARK: - Phase Completion

    private func finishCurrentPhase() {
        timer?.invalidate()
        timer = nil
        currentDigit = nil
        digitVisible = false

        switch phase {
        case .practice:
            // Discard practice results, show transition
            phase = .practiceComplete

        case .realTask:
            guard var s = session else { return }
            s.endTimestamp = Date()
            s.stimuli = realStimuli
            s.calculateMetrics()
            session = s

            // Save to participant
            if var participant = appState.participant {
                participant.sartSessions.append(s)
                appState.participant = participant
            }

            phase = .completed

        default:
            break
        }
    }
}

// MARK: - Preview

#Preview {
    SARTScreen(
        version: "A",
        weekNumber: 1,
        sessionNumber: 1,
        onComplete: {}
    )
    .environment(AppState.shared)
}
