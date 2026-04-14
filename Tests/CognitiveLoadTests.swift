import Testing
import Foundation
@testable import AlgebraGo

struct CognitiveLoadTests {

    // MARK: - Intrinsic Load

    @Test func intrinsicLoad_calculatesAverageOfFirstThreeItems() {
        let response = CognitiveLoadResponse(
            moduleId: "1_1",
            responses: [3, 6, 9, 1, 1, 1, 1, 1, 1],
            timestamp: Date()
        )
        #expect(response.intrinsicLoad == 6.0)
    }

    @Test func intrinsicLoad_insufficientResponses_returnsZero() {
        let response = CognitiveLoadResponse(
            moduleId: "1_1",
            responses: [5, 5],
            timestamp: Date()
        )
        #expect(response.intrinsicLoad == 0)
    }

    // MARK: - Extraneous Load

    @Test func extraneousLoad_calculatesAverageOfItems4to6() {
        let response = CognitiveLoadResponse(
            moduleId: "1_1",
            responses: [1, 1, 1, 2, 4, 6, 1, 1, 1],
            timestamp: Date()
        )
        #expect(response.extraneousLoad == 4.0)
    }

    @Test func extraneousLoad_insufficientResponses_returnsZero() {
        let response = CognitiveLoadResponse(
            moduleId: "1_1",
            responses: [5, 5, 5, 5, 5],
            timestamp: Date()
        )
        #expect(response.extraneousLoad == 0)
    }

    // MARK: - Germane Load

    @Test func germaneLoad_calculatesAverageOfItems7to9() {
        let response = CognitiveLoadResponse(
            moduleId: "1_1",
            responses: [1, 1, 1, 1, 1, 1, 7, 8, 9],
            timestamp: Date()
        )
        #expect(response.germaneLoad == 8.0)
    }

    @Test func germaneLoad_insufficientResponses_returnsZero() {
        let response = CognitiveLoadResponse(
            moduleId: "1_1",
            responses: [5, 5, 5, 5, 5, 5, 5, 5],
            timestamp: Date()
        )
        #expect(response.germaneLoad == 0)
    }

    // MARK: - Full Scale

    @Test func allSubscales_withUniformResponses() {
        let response = CognitiveLoadResponse(
            moduleId: "2_1",
            responses: [5, 5, 5, 5, 5, 5, 5, 5, 5],
            timestamp: Date()
        )
        #expect(response.intrinsicLoad == 5.0)
        #expect(response.extraneousLoad == 5.0)
        #expect(response.germaneLoad == 5.0)
    }

    @Test func allSubscales_withMinimumValues() {
        let response = CognitiveLoadResponse(
            moduleId: "2_1",
            responses: [1, 1, 1, 1, 1, 1, 1, 1, 1],
            timestamp: Date()
        )
        #expect(response.intrinsicLoad == 1.0)
        #expect(response.extraneousLoad == 1.0)
        #expect(response.germaneLoad == 1.0)
    }

    @Test func allSubscales_withMaximumValues() {
        let response = CognitiveLoadResponse(
            moduleId: "2_1",
            responses: [9, 9, 9, 9, 9, 9, 9, 9, 9],
            timestamp: Date()
        )
        #expect(response.intrinsicLoad == 9.0)
        #expect(response.extraneousLoad == 9.0)
        #expect(response.germaneLoad == 9.0)
    }

    // MARK: - Codable

    @Test func cognitiveLoadResponse_encodesAndDecodes() throws {
        let original = CognitiveLoadResponse(
            moduleId: "3_2",
            responses: [3, 4, 5, 2, 3, 4, 7, 8, 6],
            timestamp: Date()
        )

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(original)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(CognitiveLoadResponse.self, from: data)

        #expect(decoded.moduleId == "3_2")
        #expect(decoded.responses == [3, 4, 5, 2, 3, 4, 7, 8, 6])
    }
}
