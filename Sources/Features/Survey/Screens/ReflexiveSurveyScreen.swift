import SwiftUI

struct ReflexiveSurveyScreen: View {
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    let isExperimental: Bool
    let onComplete: () -> Void

    @State private var likertResponses: [Int] = Array(repeating: 3, count: 10)
    @State private var openResponse1 = ""
    @State private var openResponse2 = ""
    @State private var currentPage = 0

    private var surveyItems: [SurveyItem] {
        var items: [SurveyItem] = [
            SurveyItem(index: 0, text: "Los contenidos de álgebra presentados fueron claros y comprensibles.", type: .likert, experimentalOnly: false),
            SurveyItem(index: 1, text: "La estructura de las actividades me ayudó a aprender mejor.", type: .likert, experimentalOnly: false),
            SurveyItem(index: 2, text: "Me sentí motivado/a a completar las actividades.", type: .likert, experimentalOnly: false),
            SurveyItem(index: 3, text: "El nivel de dificultad fue apropiado para mi conocimiento previo.", type: .likert, experimentalOnly: false),
            SurveyItem(index: 4, text: "Las explicaciones paso a paso me ayudaron a entender los conceptos.", type: .likert, experimentalOnly: false),
            SurveyItem(index: 5, text: "Los ejercicios prácticos reforzaron lo aprendido en la teoría.", type: .likert, experimentalOnly: false),
            SurveyItem(index: 6, text: "Siento que mi comprensión del álgebra mejoró durante el estudio.", type: .likert, experimentalOnly: false),
            SurveyItem(index: 7, text: "Recomendaría esta forma de estudiar álgebra a otros estudiantes.", type: .likert, experimentalOnly: false),
            SurveyItem(index: 8, text: "Los elementos de gamificación (puntos, insignias, niveles) aumentaron mi motivación.", type: .likert, experimentalOnly: true),
            SurveyItem(index: 9, text: "El sistema de retroalimentación inmediata en los quizzes me ayudó a corregir errores.", type: .likert, experimentalOnly: true),
            SurveyItem(index: 10, text: "¿Qué fue lo que más te gustó de la experiencia de aprendizaje?", type: .openText, experimentalOnly: false),
            SurveyItem(index: 11, text: "¿Qué cambiarías o mejorarías de la experiencia?", type: .openText, experimentalOnly: false),
        ]

        if !isExperimental {
            items = items.filter { !$0.experimentalOnly }
        }

        return items
    }

    private var filteredLikertItems: [SurveyItem] {
        surveyItems.filter { $0.type == .likert }
    }

    private var filteredOpenItems: [SurveyItem] {
        surveyItems.filter { $0.type == .openText }
    }

    private var totalPages: Int {
        filteredLikertItems.count + filteredOpenItems.count
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Progress
                ProgressBarView(
                    progress: Double(currentPage + 1) / Double(totalPages),
                    height: 4
                )

                ScrollView {
                    VStack(spacing: Spacing.lg) {
                        if currentPage == 0 {
                            // Introduction
                            VStack(spacing: Spacing.md) {
                                Image(systemName: "text.bubble")
                                    .font(.system(size: 50))
                                    .foregroundColor(Color.AG.accent)

                                Text("Encuesta Reflexiva")
                                    .font(.AG.title)
                                    .foregroundColor(Color.AG.primaryText)

                                Text("Tu opinión es muy importante para nuestra investigación. Por favor, responde con honestidad. No hay respuestas correctas o incorrectas.")
                                    .font(.AG.body)
                                    .foregroundColor(Color.AG.secondaryText)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.top, Spacing.xl)
                        }

                        if currentPage < filteredLikertItems.count {
                            let item = filteredLikertItems[currentPage]
                            likertItemView(item: item, index: item.index)
                        } else {
                            let openIndex = currentPage - filteredLikertItems.count
                            if openIndex < filteredOpenItems.count {
                                openTextItemView(item: filteredOpenItems[openIndex], index: openIndex)
                            }
                        }
                    }
                    .padding(.horizontal, Spacing.screenHorizontal)
                    .padding(.bottom, 100)
                }

                // Bottom navigation
                HStack(spacing: Spacing.md) {
                    if currentPage > 0 {
                        SecondaryButton(title: "Anterior") {
                            withAnimation { currentPage -= 1 }
                        }
                    }

                    if currentPage < totalPages - 1 {
                        PrimaryButton(title: "Siguiente") {
                            withAnimation { currentPage += 1 }
                        }
                    } else {
                        PrimaryButton(title: "Enviar") {
                            saveAndComplete()
                        }
                    }
                }
                .padding(.horizontal, Spacing.screenHorizontal)
                .padding(.bottom, Spacing.lg)
            }
            .background(Color.AG.background)
            .navigationTitle("Encuesta")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func likertItemView(item: SurveyItem, index: Int) -> some View {
        CardView {
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("\(currentPage + 1) de \(totalPages)")
                    .font(.AG.caption)
                    .foregroundColor(Color.AG.secondaryText)

                Text(item.text)
                    .font(.AG.body)
                    .foregroundColor(Color.AG.primaryText)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(spacing: Spacing.sm) {
                    let labels = [
                        "1 - Totalmente en desacuerdo",
                        "2 - En desacuerdo",
                        "3 - Neutral",
                        "4 - De acuerdo",
                        "5 - Totalmente de acuerdo"
                    ]

                    ForEach(1...5, id: \.self) { value in
                        Button {
                            if index < likertResponses.count {
                                likertResponses[index] = value
                            }
                        } label: {
                            HStack {
                                Image(systemName: (index < likertResponses.count && likertResponses[index] == value) ? "circle.fill" : "circle")
                                    .foregroundColor((index < likertResponses.count && likertResponses[index] == value) ? Color.AG.accent : Color.AG.secondaryText)
                                Text(labels[value - 1])
                                    .font(.AG.body)
                                    .foregroundColor(Color.AG.primaryText)
                                Spacer()
                            }
                            .padding(.vertical, Spacing.xxs)
                        }
                    }
                }
            }
        }
    }

    private func openTextItemView(item: SurveyItem, index: Int) -> some View {
        CardView {
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("\(currentPage + 1) de \(totalPages)")
                    .font(.AG.caption)
                    .foregroundColor(Color.AG.secondaryText)

                Text(item.text)
                    .font(.AG.body)
                    .foregroundColor(Color.AG.primaryText)
                    .fixedSize(horizontal: false, vertical: true)

                if index == 0 {
                    TextEditor(text: $openResponse1)
                        .frame(minHeight: 120)
                        .padding(Spacing.xs)
                        .overlay(
                            RoundedRectangle(cornerRadius: Spacing.xs)
                                .stroke(Color.AG.secondaryText.opacity(0.3), lineWidth: 1)
                        )
                } else {
                    TextEditor(text: $openResponse2)
                        .frame(minHeight: 120)
                        .padding(Spacing.xs)
                        .overlay(
                            RoundedRectangle(cornerRadius: Spacing.xs)
                                .stroke(Color.AG.secondaryText.opacity(0.3), lineWidth: 1)
                        )
                }
            }
        }
    }

    private func saveAndComplete() {
        guard var participant = appState.participant else { return }

        let response = ReflexiveResponse(
            likertResponses: Array(likertResponses.prefix(isExperimental ? 10 : 8)),
            openResponse1: openResponse1,
            openResponse2: openResponse2,
            timestamp: Date()
        )
        participant.reflexiveResponse = response
        appState.participant = participant

        onComplete()
        dismiss()
    }
}
