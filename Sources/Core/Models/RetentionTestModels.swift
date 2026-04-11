import Foundation

struct RetentionTest: Codable, Identifiable {
    var id: UUID = UUID()
    var form: String            // "A" (pre) or "B" (post)
    var startTimestamp: Date
    var endTimestamp: Date?
    var responses: [TestItemResponse]
    var totalScore: Int

    var scorePercentage: Double {
        guard !responses.isEmpty else { return 0 }
        return Double(totalScore) / Double(responses.count) * 100.0
    }
}

struct TestItemResponse: Codable, Identifiable {
    var id: UUID = UUID()
    var itemIndex: Int
    var selectedOption: Int
    var isCorrect: Bool
    var timeSpentMs: Double
    var timestamp: Date
}

struct TestItem: Identifiable {
    var id = UUID()
    var index: Int
    var question: String
    var options: [String]
    var correctIndex: Int
    var category: String
}

// MARK: - Reflexive Survey

struct ReflexiveResponse: Codable {
    var likertResponses: [Int]      // 10 items, 1-5
    var openResponse1: String       // item 11
    var openResponse2: String       // item 12
    var timestamp: Date
}

struct SurveyItem: Identifiable {
    var id = UUID()
    var index: Int
    var text: String
    var type: SurveyItemType
    var experimentalOnly: Bool
}

enum SurveyItemType {
    case likert
    case openText
}
