import Foundation

struct Participant: Codable, Identifiable {
    var id: String                  // e.g. "P01"
    var avatar: Int                 // 1-6
    var algebraLevel: AlgebraLevel
    var groupType: GroupType
    var startDate: Date
    var points: Int
    var level: Int                  // 1-5
    var badges: [Badge]
    var moduleProgress: [ModuleProgress]
    var sartSessions: [SARTSession]
    var cognitiveLoadResponses: [CognitiveLoadResponse]
    var retentionTests: [RetentionTest]
    var reflexiveResponse: ReflexiveResponse?
    var sessionLog: [SessionEntry]
    var streakDays: [String]        // ISO date strings of active days

    init(
        id: String,
        avatar: Int = 1,
        algebraLevel: AlgebraLevel = .basico,
        groupType: GroupType = .experimental
    ) {
        self.id = id
        self.avatar = avatar
        self.algebraLevel = algebraLevel
        self.groupType = groupType
        self.startDate = Date()
        self.points = 0
        self.level = 1
        self.badges = []
        self.moduleProgress = []
        self.sartSessions = []
        self.cognitiveLoadResponses = []
        self.retentionTests = []
        self.reflexiveResponse = nil
        self.sessionLog = []
        self.streakDays = []
    }

    func totalSessionsThisWeek() -> Int {
        let calendar = Calendar.current
        let now = Date()
        guard let weekStart = calendar.dateInterval(of: .weekOfYear, for: now)?.start else { return 0 }
        return sessionLog.filter { $0.date >= weekStart }.count
    }

    func currentWeekNumber() -> Int {
        let calendar = Calendar.current
        let weeks = calendar.dateComponents([.weekOfYear], from: startDate, to: Date()).weekOfYear ?? 0
        return weeks + 1
    }

    var completedModuleCount: Int {
        moduleProgress.filter { $0.status == .completed }.count
    }

    var overallProgress: Double {
        guard !moduleProgress.isEmpty else { return 0 }
        return Double(completedModuleCount) / 12.0
    }

    mutating func recordActiveDay() {
        let today = ISO8601DateFormatter().string(from: Date()).prefix(10)
        let todayString = String(today)
        if !streakDays.contains(todayString) {
            streakDays.append(todayString)
        }
    }

    func currentStreak() -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let sorted = streakDays.compactMap { formatter.date(from: $0) }.sorted().reversed()
        var streak = 0
        var expectedDate = Calendar.current.startOfDay(for: Date())
        for date in sorted {
            let day = Calendar.current.startOfDay(for: date)
            if day == expectedDate {
                streak += 1
                expectedDate = Calendar.current.date(byAdding: .day, value: -1, to: expectedDate)!
            } else {
                break
            }
        }
        return streak
    }
}

enum AlgebraLevel: String, Codable, CaseIterable {
    case basico = "Básico"
    case intermedio = "Intermedio"
    case avanzado = "Avanzado"
}

enum GroupType: String, Codable, CaseIterable {
    case experimental = "experimental"
    case control = "control"
}

struct SessionEntry: Codable, Identifiable {
    var id: UUID = UUID()
    var date: Date
    var durationSeconds: Int
    var modulesAccessed: [String]
}
