import SwiftUI

struct ProgressScreen: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        NavigationStack {
            ScrollView {
                if let participant = appState.participant {
                    progressContent(participant: participant)
                } else {
                    Text("Sin datos")
                        .font(.AG.body)
                        .foregroundColor(Color.AG.secondaryText)
                        .padding(.top, Spacing.xxl)
                }
            }
            .background(Color.AG.background)
            .navigationTitle("Progreso")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    @ViewBuilder
    private func progressContent(participant: Participant) -> some View {
        VStack(spacing: Spacing.lg) {
            // Overall stats
            CardView {
                VStack(spacing: Spacing.md) {
                    Text("Resumen de Progreso")
                        .font(.AG.subtitle)
                        .foregroundColor(Color.AG.primaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    HStack(spacing: Spacing.lg) {
                        StatBox(title: "Módulos", value: "\(participant.completedModuleCount)/12", icon: "book.fill")
                        StatBox(title: "Puntos", value: "\(participant.points)", icon: "star.fill")
                        StatBox(title: "Racha", value: "\(participant.currentStreak())d", icon: "flame.fill")
                    }
                }
            }
            .padding(.horizontal, Spacing.screenHorizontal)

            // Unit progress
            ForEach(1...3, id: \.self) { unit in
                unitProgressCard(unit: unit, participant: participant)
            }

            // Quiz performance
            quizPerformanceCard(participant: participant)
        }
        .padding(.bottom, Spacing.xxl)
    }

    @ViewBuilder
    private func unitProgressCard(unit: Int, participant: Participant) -> some View {
        let unitModules = ModuleContentData.allModules.filter { $0.unitNumber == unit }
        let completedInUnit = unitModules.filter { mod in
            participant.moduleProgress.first(where: { $0.moduleId == mod.id })?.status == .completed
        }.count

        CardView {
            VStack(alignment: .leading, spacing: Spacing.sm) {
                HStack {
                    Text("Unidad \(unit)")
                        .font(.AG.bodyBold)
                        .foregroundColor(Color.AG.primaryText)
                    Spacer()
                    Text("\(completedInUnit)/\(unitModules.count)")
                        .font(.AG.caption)
                        .foregroundColor(Color.AG.secondaryText)
                }

                ProgressBarView(
                    progress: Double(completedInUnit) / Double(unitModules.count),
                    height: 8
                )

                ForEach(unitModules) { mod in
                    let prog = participant.moduleProgress.first(where: { $0.moduleId == mod.id })
                    HStack(spacing: Spacing.sm) {
                        Image(systemName: prog?.status == .completed ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(prog?.status == .completed ? Color.AG.success : Color.AG.secondaryText)
                            .font(.caption)
                        Text(mod.title)
                            .font(.AG.caption)
                            .foregroundColor(Color.AG.primaryText)
                            .lineLimit(1)
                        Spacer()
                        if let attempt = prog?.quizAttempts.first {
                            Text("\(Int(attempt.score * 100))%")
                                .font(.AG.caption)
                                .foregroundColor(Color.AG.accent)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, Spacing.screenHorizontal)
    }

    @ViewBuilder
    private func quizPerformanceCard(participant: Participant) -> some View {
        let allAttempts = participant.moduleProgress.flatMap { $0.quizAttempts }
        if !allAttempts.isEmpty {
            let firstAttempts = allAttempts.filter { $0.attemptNumber == 1 }
            let avgScore = firstAttempts.map(\.score).reduce(0, +) / Double(max(firstAttempts.count, 1))

            CardView {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text("Rendimiento en Quizzes")
                        .font(.AG.subtitle)
                        .foregroundColor(Color.AG.primaryText)

                    HStack(spacing: Spacing.lg) {
                        StatBox(title: "Promedio", value: "\(Int(avgScore * 100))%", icon: "chart.bar")
                        StatBox(title: "Quizzes", value: "\(firstAttempts.count)", icon: "checkmark.square")
                        StatBox(title: "Perfectos", value: "\(firstAttempts.filter { $0.score == 1.0 }.count)", icon: "sparkles")
                    }
                }
            }
            .padding(.horizontal, Spacing.screenHorizontal)
        }
    }
}

struct StatBox: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        VStack(spacing: Spacing.xxs) {
            Image(systemName: icon)
                .foregroundColor(Color.AG.accent)
                .font(.title3)
            Text(value)
                .font(.AG.bodyBold)
                .foregroundColor(Color.AG.primaryText)
            Text(title)
                .font(.AG.caption)
                .foregroundColor(Color.AG.secondaryText)
        }
        .frame(maxWidth: .infinity)
    }
}
