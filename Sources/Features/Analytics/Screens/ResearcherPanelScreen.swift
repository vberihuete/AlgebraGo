import SwiftUI

struct ResearcherPanelScreen: View {
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    @State private var pinCode = ""
    @State private var isAuthenticated = false
    @State private var showShareSheet = false
    @State private var exportURL: URL?
    @State private var showError = false
    @State private var errorMessage = ""

    private let correctPin = "2026"

    var body: some View {
        NavigationStack {
            if isAuthenticated {
                authenticatedView
            } else {
                pinEntryView
            }
        }
    }

    // MARK: - PIN Entry
    private var pinEntryView: some View {
        VStack(spacing: Spacing.xl) {
            Spacer()

            Image(systemName: "lock.shield.fill")
                .font(.system(size: 60))
                .foregroundColor(Color.AG.accent)

            Text("Panel del Investigador")
                .font(.AG.title)
                .foregroundColor(Color.AG.primaryText)

            Text("Ingresa el código PIN de acceso")
                .font(.AG.body)
                .foregroundColor(Color.AG.secondaryText)

            SecureField("PIN", text: $pinCode)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
                .font(.AG.subtitle)
                .multilineTextAlignment(.center)
                .frame(width: 150)

            PrimaryButton(title: "Acceder", isEnabled: pinCode.count >= 4) {
                if pinCode == correctPin {
                    withAnimation { isAuthenticated = true }
                } else {
                    showError = true
                    errorMessage = String(localized: "PIN incorrecto")
                    pinCode = ""
                }
            }
            .frame(width: 200)

            Spacer()
        }
        .padding(.horizontal, Spacing.screenHorizontal)
        .background(Color.AG.background)
        .navigationTitle("Acceso Restringido")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cerrar") { dismiss() }
            }
        }
        .alert("Error", isPresented: $showError) {
            Button("OK") {}
        } message: {
            Text(errorMessage)
        }
    }

    // MARK: - Authenticated View
    private var authenticatedView: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                if let participant = appState.participant {
                    // Participant info
                    CardView {
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            Text("Participante: \(participant.id)")
                                .font(.AG.subtitle)
                                .foregroundColor(Color.AG.primaryText)
                            Text("Grupo: \(participant.groupType.rawValue)")
                            Text("Nivel autodeclarado: \(participant.algebraLevel.displayName)")
                            Text("Fecha inicio: \(participant.startDate.formatted(date: .abbreviated, time: .omitted))")
                            Text("Semana actual: \(participant.currentWeekNumber())")
                            Text("Puntos: \(participant.points)")
                            Text("Nivel: \(UserLevel.name(for: participant.level))")
                        }
                        .font(.AG.body)
                        .foregroundColor(Color.AG.primaryText)
                    }

                    // Module Progress Summary
                    CardView {
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            Text("Progreso de Módulos")
                                .font(.AG.subtitle)
                                .foregroundColor(Color.AG.primaryText)

                            Text("Completados: \(participant.completedModuleCount)/12")
                            Text("Progreso: \(Int(participant.overallProgress * 100))%")

                            ForEach(participant.moduleProgress) { progress in
                                HStack {
                                    Text(progress.moduleId)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Text(progress.status.rawValue)
                                        .foregroundColor(progress.status == .completed ? Color.AG.success : Color.AG.secondaryText)
                                    if let attempt = progress.quizAttempts.first {
                                        Text("\(Int(attempt.score * 100))%")
                                            .foregroundColor(Color.AG.accent)
                                    }
                                }
                                .font(.AG.caption)
                            }
                        }
                        .font(.AG.body)
                        .foregroundColor(Color.AG.primaryText)
                    }

                    // SART Sessions
                    if !participant.sartSessions.isEmpty {
                        CardView {
                            VStack(alignment: .leading, spacing: Spacing.sm) {
                                Text("Sesiones Mini-SART")
                                    .font(.AG.subtitle)
                                    .foregroundColor(Color.AG.primaryText)

                                ForEach(participant.sartSessions) { session in
                                    VStack(alignment: .leading, spacing: Spacing.xxs) {
                                        Text("Semana \(session.weekNumber) - Sesión \(session.sessionNumberInWeek) (v\(session.version))")
                                            .fontWeight(.semibold)
                                        Text("Errores comisión: \(session.commissionErrors)")
                                        Text("Errores omisión: \(session.omissionErrors)")
                                        Text("RT medio: \(String(format: "%.1f", session.meanRT)) ms")
                                        Text("RT DE: \(String(format: "%.1f", session.sdRT)) ms")
                                    }
                                    .font(.AG.caption)
                                    Divider()
                                }
                            }
                        }
                    }

                    // Cognitive Load
                    if !participant.cognitiveLoadResponses.isEmpty {
                        CardView {
                            VStack(alignment: .leading, spacing: Spacing.sm) {
                                Text("Carga Cognitiva (Leppink)")
                                    .font(.AG.subtitle)
                                    .foregroundColor(Color.AG.primaryText)

                                ForEach(participant.cognitiveLoadResponses) { response in
                                    VStack(alignment: .leading, spacing: Spacing.xxs) {
                                        Text("Módulo: \(response.moduleId)")
                                            .fontWeight(.semibold)
                                        Text("Intrínseca: \(String(format: "%.1f", response.intrinsicLoad))")
                                        Text("Extrínseca: \(String(format: "%.1f", response.extraneousLoad))")
                                        Text("Germane: \(String(format: "%.1f", response.germaneLoad))")
                                    }
                                    .font(.AG.caption)
                                    Divider()
                                }
                            }
                        }
                    }

                    // Retention Tests
                    if !participant.retentionTests.isEmpty {
                        CardView {
                            VStack(alignment: .leading, spacing: Spacing.sm) {
                                Text("Tests de Retención")
                                    .font(.AG.subtitle)
                                    .foregroundColor(Color.AG.primaryText)

                                ForEach(participant.retentionTests) { test in
                                    HStack {
                                        Text("Forma \(test.form)")
                                            .fontWeight(.semibold)
                                        Spacer()
                                        Text("\(test.totalScore)/\(test.responses.count)")
                                        Text("(\(String(format: "%.1f", test.scorePercentage))%)")
                                            .foregroundColor(Color.AG.accent)
                                    }
                                    .font(.AG.caption)
                                }
                            }
                        }
                    }

                    // Badges
                    CardView {
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            Text("Insignias Obtenidas")
                                .font(.AG.subtitle)
                                .foregroundColor(Color.AG.primaryText)

                            let unlocked = participant.badges.filter { $0.isUnlocked }
                            if unlocked.isEmpty {
                                Text("Ninguna insignia desbloqueada aún")
                                    .font(.AG.caption)
                                    .foregroundColor(Color.AG.secondaryText)
                            } else {
                                ForEach(unlocked) { badge in
                                    HStack {
                                        Image(systemName: badge.iconName)
                                            .foregroundColor(Color.AG.accent)
                                        Text(badge.name)
                                        Spacer()
                                        if let date = badge.unlockedDate {
                                            Text(date.formatted(date: .abbreviated, time: .omitted))
                                                .foregroundColor(Color.AG.secondaryText)
                                        }
                                    }
                                    .font(.AG.caption)
                                }
                            }
                        }
                    }

                    // Export button
                    VStack(spacing: Spacing.sm) {
                        PrimaryButton(title: "Exportar Datos (JSON)") {
                            exportData()
                        }

                        SecondaryButton(title: "Exportar Todos los Participantes") {
                            exportAllParticipants()
                        }
                    }
                } else {
                    Text("No hay datos de participante disponibles")
                        .font(.AG.body)
                        .foregroundColor(Color.AG.secondaryText)
                }
            }
            .padding(.horizontal, Spacing.screenHorizontal)
            .padding(.bottom, Spacing.xxl)
        }
        .background(Color.AG.background)
        .navigationTitle("Panel del Investigador")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cerrar") { dismiss() }
            }
        }
        .sheet(isPresented: $showShareSheet) {
            if let url = exportURL {
                ShareSheet(items: [url])
            }
        }
        .alert("Error", isPresented: $showError) {
            Button("OK") {}
        } message: {
            Text(errorMessage)
        }
    }

    // MARK: - Export

    private func exportData() {
        guard let participant = appState.participant else { return }
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(participant)

            let dateStr = ISO8601DateFormatter().string(from: Date()).replacingOccurrences(of: ":", with: "-")
            let fileName = "AlgebraGo_\(participant.id)_\(dateStr).json"
            let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
            try data.write(to: tempURL)

            exportURL = tempURL
            showShareSheet = true
        } catch {
            errorMessage = "Error al exportar: \(error.localizedDescription)"
            showError = true
        }
    }

    private func exportAllParticipants() {
        // Collect all saved participants
        var allParticipants: [Participant] = []
        for i in 1...40 {
            let id = String(format: "P%02d", i)
            if let participant = appState.loadParticipant(id: id) {
                allParticipants.append(participant)
            }
        }

        guard !allParticipants.isEmpty else {
            errorMessage = String(localized: "No se encontraron participantes guardados")
            showError = true
            return
        }

        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(allParticipants)

            let dateStr = ISO8601DateFormatter().string(from: Date()).replacingOccurrences(of: ":", with: "-")
            let fileName = "AlgebraGo_AllParticipants_\(dateStr).json"
            let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
            try data.write(to: tempURL)

            exportURL = tempURL
            showShareSheet = true
        } catch {
            errorMessage = "Error al exportar: \(error.localizedDescription)"
            showError = true
        }
    }
}

// MARK: - Share Sheet

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
