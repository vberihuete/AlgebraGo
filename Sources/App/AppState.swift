import SwiftUI
import Foundation

@Observable
final class AppState {
    static let shared = AppState()

    var isOnboarded: Bool {
        get { UserDefaults.standard.bool(forKey: "isOnboarded") }
        set { UserDefaults.standard.set(newValue, forKey: "isOnboarded") }
    }

    var currentParticipantId: String? {
        get { UserDefaults.standard.string(forKey: "currentParticipantId") }
        set { UserDefaults.standard.set(newValue, forKey: "currentParticipantId") }
    }

    var participant: Participant? {
        didSet {
            if let participant {
                saveParticipant(participant)
            }
        }
    }

    var needsSART: Bool = false
    var pendingSARTVersion: String = "A"
    var showPreTest: Bool = false
    var showPostTest: Bool = false
    var showReflexiveSurvey: Bool = false

    private init() {
        if let id = currentParticipantId {
            participant = loadParticipant(id: id)
        }
    }

    func completeOnboarding(participant: Participant) {
        self.participant = participant
        self.currentParticipantId = participant.id
        self.isOnboarded = true
        saveParticipant(participant)
    }

    func logout() {
        isOnboarded = false
        currentParticipantId = nil
        participant = nil
    }

    func saveParticipant(_ participant: Participant) {
        guard let data = try? JSONEncoder().encode(participant) else { return }
        UserDefaults.standard.set(data, forKey: "participant_\(participant.id)")
    }

    func loadParticipant(id: String) -> Participant? {
        guard let data = UserDefaults.standard.data(forKey: "participant_\(id)") else { return nil }
        return try? JSONDecoder().decode(Participant.self, from: data)
    }

    func checkSARTNeeded() {
        guard let participant else { return }
        let sessionCount = participant.totalSessionsThisWeek()
        // SART activates at 2nd and 4th session of each week
        if sessionCount == 1 || sessionCount == 3 {
            needsSART = true
            pendingSARTVersion = sessionCount == 1 ? "A" : "B"
        } else {
            needsSART = false
        }
    }

    func addPoints(_ points: Int) {
        guard var p = participant else { return }
        p.points += points
        p.level = UserLevel.calculate(points: p.points)
        participant = p
    }
}
