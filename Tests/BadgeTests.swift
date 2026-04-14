import Testing
import Foundation
@testable import AlgebraGo

struct BadgeTests {

    // MARK: - allBadges

    @Test func allBadges_hasCorrectTotalCount() {
        // 12 module + 3 unit + 1 streak + 1 perfect = 17
        #expect(Badge.allBadges.count == 17)
    }

    @Test func allBadges_has12ModuleBadges() {
        let moduleBadges = Badge.allBadges.filter { $0.category == .module }
        #expect(moduleBadges.count == 12)
    }

    @Test func allBadges_has3UnitBadges() {
        let unitBadges = Badge.allBadges.filter { $0.category == .unit }
        #expect(unitBadges.count == 3)
    }

    @Test func allBadges_has1StreakBadge() {
        let streakBadges = Badge.allBadges.filter { $0.category == .streak }
        #expect(streakBadges.count == 1)
    }

    @Test func allBadges_has1PerfectBadge() {
        let perfectBadges = Badge.allBadges.filter { $0.category == .perfect }
        #expect(perfectBadges.count == 1)
    }

    @Test func allBadges_allStartLocked() {
        for badge in Badge.allBadges {
            #expect(badge.isUnlocked == false, "Badge \(badge.id) should start locked")
        }
    }

    @Test func allBadges_haveUniqueIds() {
        let ids = Badge.allBadges.map(\.id)
        let uniqueIds = Set(ids)
        #expect(ids.count == uniqueIds.count, "Badge IDs must be unique")
    }

    @Test func allBadges_haveNonEmptyNames() {
        for badge in Badge.allBadges {
            #expect(!badge.name.isEmpty, "Badge \(badge.id) must have a name")
        }
    }

    @Test func allBadges_haveValidIconNames() {
        for badge in Badge.allBadges {
            #expect(!badge.iconName.isEmpty, "Badge \(badge.id) must have an icon")
        }
    }

    // MARK: - Module badge IDs match expected format

    @Test func moduleBadges_followNamingConvention() {
        let expected = ["m1_1", "m1_2", "m1_3", "m1_4",
                        "m2_1", "m2_2", "m2_3", "m2_4",
                        "m3_1", "m3_2", "m3_3", "m3_4"]
        let moduleBadgeIds = Badge.allBadges
            .filter { $0.category == .module }
            .map(\.id)
            .sorted()

        #expect(moduleBadgeIds.sorted() == expected.sorted())
    }

    @Test func unitBadges_followNamingConvention() {
        let expected = ["unit_1", "unit_2", "unit_3"]
        let unitBadgeIds = Badge.allBadges
            .filter { $0.category == .unit }
            .map(\.id)
            .sorted()

        #expect(unitBadgeIds == expected)
    }

    // MARK: - Codable

    @Test func badge_encodesAndDecodes() throws {
        var badge = Badge.allBadges[0]
        badge.isUnlocked = true
        badge.unlockedDate = Date()

        let data = try JSONEncoder().encode(badge)
        let decoded = try JSONDecoder().decode(Badge.self, from: data)

        #expect(decoded.id == badge.id)
        #expect(decoded.isUnlocked == true)
        #expect(decoded.unlockedDate != nil)
    }
}
