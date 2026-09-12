import Foundation
import ActivityKit

/// 接收 H5 上报，驱动灵动岛上的小咪（启动 / 更新实时活动）
@available(iOS 16.1, *)
final class PetLiveBridge {
    static let shared = PetLiveBridge()
    private init() {}

    func handle(payload: [String: Any]) {
        let name  = payload["name"] as? String ?? "小咪"
        let mood  = payload["mood"] as? String ?? "joy"
        let energy = (payload["energy"] as? NSNumber)?.doubleValue ?? 0
        let xp     = (payload["xp"] as? NSNumber)?.intValue ?? 0
        let learned = (payload["learned"] as? NSNumber)?.intValue ?? 0

        let state = PetLiveAttributes.ContentState(
            energy: min(max(energy, 0), 100),
            xp: xp, learned: learned, mood: mood, name: name
        )

        if let active = Activity<PetLiveAttributes>.activities.first {
            Task {
                await active.update(using: state)
            }
        } else {
            let attributes = PetLiveAttributes(name: name)
            do {
                _ = try Activity<PetLiveAttributes>.request(
                    attributes: attributes,
                    contentState: state,
                    pushType: nil
                )
            } catch {
                // 首次请求失败（如用户关闭了实时活动权限）静默忽略
                print("LiveActivity start failed: \(error)")
            }
        }
    }
}
