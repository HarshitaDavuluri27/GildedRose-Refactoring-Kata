public class Item {
    public var name: String
    public var sellIn: Int
    public var quality: Int

    public init(name: String, sellIn: Int, quality: Int) {
        self.name = name
        self.sellIn = sellIn
        self.quality = quality
    }
}

extension Item: CustomStringConvertible {
    public var description: String {
        name + ", " + String(sellIn) + ", " + String(quality)
    }
}

extension Item {
    public enum ItemType {
        case normal
        case sulfuras
        case agedBrie
        case backStagePass
        case conjured
    }
    
    public var type: ItemType {
        switch name {
        case "Aged Brie": return .agedBrie
        case let name where name.hasPrefix("Sulfuras"): return .sulfuras
        case let name where name.hasPrefix("Backstage passes"): return .backStagePass
        case let name where name.hasPrefix("Conjured"): return .conjured
        default: return .normal
        }
    }
}

extension Item {
    public func updateQualityAndSellInValue() {
        switch type {
        case .normal:
            quality = updateQuality(quality: sellIn <= 0 ? quality - 2 : quality - 1)
        case .sulfuras:
            quality = 80
        case .agedBrie:
            quality = updateQuality(quality: sellIn <= 0 ? quality + 2 : quality + 1)
        case .backStagePass:
            let newQuality = computeBackStageQuality(for: quality)
            quality = updateQuality(quality: newQuality)
        case .conjured:
            quality = updateQuality(quality: sellIn <= 0 ? quality - 4 : quality - 2)
        }
        
        if type != .sulfuras {
            sellIn = sellIn - 1
        }
    }
    
    private func computeBackStageQuality(for quality: Int) -> Int {
        let newQuality: Int
        if sellIn <= 0 {
            newQuality = 0
        } else if sellIn < 6 {
            newQuality = quality + 3
        } else if sellIn < 11 {
            newQuality = quality + 2
        } else {
            newQuality = quality + 1
        }
        return newQuality
    }
    
    private func updateQuality(quality: Int) -> Int {
        return min(50, max(quality, 0))
    }
}
