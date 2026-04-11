import SwiftUI

struct RetentionTestScreen: View {
    @Environment(AppState.self) private var appState

    let form: String
    let onComplete: () -> Void

    @State private var currentIndex: Int = 0
    @State private var selectedOption: Int? = nil
    @State private var responses: [TestItemResponse] = []
    @State private var itemStartTime: Date = Date()
    @State private var testStartTime: Date = Date()
    @State private var isFinished: Bool = false

    private var items: [TestItem] {
        RetentionTestData.items(for: form)
    }

    private var totalScore: Int {
        responses.filter(\.isCorrect).count
    }

    var body: some View {
        VStack(spacing: 0) {
            if isFinished {
                completionView
            } else {
                questionView
            }
        }
        .background(Color.AG.background)
        .onAppear {
            testStartTime = Date()
            itemStartTime = Date()
        }
    }

    // MARK: - Question View

    private var questionView: some View {
        VStack(spacing: Spacing.lg) {
            // Header with progress
            VStack(spacing: Spacing.sm) {
                HStack {
                    Text("Pregunta \(currentIndex + 1) de \(items.count)")
                        .font(.AG.caption)
                        .foregroundColor(Color.AG.secondaryText)
                    Spacer()
                    Text("Forma \(form)")
                        .font(.AG.caption)
                        .foregroundColor(Color.AG.secondaryText)
                }

                ProgressBarView(
                    progress: Double(currentIndex + 1) / Double(items.count)
                )
            }
            .padding(.horizontal, Spacing.screenHorizontal)
            .padding(.top, Spacing.lg)

            ScrollView {
                VStack(spacing: Spacing.lg) {
                    // Question
                    CardView {
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            Text("\(currentIndex + 1). \(items[currentIndex].question)")
                                .font(.AG.subtitle)
                                .foregroundColor(Color.AG.primaryText)
                                .fixedSize(horizontal: false, vertical: true)

                            Text(items[currentIndex].category)
                                .font(.AG.caption)
                                .foregroundColor(Color.AG.secondaryText)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    // Options
                    ForEach(0..<items[currentIndex].options.count, id: \.self) { optionIndex in
                        optionButton(index: optionIndex)
                    }

                    // Next button
                    PrimaryButton(
                        title: currentIndex < items.count - 1 ? "Siguiente" : "Finalizar",
                        isEnabled: selectedOption != nil
                    ) {
                        recordResponse()
                    }
                    .padding(.bottom, Spacing.xxl)
                }
                .padding(.horizontal, Spacing.screenHorizontal)
                .padding(.top, Spacing.sm)
            }
        }
    }

    // MARK: - Option Button

    private func optionButton(index: Int) -> some View {
        Button {
            selectedOption = index
        } label: {
            HStack(spacing: Spacing.sm) {
                Circle()
                    .strokeBorder(
                        selectedOption == index ? Color.AG.accent : Color.AG.secondaryText.opacity(0.4),
                        lineWidth: selectedOption == index ? 3 : 1.5
                    )
                    .background(
                        Circle()
                            .fill(selectedOption == index ? Color.AG.accent.opacity(0.15) : Color.clear)
                    )
                    .frame(width: 24, height: 24)

                Text(items[currentIndex].options[index])
                    .font(.AG.body)
                    .foregroundColor(Color.AG.primaryText)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer()
            }
            .padding(Spacing.md)
            .background(
                RoundedRectangle(cornerRadius: Spacing.cardCornerRadius)
                    .fill(selectedOption == index ? Color.AG.lightAccent : Color.AG.cardBackground)
            )
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.cardCornerRadius)
                    .stroke(
                        selectedOption == index ? Color.AG.accent : Color.AG.secondaryText.opacity(0.2),
                        lineWidth: selectedOption == index ? 2 : 1
                    )
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(items[currentIndex].options[index])
    }

    // MARK: - Completion View

    private var completionView: some View {
        VStack(spacing: Spacing.xl) {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(Color.AG.success)

            Text("Test completado")
                .font(.AG.largeTitle)
                .foregroundColor(Color.AG.primaryText)

            Text("Gracias por tu participación.")
                .font(.AG.body)
                .foregroundColor(Color.AG.secondaryText)

            CardView {
                VStack(spacing: Spacing.sm) {
                    Text("Tu puntuación")
                        .font(.AG.caption)
                        .foregroundColor(Color.AG.secondaryText)

                    Text("\(totalScore) / \(items.count)")
                        .font(.AG.largeTitle)
                        .foregroundColor(Color.AG.accent)

                    ProgressBarView(
                        progress: Double(totalScore) / Double(items.count),
                        height: 10,
                        foregroundColor: Color.AG.success
                    )
                    .padding(.top, Spacing.xs)

                    Text("\(Int(Double(totalScore) / Double(items.count) * 100))% de respuestas correctas")
                        .font(.AG.caption)
                        .foregroundColor(Color.AG.secondaryText)
                }
            }
            .padding(.horizontal, Spacing.screenHorizontal)

            Spacer()

            PrimaryButton(title: "Continuar") {
                onComplete()
            }
            .padding(.horizontal, Spacing.screenHorizontal)
            .padding(.bottom, Spacing.xxl)
        }
    }

    // MARK: - Logic

    private func recordResponse() {
        guard let selected = selectedOption else { return }
        let currentItem = items[currentIndex]
        let now = Date()
        let timeSpent = now.timeIntervalSince(itemStartTime) * 1000 // ms

        let response = TestItemResponse(
            itemIndex: currentItem.index,
            selectedOption: selected,
            isCorrect: selected == currentItem.correctIndex,
            timeSpentMs: timeSpent,
            timestamp: now
        )
        responses.append(response)

        if currentIndex < items.count - 1 {
            currentIndex += 1
            selectedOption = nil
            itemStartTime = Date()
        } else {
            saveTest()
            isFinished = true
        }
    }

    private func saveTest() {
        guard var participant = appState.participant else { return }

        let test = RetentionTest(
            form: form,
            startTimestamp: testStartTime,
            endTimestamp: Date(),
            responses: responses,
            totalScore: totalScore
        )
        participant.retentionTests.append(test)
        appState.participant = participant
    }
}

#Preview {
    RetentionTestScreen(form: "A") {
        print("Test completed")
    }
    .environment(AppState.shared)
}
