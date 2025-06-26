import SwiftUI

struct DailyMixCard: View {
    let mixNumber: Int
    let title: String?
    let subtitle: String
    let colors: [Color]
    let size: DailyMixCardSize
    let iconName: String
    let onTap: (() -> Void)?
    
    init(
        mixNumber: Int,
        title: String? = nil,
        subtitle: String = "Made for you",
        colors: [Color] = [.blue, .purple, .pink],
        size: DailyMixCardSize = .medium,
        iconName: String = "music.note",
        onTap: (() -> Void)? = nil
    ) {
        self.mixNumber = mixNumber
        self.title = title
        self.subtitle = subtitle
        self.colors = colors
        self.size = size
        self.iconName = iconName
        self.onTap = onTap
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                LinearGradient(
                    colors: colors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(width: size.width, height: size.height)
                .cornerRadius(8)
                
                VStack {
                    Image(systemName: iconName)
                        .font(.system(size: size.iconSize))
                        .foregroundColor(.white)
                    
                    Text("Daily Mix \(mixNumber)")
                        .font(.system(size: size.titleSize, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title ?? "Daily Mix \(mixNumber)")
                    .font(.system(size: size.labelSize, weight: .medium))
                    .lineLimit(1)
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.system(size: size.subtitleSize))
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: size.width)
        .onTapGesture {
            onTap?()
        }
    }
}

enum DailyMixCardSize {
    case small, medium, large
    
    var width: CGFloat {
        switch self {
        case .small: return 120
        case .medium: return 150
        case .large: return 180
        }
    }
    
    var height: CGFloat {
        switch self {
        case .small: return 120
        case .medium: return 150
        case .large: return 180
        }
    }
    
    var iconSize: CGFloat {
        switch self {
        case .small: return 24
        case .medium: return 30
        case .large: return 36
        }
    }
    
    var titleSize: CGFloat {
        switch self {
        case .small: return 10
        case .medium: return 12
        case .large: return 14
        }
    }
    
    var labelSize: CGFloat {
        switch self {
        case .small: return 12
        case .medium: return 14
        case .large: return 16
        }
    }
    
    var subtitleSize: CGFloat {
        switch self {
        case .small: return 10
        case .medium: return 12
        case .large: return 14
        }
    }
}