import SwiftUI

struct LiveEventCard: View {
    let imageUrl: String
    let title: String
    let subtitle: String
    let status: LiveEventStatus
    let onJoin: (() -> Void)?
    
    init(
        imageUrl: String,
        title: String,
        subtitle: String = "Live Event",
        status: LiveEventStatus = .live,
        onJoin: (() -> Void)? = nil
    ) {
        self.imageUrl = imageUrl
        self.title = title
        self.subtitle = subtitle
        self.status = status
        self.onJoin = onJoin
    }
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImageView(url: imageUrl, width: 80, height: 80)
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(1)
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                
                HStack {
                    StatusBadge(text: status.displayText, style: status.badgeStyle)
                    Text(status.timeText)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            if let onJoin = onJoin {
                ActionButton(title: "Join", style: .primary, action: onJoin)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

enum LiveEventStatus {
    case live
    case upcoming
    case ended
    
    var displayText: String {
        switch self {
        case .live: return "LIVE"
        case .upcoming: return "UPCOMING"
        case .ended: return "ENDED"
        }
    }
    
    var badgeStyle: BadgeStyle {
        switch self {
        case .live: return .live
        case .upcoming: return .new
        case .ended: return .inactive
        }
    }
    
    var timeText: String {
        switch self {
        case .live: return "Now live"
        case .upcoming: return "Starting soon"
        case .ended: return "Event ended"
        }
    }
}