import Testing
import Foundation
@testable import AlgebraGo

struct ParticipantTests {

    // MARK: - Initialization

    @Test func init_setsDefaultValues() {
        let participant = Participant(id: "P01")

        #expect(participant.id == "P01")
        #expect(participant.avatar == 1)
        #expect(participant.algebraLevel == .basico)
        #expect(participant.groupType == .experimental)
        #expect(participant.points == 0)
        #expect(participant.level == 1)
        #expect(participant.badges.isEmpty)
        #expect(participant.moduleProgress.isEmpty)
        #expect(participant.sartSessions.isEmpty)
        #expect(participant.cognitiveLoadResponses.isEmpty)
        #expect(participant.retentionTests.isEmpty)
        #expect(participant.reflexiveResponse == nil)
        #expect(participant.sessionLog.isEmpty)
        #expect(participant.streakDays.isEmpty)
    }

    @Test func init_withCustomValues() {
        let participant = Participant(
            id: "P15",
            avatar: 3,
            algebraLevel: .avanzado,
            groupType: .control
        )

        #expect(participant.id == "P15")
        #expect(participant.avatar == 3)
        #expect(participant.algebraLevel == .avanzado)
        #expect(participant.groupType == .control)
    }

    // MARK: - completedModuleCount

    @Test func completedModuleCount_noModules_returnsZero() {
        let participant = Participant(id: "P01")
        #expect(participant.completedModuleCount == 0)
    }

    @Test func completedModuleCount_withMixedStatuses() {
        var participant = Participant(id: "P01")

        var completed = ModuleProgress(moduleId: "1_1")
        completed.status = .completed
        var inProgress = ModuleProgress(moduleId: "1_2")
        inProgress.status = .inProgress
        let notStarted = ModuleProgress(moduleId: "1_3")

        participant.moduleProgress = [completed, inProgress, notStarted]
        #expect(participant.completedModuleCount == 1)
    }

    // MARK: - overallProgress

    @Test func overallProgress_noModules_returnsZero() {
        let participant = Participant(id: "P01")
        #expect(participant.overallProgress == 0)
    }

    @Test func overallProgress_allCompleted_returnsOne() {
        var participant = Participant(id: "P01")
        for i in 1...12 {
            var progress = ModuleProgress(moduleId: "module_\(i)")
            progress.status = .completed
            participant.moduleProgress.append(progress)
        }
        #expect(participant.overallProgress == 1.0)
    }

    @Test func overallProgress_halfCompleted() {
        var participant = Participant(id: "P01")
        for i in 1...6 {
            var progress = ModuleProgress(moduleId: "module_\(i)")
            progress.status = .completed
            participant.moduleProgress.append(progress)
        }
        #expect(participant.overallProgress == 0.5)
    }

    // MARK: - recordActiveDay & currentStreak

    @Test func recordActiveDay_addsToday() {
        var participant = Participant(id: "P01")
        participant.recordActiveDay()
        #expect(participant.streakDays.count == 1)
    }

    @Test func recordActiveDay_doesNotDuplicateSameDay() {
        var participant = Participant(id: "P01")
        participant.recordActiveDay()
        participant.recordActiveDay()
        #expect(participant.streakDays.count == 1)
    }

    @Test func currentStreak_noActiveDays_returnsZero() {
        let participant = Participant(id: "P01")
        #expect(participant.currentStreak() == 0)
    }

    @Test func currentStreak_todayOnly_returnsOne() {
        var participant = Participant(id: "P01")
        // Use the same format as currentStreak expects (local timezone)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        participant.streakDays.append(formatter.string(from: Date()))
        #expect(participant.currentStreak() == 1)
    }

    @Test func currentStreak_consecutiveDays_returnsCorrectCount() {
        var participant = Participant(id: "P01")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let calendar = Calendar.current

        // Add today and 2 previous days
        for dayOffset in 0...2 {
            let date = calendar.date(byAdding: .day, value: -dayOffset, to: Date())!
            let dateStr = formatter.string(from: date)
            participant.streakDays.append(dateStr)
        }

        #expect(participant.currentStreak() == 3)
    }

    @Test func currentStreak_withGap_breaksStreak() {
        var participant = Participant(id: "P01")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let calendar = Calendar.current

        // Today
        let today = formatter.string(from: Date())
        participant.streakDays.append(today)

        // 3 days ago (gap of 1 day)
        let threeDaysAgo = calendar.date(byAdding: .day, value: -3, to: Date())!
        participant.streakDays.append(formatter.string(from: threeDaysAgo))

        #expect(participant.currentStreak() == 1)
    }

    // MARK: - Codable

    @Test func participant_encodesAndDecodes() throws {
        var participant = Participant(id: "P05", avatar: 4, algebraLevel: .intermedio, groupType: .control)
        participant.points = 75
        participant.level = 2

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(participant)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(Participant.self, from: data)

        #expect(decoded.id == "P05")
        #expect(decoded.avatar == 4)
        #expect(decoded.algebraLevel == .intermedio)
        #expect(decoded.groupType == .control)
        #expect(decoded.points == 75)
        #expect(decoded.level == 2)
    }

    // MARK: - AlgebraLevel

    @Test func algebraLevel_rawValues() {
        #expect(AlgebraLevel.basico.rawValue == "Básico")
        #expect(AlgebraLevel.intermedio.rawValue == "Intermedio")
        #expect(AlgebraLevel.avanzado.rawValue == "Avanzado")
    }

    @Test func algebraLevel_allCases_hasThreeValues() {
        #expect(AlgebraLevel.allCases.count == 3)
    }
}
