@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {
    
    // MARK: - Normal Item
    func test_NormalItem_When_NotExpired_QualityDecrease() throws {
        let items = [Item(name: "foo", sellIn: 10, quality: 5)]
        let app = GildedRose(items: items)
        app.updateQuality(days: 2)
        XCTAssertEqual(app.items[0].name, "foo")
        XCTAssertEqual(app.items[0].sellIn, 8)
        XCTAssertEqual(app.items[0].quality, 3)
    }
    
    func test_NormalItem_When_Expired_QualityDecreaseTwiceAsFast() throws {
        let items = [Item(name: "foo", sellIn: 0, quality: 5)]
        let app = GildedRose(items: items)
        app.updateQuality(days: 2)
        XCTAssertEqual(app.items[0].name, "foo")
        XCTAssertEqual(app.items[0].sellIn, -2)
        XCTAssertEqual(app.items[0].quality, 1)
    }
    
    func test_NormalItem_When_BecomingExpired_QualityDecreaseNornalThenFast() throws {
        let items = [Item(name: "foo", sellIn: 1, quality: 5)]
        let app = GildedRose(items: items)
        app.updateQuality(days: 2)
        XCTAssertEqual(app.items[0].name, "foo")
        XCTAssertEqual(app.items[0].sellIn, -1)
        XCTAssertEqual(app.items[0].quality, 2)
    }
    
    func test_NormalItem_QualityShouldNotGoBelowZero() throws {
        let items = [Item(name: "foo", sellIn: 1, quality: 0)]
        let app = GildedRose(items: items)
        app.updateQuality(days: 2)
        XCTAssertEqual(app.items[0].name, "foo")
        XCTAssertEqual(app.items[0].sellIn, -1)
        XCTAssertEqual(app.items[0].quality, 0)
    }

    // MARK: - Sulfuras
    func test_Sulfuras_SellInNotChanged_QualityAlways80() {
        let items = [Item(name: "Sulfuras, Hand of Ragnaros", sellIn: -1, quality: 80)]
        let app = GildedRose(items: items)
        app.updateQuality(days: 2)
        XCTAssertEqual(app.items[0].name, "Sulfuras, Hand of Ragnaros")
        XCTAssertEqual(app.items[0].sellIn, -1)
        XCTAssertEqual(app.items[0].quality, 80)
    }
    
    // MARK: - Aged Brie
    func test_AgedBrie_QualityShouldIncrease() {
        let items = [Item(name: "Aged Brie", sellIn: 3, quality: 2)]
        let app = GildedRose(items: items)
        app.updateQuality(days: 2)
        XCTAssertEqual(app.items[0].name, "Aged Brie")
        XCTAssertEqual(app.items[0].sellIn, 1)
        XCTAssertEqual(app.items[0].quality, 4)
    }
    
    func test_AgedBrie_WhenSellInBecomeNegative_QualityShouldIncreaseNormalThenTwiceAsFast() {
        let items = [Item(name: "Aged Brie", sellIn: 1, quality: 2)]
        let app = GildedRose(items: items)
        app.updateQuality(days: 2)
        XCTAssertEqual(app.items[0].name, "Aged Brie")
        XCTAssertEqual(app.items[0].sellIn, -1)
        XCTAssertEqual(app.items[0].quality, 5)
    }
    
    func test_AgedBrie_WhenSellInNegative_QualityShouldIncreaseTwiceAsFast() {
        let items = [Item(name: "Aged Brie", sellIn: 0, quality: 2)]
        let app = GildedRose(items: items)
        app.updateQuality(days: 2)
        XCTAssertEqual(app.items[0].name, "Aged Brie")
        XCTAssertEqual(app.items[0].sellIn, -2)
        XCTAssertEqual(app.items[0].quality, 6)
    }
    
    func test_AgedBrie_QualityCannotBeAbove50() {
        let items = [Item(name: "Aged Brie", sellIn: 2, quality: 49)]
        let app = GildedRose(items: items)
        app.updateQuality(days: 2)
        XCTAssertEqual(app.items[0].name, "Aged Brie")
        XCTAssertEqual(app.items[0].sellIn, 0)
        XCTAssertEqual(app.items[0].quality, 50)
    }
    
    // MARK: - Backstage Pass
    func test_BackstagePass_WhenSellInGreaterThan10_QualityShouldIncreaseNormal() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 13, quality: 2)]
        let app = GildedRose(items: items)
        app.updateQuality(days: 2)
        XCTAssertEqual(app.items[0].name, "Backstage passes to a TAFKAL80ETC concert")
        XCTAssertEqual(app.items[0].sellIn, 11)
        XCTAssertEqual(app.items[0].quality, 4)
    }
    
    func test_BackstagePass_WhenSellInBellow10Greater5_QualityShouldIncreaseDouble() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 9, quality: 2)]
        let app = GildedRose(items: items)
        app.updateQuality(days: 2)
        XCTAssertEqual(app.items[0].name, "Backstage passes to a TAFKAL80ETC concert")
        XCTAssertEqual(app.items[0].sellIn, 7)
        XCTAssertEqual(app.items[0].quality, 6)
    }
    
    func test_BackstagePass_WhenSellInBellow5_QualityShouldIncreaseTriple() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 2)]
        let app = GildedRose(items: items)
        app.updateQuality(days: 2)
        XCTAssertEqual(app.items[0].name, "Backstage passes to a TAFKAL80ETC concert")
        XCTAssertEqual(app.items[0].sellIn, 3)
        XCTAssertEqual(app.items[0].quality, 8)
    }
    
    func test_BackstagePass_WhenSellInBellow0_QualityShouldBe0() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 1, quality: 2)]
        let app = GildedRose(items: items)
        app.updateQuality(days: 2)
        XCTAssertEqual(app.items[0].name, "Backstage passes to a TAFKAL80ETC concert")
        XCTAssertEqual(app.items[0].sellIn, -1)
        XCTAssertEqual(app.items[0].quality, 0)
    }

    func test_BackstagePass_QualitCannotAbove50() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 49)]
        let app = GildedRose(items: items)
        app.updateQuality(days: 2)
        XCTAssertEqual(app.items[0].name, "Backstage passes to a TAFKAL80ETC concert")
        XCTAssertEqual(app.items[0].sellIn, 3)
        XCTAssertEqual(app.items[0].quality, 50)
    }
    
    // MARK: - Conjured Item
    func test_ConjuredItem_When_NotExpired_QualityDecreaseBy2() throws {
        let items = [Item(name: "Conjured Mana Cake", sellIn: 10, quality: 5)]
        let app = GildedRose(items: items)
        app.updateQuality(days: 2)
        XCTAssertEqual(app.items[0].name, "Conjured Mana Cake")
        XCTAssertEqual(app.items[0].sellIn, 8)
        XCTAssertEqual(app.items[0].quality, 1)
    }
    
    func test_ConjuredItem_When_Expired_QualityDecreaseBy4() throws {
        let items = [Item(name: "Conjured Mana Cake", sellIn: 0, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality(days: 2)
        XCTAssertEqual(app.items[0].name, "Conjured Mana Cake")
        XCTAssertEqual(app.items[0].sellIn, -2)
        XCTAssertEqual(app.items[0].quality, 2)
    }
    
    func test_ConjuredItem_When_BecomingExpired_QualityDecreaseBy2Then4() throws {
        let items = [Item(name: "Conjured Mana Cake", sellIn: 1, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality(days: 2)
        XCTAssertEqual(app.items[0].name, "Conjured Mana Cake")
        XCTAssertEqual(app.items[0].sellIn, -1)
        XCTAssertEqual(app.items[0].quality, 4)
    }
    
    func test_ConjuredItem_QualityShouldNotGoBelowZero() throws {
        let items = [Item(name: "Conjured Mana Cake", sellIn: 1, quality: 5)]
        let app = GildedRose(items: items)
        app.updateQuality(days: 2)
        XCTAssertEqual(app.items[0].name, "Conjured Mana Cake")
        XCTAssertEqual(app.items[0].sellIn, -1)
        XCTAssertEqual(app.items[0].quality, 0)
    }

}

extension GildedRose {
    func updateQuality(days: Int) {
        (0..<days).forEach { _ in updateQuality() }
    }
}
