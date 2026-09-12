import WidgetKit
import SwiftUI

/// 小咪的像素头像（从素材加载，保持像素风格）
struct PetPixelView: View {
    var mood: String
    var size: CGFloat

    private var frameName: String {
        switch mood {
        case "sad": return "pet-sad"
        case "surprise": return "pet-surprise"
        case "fear": return "pet-fear"
        case "calm": return "pet-calm"
        case "anger": return "pet-anger"
        case "disgust": return "pet-disgust"
        default: return "pet-happy"
        }
    }

    var body: some View {
        Image(frameName)
            .resizable()
            .interpolation(.none)
            .scaledToFit()
            .frame(width: size, height: size)
    }
}

struct PetLiveActivityView: View {
    let context: ActivityViewContext<PetLiveAttributes>

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 8) {
                PetPixelView(mood: context.state.mood, size: 36)
                VStack(alignment: .leading, spacing: 1) {
                    Text(context.state.name)
                        .font(.system(size: 13, weight: .bold))
                    Text(moodText(context.state.mood))
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Text("XP \(context.state.xp.formatted())")
                    .font(.system(size: 11, weight: .medium, design: .rounded))
                    .foregroundStyle(.secondary)
            }
            // 能量条
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color.black.opacity(0.12))
                    Capsule()
                        .fill(energyColor(context.state.energy))
                        .frame(width: geo.size.width * CGFloat(context.state.energy) / 100)
                }
            }
            .frame(height: 6)
        }
        .padding(2)
    }

    private func moodText(_ m: String) -> String {
        switch m {
        case "sad": return "有点难过"
        case "surprise": return "好惊讶"
        case "fear": return "有点怕怕"
        case "calm": return "安安静静"
        case "anger": return "在闹脾气"
        case "disgust": return "嫌弃脸"
        default: return "开心着呢"
        }
    }

    private func energyColor(_ e: Double) -> Color {
        e > 60 ? .green : (e > 30 ? .orange : .red)
    }
}

struct PetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PetLiveAttributes.self) { context in
            // 锁屏 / 灵动岛展开
            PetLiveActivityView(context: context)
                .padding(14)
                .activityBackgroundTint(Color(red: 0.984, green: 0.965, blue: 0.933))
        } dynamicIsland: { context in
            DynamicIsland {
                // 展开视图
                DynamicIslandExpandedRegion(.leading) {
                    PetPixelView(mood: context.state.mood, size: 30)
                }
                DynamicIslandExpandedRegion(.center) {
                    VStack(spacing: 2) {
                        Text(context.state.name)
                            .font(.system(size: 12, weight: .bold))
                        Text("\(Int(context.state.energy))% 能量 · \(moodText(context.state.mood))")
                            .font(.system(size: 10))
                            .foregroundStyle(.secondary)
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    ProgressView(value: context.state.energy, total: 100)
                        .tint(energyColor(context.state.energy))
                }
            } compactLeading: {
                PetPixelView(mood: context.state.mood, size: 22)
            } compactTrailing: {
                Text("\(Int(context.state.energy))%")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
            } minimal: {
                PetPixelView(mood: context.state.mood, size: 20)
            }
        }
    }

    private func moodText(_ m: String) -> String {
        switch m {
        case "sad": return "难过"
        case "surprise": return "惊讶"
        case "fear": return "害怕"
        case "calm": return "平静"
        case "anger": return "生气"
        case "disgust": return "嫌弃"
        default: return "开心"
        }
    }

    private func energyColor(_ e: Double) -> Color {
        e > 60 ? .green : (e > 30 ? .orange : .red)
    }
}
