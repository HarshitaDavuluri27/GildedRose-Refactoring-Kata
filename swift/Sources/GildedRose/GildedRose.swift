public class GildedRose {
    var items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public func updateQuality() {
        items.forEach { item in
            item.updateQualityAndSellInValue()
        }
    }
}
