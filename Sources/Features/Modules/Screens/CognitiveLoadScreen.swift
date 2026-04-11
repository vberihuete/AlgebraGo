import SwiftUI

struct CognitiveLoadScreen: View {
    @Environment(AppState.self) private var appState
    let moduleId: String
    let onComplete: () -> Void

    @State private var responses: [Int] = Array(repeating: 5, count: 9)

    private let items = [
        "El tema de esta actividad fue muy complejo para mí.",
        "La explicación fue muy compleja para mí.",
        "Esta actividad requirió mucho esfuerzo mental relacionado con el tema.",
        "La explicación fue muy poco clara para mí.",
        "La explicación fue muy confusa para mí.",
        "Esta actividad requirió esfuerzo mental por su poca claridad.",
        "Esta actividad contribuyó mucho a mi comprensión del tema.",
        "Esta actividad contribuyó a mi conocimiento del tema.",
        "Esta actividad requirió esfuerzo mental para entender bien el tema."
    ]

    private let categories = [
        "Intrínseca", "Intrínseca", "Intrínseca",
        "Extrínseca", "Extrínseca", "Extrínseca",
        "Germane", "Germane", "Germane"
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Spacing.lg) {
                    Text("Evaluación de Carga Cognitiva")
                        .font(.AG.title)
                        .foregroundColor(Color.AG.primaryText)
                        .multilineTextAlignment(.center)

                    Text("Indica qué tan de acuerdo estás con cada afirmación (1 = Nada, 9 = Totalmente)")
                        .font(.AG.body)
                        .foregroundColor(Color.AG.secondaryText)
                        .multilineTextAlignment(.center)

                    ForEach(0..<9) { index in
                        CardView {
                            VStack(alignment: .leading, spacing: Spacing.sm) {
                                Text("\(index + 1). \(items[index])")
                                    .font(.AG.body)
                                    .foregroundColor(Color.AG.primaryText)
                                    .fixedSize(horizontal: false, vertical: true)

                                Text(categories[index])
                                    .font(.AG.caption)
                                    .foregroundColor(Color.AG.secondaryText)

                                HStack {
                                    Text("1")
                                        .font(.AG.caption)
                                        .foregroundColor(Color.AG.secondaryText)

                                    Slider(
                                        value: Binding(
                                            get: { Double(responses[index]) },
                                            set: { responses[index] = Int($0.rounded()) }
                                        ),
                                        in: 1...9,
                                        step: 1
                                    )
                                    .tint(Color.AG.accent)

                                    Text("9")
                                        .font(.AG.caption)
                                        .foregroundColor(Color.AG.secondaryText)
                                }

                                Text("Valor: \(responses[index])")
                                    .font(.AG.caption)
                                    .foregroundColor(Color.AG.accent)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                    }

                    PrimaryButton(title: "Continuar") {
                        saveResponses()
                        onComplete()
                    }
                    .padding(.bottom, Spacing.xxl)
                }
                .padding(.horizontal, Spacing.screenHorizontal)
                .padding(.top, Spacing.lg)
            }
            .background(Color.AG.background)
        }
    }

    private func saveResponses() {
        guard var participant = appState.participant else { return }
        let response = CognitiveLoadResponse(
            moduleId: moduleId,
            responses: responses,
            timestamp: Date()
        )
        participant.cognitiveLoadResponses.append(response)

        // Also save to module progress
        if let index = participant.moduleProgress.firstIndex(where: { $0.moduleId == moduleId }) {
            participant.moduleProgress[index].cognitiveLoadScore = response
        }

        appState.participant = participant
    }
}
