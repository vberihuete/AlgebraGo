import Testing
import Foundation
@testable import AlgebraGo

struct SARTTests {

    // MARK: - SARTStimulus

    @Test func stimulus_digit3_isTarget() {
        let stimulus = SARTStimulus(digit: 3)
        #expect(stimulus.isTarget == true)
        #expect(stimulus.digit == 3)
        #expect(stimulus.userResponded == false)
        #expect(stimulus.reactionTime == nil)
    }

    @Test func stimulus_nonTargetDigits_areNotTarget() {
        for digit in [1, 2, 4, 5, 6, 7, 8, 9] {
            let stimulus = SARTStimulus(digit: digit)
            #expect(stimulus.isTarget == false, "Digit \(digit) should not be a target")
        }
    }

    // MARK: - SARTSession Initialization

    @Test func session_initialValues() {
        let session = SARTSession(weekNumber: 2, sessionNumberInWeek: 1, version: "A")
        #expect(session.weekNumber == 2)
        #expect(session.sessionNumberInWeek == 1)
        #expect(session.version == "A")
        #expect(session.commissionErrors == 0)
        #expect(session.omissionErrors == 0)
        #expect(session.meanRT == 0)
        #expect(session.sdRT == 0)
        #expect(session.stimuli.isEmpty)
    }

    // MARK: - calculateMetrics()

    @Test func calculateMetrics_commissionErrors_countsResponsesOnTargets() {
        var session = SARTSession(weekNumber: 1, sessionNumberInWeek: 1, version: "A")

        // Target (digit 3) — user incorrectly responded
        var target1 = SARTStimulus(digit: 3)
        target1.userResponded = true
        target1.reactionTime = 300

        // Target (digit 3) — user correctly withheld
        let target2 = SARTStimulus(digit: 3)

        // Non-target — user responded
        var nonTarget = SARTStimulus(digit: 5)
        nonTarget.userResponded = true
        nonTarget.reactionTime = 250

        session.stimuli = [target1, target2, nonTarget]
        session.calculateMetrics()

        #expect(session.commissionErrors == 1)
    }

    @Test func calculateMetrics_omissionErrors_countsNoResponseOnNonTargets() {
        var session = SARTSession(weekNumber: 1, sessionNumberInWeek: 1, version: "A")

        // Non-target — user did NOT respond (omission error)
        let missed = SARTStimulus(digit: 7)

        // Non-target — user responded correctly
        var hit = SARTStimulus(digit: 5)
        hit.userResponded = true
        hit.reactionTime = 200

        // Target — user withheld (correct, not an omission)
        let target = SARTStimulus(digit: 3)

        session.stimuli = [missed, hit, target]
        session.calculateMetrics()

        #expect(session.omissionErrors == 1)
    }

    @Test func calculateMetrics_meanRT_averagesCorrectNonTargetResponses() {
        var session = SARTSession(weekNumber: 1, sessionNumberInWeek: 1, version: "A")

        var s1 = SARTStimulus(digit: 5)
        s1.userResponded = true
        s1.reactionTime = 200

        var s2 = SARTStimulus(digit: 7)
        s2.userResponded = true
        s2.reactionTime = 400

        session.stimuli = [s1, s2]
        session.calculateMetrics()

        #expect(session.meanRT == 300.0)
    }

    @Test func calculateMetrics_sdRT_calculatesStandardDeviation() {
        var session = SARTSession(weekNumber: 1, sessionNumberInWeek: 1, version: "A")

        // RT values: 200, 400 → mean = 300, variance = 10000, sd = 100
        var s1 = SARTStimulus(digit: 5)
        s1.userResponded = true
        s1.reactionTime = 200

        var s2 = SARTStimulus(digit: 7)
        s2.userResponded = true
        s2.reactionTime = 400

        session.stimuli = [s1, s2]
        session.calculateMetrics()

        #expect(session.sdRT == 100.0)
    }

    @Test func calculateMetrics_noResponses_keepsZeroValues() {
        var session = SARTSession(weekNumber: 1, sessionNumberInWeek: 1, version: "A")
        session.stimuli = [SARTStimulus(digit: 5), SARTStimulus(digit: 7)]
        session.calculateMetrics()

        #expect(session.meanRT == 0)
        #expect(session.sdRT == 0)
    }

    @Test func calculateMetrics_excludesTargetResponsesFromRT() {
        var session = SARTSession(weekNumber: 1, sessionNumberInWeek: 1, version: "A")

        // Target response (should NOT count toward RT)
        var target = SARTStimulus(digit: 3)
        target.userResponded = true
        target.reactionTime = 999

        // Non-target response (should count)
        var nonTarget = SARTStimulus(digit: 5)
        nonTarget.userResponded = true
        nonTarget.reactionTime = 250

        session.stimuli = [target, nonTarget]
        session.calculateMetrics()

        #expect(session.meanRT == 250.0)
        #expect(session.sdRT == 0.0)
    }

    // MARK: - SARTData sequences

    @Test func sartData_practiceHas10Stimuli() {
        #expect(SARTData.practice.count == 10)
    }

    @Test func sartData_versionAHas180Stimuli() {
        #expect(SARTData.versionA.count == 180)
    }

    @Test func sartData_versionBHas180Stimuli() {
        #expect(SARTData.versionB.count == 180)
    }

    @Test func sartData_versionAHasExpectedTargetProportion() {
        let targetCount = SARTData.versionA.filter { $0 == 3 }.count
        // ~11% of 180 = ~20 targets (actual implementation may vary slightly)
        #expect(targetCount >= 16 && targetCount <= 22,
                "Expected ~20 targets (~11%), got \(targetCount)")
    }

    @Test func sartData_versionBHasExpectedTargetProportion() {
        let targetCount = SARTData.versionB.filter { $0 == 3 }.count
        #expect(targetCount >= 16 && targetCount <= 22,
                "Expected ~20 targets (~11%), got \(targetCount)")
    }

    @Test func sartData_allDigitsInRange1to9() {
        let allDigits = SARTData.practice + SARTData.versionA + SARTData.versionB
        for digit in allDigits {
            #expect(digit >= 1 && digit <= 9, "Digit \(digit) out of range")
        }
    }

    @Test func sartData_versionsAreDifferent() {
        #expect(SARTData.versionA != SARTData.versionB)
    }

    // MARK: - Codable

    @Test func sartSession_encodesAndDecodes() throws {
        var session = SARTSession(weekNumber: 3, sessionNumberInWeek: 2, version: "B")
        var stimulus = SARTStimulus(digit: 5)
        stimulus.userResponded = true
        stimulus.reactionTime = 312.5
        session.stimuli = [stimulus]
        session.calculateMetrics()

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(session)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(SARTSession.self, from: data)

        #expect(decoded.weekNumber == 3)
        #expect(decoded.version == "B")
        #expect(decoded.stimuli.count == 1)
        #expect(decoded.stimuli.first?.reactionTime == 312.5)
    }
}
