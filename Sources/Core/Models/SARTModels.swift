import Foundation

struct SARTSession: Codable, Identifiable {
    var id: UUID = UUID()
    var weekNumber: Int
    var sessionNumberInWeek: Int
    var version: String         // "A" | "B"
    var startTimestamp: Date
    var endTimestamp: Date?
    var commissionErrors: Int   // Responded to target (3)
    var omissionErrors: Int     // Didn't respond to non-target
    var meanRT: Double          // ms
    var sdRT: Double            // ms
    var stimuli: [SARTStimulus]

    init(weekNumber: Int, sessionNumberInWeek: Int, version: String) {
        self.weekNumber = weekNumber
        self.sessionNumberInWeek = sessionNumberInWeek
        self.version = version
        self.startTimestamp = Date()
        self.commissionErrors = 0
        self.omissionErrors = 0
        self.meanRT = 0
        self.sdRT = 0
        self.stimuli = []
    }

    mutating func calculateMetrics() {
        let targets = stimuli.filter { $0.isTarget }
        commissionErrors = targets.filter { $0.userResponded }.count

        let nonTargets = stimuli.filter { !$0.isTarget }
        omissionErrors = nonTargets.filter { !$0.userResponded }.count

        let correctNonTargetRTs = nonTargets
            .filter { $0.userResponded }
            .compactMap { $0.reactionTime }

        if !correctNonTargetRTs.isEmpty {
            meanRT = correctNonTargetRTs.reduce(0, +) / Double(correctNonTargetRTs.count)
            let variance = correctNonTargetRTs.map { pow($0 - meanRT, 2) }.reduce(0, +) / Double(correctNonTargetRTs.count)
            sdRT = sqrt(variance)
        }
    }
}

struct SARTStimulus: Codable, Identifiable {
    var id: UUID = UUID()
    var digit: Int
    var isTarget: Bool
    var userResponded: Bool
    var reactionTime: Double?   // ms, nil if no response
    var timestamp: Date

    init(digit: Int) {
        self.digit = digit
        self.isTarget = digit == 3
        self.userResponded = false
        self.reactionTime = nil
        self.timestamp = Date()
    }
}
