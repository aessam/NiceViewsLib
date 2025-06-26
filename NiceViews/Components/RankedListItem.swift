import SwiftUI

struct RankedListItem: View {
    let rank: Int
    let imageUrl: String?
    let title: String
    let subtitle: String?
    let metadata: String?
    let trendDirection: TrendDirection?
    let showPlayButton: Bool
    let onTap: (() -> Void)?
    
    init(
        rank: Int,
        imageUrl: String? = nil,
        title: String,
        subtitle: String? = nil,
        metadata: String? = nil,
        trendDirection: TrendDirection? = nil,
        showPlayButton: Bool = false,
        onTap: (() -> Void)? = nil
    ) {
        self.rank = rank
        self.imageUrl = imageUrl
        self.title = title
        self.subtitle = subtitle
        self.metadata = metadata
        self.trendDirection = trendDirection
        self.showPlayButton = showPlayButton
        self.onTap = onTap
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Text("\(rank)")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.gray)
                .frame(width: 40)
            
            EnhancedListItem(
                imageUrl: imageUrl,
                title: title,
                subtitle: subtitle,
                metadata: metadata,
                showPlayButton: showPlayButton,
                trailing: trendDirection.map { direction in
                    AnyView(
                        Image(systemName: direction.iconName)
                            .foregroundColor(direction.color)
                            .font(.system(size: 14))
                    )
                },
                onTap: onTap
            )
        }
        .padding(.horizontal, 16)
    }
}

enum TrendDirection {
    case up, down, stable
    
    var iconName: String {
        switch self {
        case .up: return "arrow.up"
        case .down: return "arrow.down"
        case .stable: return "minus"
        }
    }
    
    var color: Color {
        switch self {
        case .up: return .green
        case .down: return .red
        case .stable: return .gray
        }
    }
}