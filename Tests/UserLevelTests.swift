import Testing
@testable import AlgebraGo

struct UserLevelTests {

    // MARK: - calculate(points:)

    @Test func calculateLevel_atZeroPoints_returnsLevel1() {
        #expect(UserLevel.calculate(points: 0) == 1)
    }

    @Test func calculateLevel_atUpperBoundOfLevel1_returnsLevel1() {
        #expect(UserLevel.calculate(points: 50) == 1)
    }

    @Test func calculateLevel_atLowerBoundOfLevel2_returnsLevel2() {
        #expect(UserLevel.calculate(points: 51) == 2)
    }

    @Test func calculateLevel_atUpperBoundOfLevel2_returnsLevel2() {
        #expect(UserLevel.calculate(points: 100) == 2)
    }

    @Test func calculateLevel_atLowerBoundOfLevel3_returnsLevel3() {
        #expect(UserLevel.calculate(points: 101) == 3)
    }

    @Test func calculateLevel_atUpperBoundOfLevel3_returnsLevel3() {
        #expect(UserLevel.calculate(points: 180) == 3)
    }

    @Test func calculateLevel_atLowerBoundOfLevel4_returnsLevel4() {
        #expect(UserLevel.calculate(points: 181) == 4)
    }

    @Test func calculateLevel_atUpperBoundOfLevel4_returnsLevel4() {
        #expect(UserLevel.calculate(points: 280) == 4)
    }

    @Test func calculateLevel_atLowerBoundOfLevel5_returnsLevel5() {
        #expect(UserLevel.calculate(points: 281) == 5)
    }

    @Test func calculateLevel_atVeryHighPoints_returnsLevel5() {
        #expect(UserLevel.calculate(points: 1000) == 5)
    }

    // MARK: - name(for:)

    @Test func levelName_returnsCorrectNames() {
        #expect(UserLevel.name(for: 1) == String(localized: "Aprendiz"))
        #expect(UserLevel.name(for: 2) == String(localized: "Estudiante"))
        #expect(UserLevel.name(for: 3) == String(localized: "Practicante"))
        #expect(UserLevel.name(for: 4) == String(localized: "Experto"))
        #expect(UserLevel.name(for: 5) == String(localized: "Maestro"))
    }

    @Test func levelName_invalidLevel_returnsAprendiz() {
        #expect(UserLevel.name(for: 0) == String(localized: "Aprendiz"))
        #expect(UserLevel.name(for: 99) == String(localized: "Aprendiz"))
    }

    // MARK: - pointsRange(for:)

    @Test func pointsRange_level1_returns0to50() {
        let range = UserLevel.pointsRange(for: 1)
        #expect(range.min == 0)
        #expect(range.max == 50)
    }

    @Test func pointsRange_level5_returns281to500() {
        let range = UserLevel.pointsRange(for: 5)
        #expect(range.min == 281)
        #expect(range.max == 500)
    }

    @Test func pointsRange_invalidLevel_returnsLevel1Range() {
        let range = UserLevel.pointsRange(for: 99)
        #expect(range.min == 0)
        #expect(range.max == 50)
    }

    // MARK: - progressInLevel(points:)

    @Test func progressInLevel_atStartOfLevel1_returnsZero() {
        let progress = UserLevel.progressInLevel(points: 0)
        #expect(progress == 0.0)
    }

    @Test func progressInLevel_atMidpointOfLevel1_returnsHalf() {
        let progress = UserLevel.progressInLevel(points: 25)
        #expect(progress == 0.5)
    }

    @Test func progressInLevel_atEndOfLevel1_returnsOne() {
        let progress = UserLevel.progressInLevel(points: 50)
        #expect(progress == 1.0)
    }

    @Test func progressInLevel_atStartOfLevel2_returnsZero() {
        let progress = UserLevel.progressInLevel(points: 51)
        #expect(progress >= 0.0)
        #expect(progress <= 0.05)
    }

    @Test func progressInLevel_neverExceedsOne() {
        for points in stride(from: 0, through: 600, by: 10) {
            let progress = UserLevel.progressInLevel(points: points)
            #expect(progress >= 0.0)
            #expect(progress <= 1.0)
        }
    }
}
