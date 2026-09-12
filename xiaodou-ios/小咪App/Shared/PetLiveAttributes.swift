import Foundation
import ActivityKit

/// 灵动岛「小咪」实时活动的数据模型（App 与 Widget 扩展共享）
public struct PetLiveAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        public var energy: Double      // 0-100
        public var xp: Int
        public var learned: Int
        public var mood: String        // joy/sad/surprise/fear/calm/anger/disgust
        public var name: String        // 小咪
    }
    public var name: String
}
