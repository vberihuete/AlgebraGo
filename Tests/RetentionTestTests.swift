import Testing
import Foundation
@testable import AlgebraGo

struct RetentionTestTests {

    // MARK: - RetentionTest scorePercentage

    @Test func scorePercentage_allCorrect_returns100() {
        let test = RetentionTest(
            form: "A",
            startTimestamp: Date(),
            endTimestamp: Date(),
            responses: (0..<20).map {
                TestItemResponse(itemIndex: $0, selectedOption: 0, isCorrect: true, timeSpentMs: 1000, timestamp: Date())
            },
            totalScore: 20
        )
        #expect(test.scorePercentage == 100.0)
    }

    @Test func scorePercentage_halfCorrect_returns50() {
        let test = RetentionTest(
            form: "B",
            startTimestamp: Date(),
            endTimestamp: Date(),
            responses: (0..<20).map {
                TestItemResponse(itemIndex: $0, selectedOption: 0, isCorrect: $0 < 10, timeSpentMs: 500, timestamp: Date())
            },
            totalScore: 10
        )
        #expect(test.scorePercentage == 50.0)
    }

    @Test func scorePercentage_noneCorrect_returnsZero() {
        let test = RetentionTest(
            form: "A",
            startTimestamp: Date(),
            endTimestamp: Date(),
            responses: [
                TestItemResponse(itemIndex: 0, selectedOption: 1, isCorrect: false, timeSpentMs: 800, timestamp: Date())
            ],
            totalScore: 0
        )
        #expect(test.scorePercentage == 0.0)
    }

    @Test func scorePercentage_emptyResponses_returnsZero() {
        let test = RetentionTest(
            form: "A",
            startTimestamp: Date(),
            endTimestamp: Date(),
            responses: [],
            totalScore: 0
        )
        #expect(test.scorePercentage == 0.0)
    }

    // MARK: - RetentionTestData

    @Test func formA_has20Items() {
        #expect(RetentionTestData.formA.count == 20)
    }

    @Test func formB_has20Items() {
        #expect(RetentionTestData.formB.count == 20)
    }

    @Test func formA_allItemsHave4Options() {
        for item in RetentionTestData.formA {
            #expect(item.options.count == 4, "Item \(item.index) should have 4 options")
        }
    }

    @Test func formB_allItemsHave4Options() {
        for item in RetentionTestData.formB {
            #expect(item.options.count == 4, "Item \(item.index) should have 4 options")
        }
    }

    @Test func formA_correctIndicesInRange() {
        for item in RetentionTestData.formA {
            #expect(item.correctIndex >= 0 && item.correctIndex <= 3,
                    "Item \(item.index) correctIndex \(item.correctIndex) out of range")
        }
    }

    @Test func formB_correctIndicesInRange() {
        for item in RetentionTestData.formB {
            #expect(item.correctIndex >= 0 && item.correctIndex <= 3,
                    "Item \(item.index) correctIndex \(item.correctIndex) out of range")
        }
    }

    @Test func items_forFormA_returnsFormA() {
        let items = RetentionTestData.items(for: "A")
        #expect(items.count == 20)
    }

    @Test func items_forFormB_returnsFormB() {
        let items = RetentionTestData.items(for: "B")
        #expect(items.count == 20)
    }

    // MARK: - Codable

    @Test func retentionTest_encodesAndDecodes() throws {
        let test = RetentionTest(
            form: "A",
            startTimestamp: Date(),
            endTimestamp: Date(),
            responses: [
                TestItemResponse(itemIndex: 0, selectedOption: 1, isCorrect: true, timeSpentMs: 2500, timestamp: Date())
            ],
            totalScore: 1
        )

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(test)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(RetentionTest.self, from: data)

        #expect(decoded.form == "A")
        #expect(decoded.totalScore == 1)
        #expect(decoded.responses.count == 1)
        #expect(decoded.responses.first?.timeSpentMs == 2500)
    }
}
