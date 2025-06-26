import SwiftUI

struct PlaylistCard: View {
    let title: String
    let songCount: Int
    let gradient: LinearGradient
    let size: PlaylistCardSize
    let iconName: String
    let onTap: (() -> Void)?
    
    init(
        title: String,
        songCount: Int,
        gradient: LinearGradient = LinearGradient(
            gradient: Gradient(colors: [.blue, .purple]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ),
        size: PlaylistCardSize = .medium,
        iconName: String = "music.note.list",
        onTap: (() -> Void)? = nil
    ) {
        self.title = title
        self.songCount = songCount
        self.gradient = gradient
        self.size = size
        self.iconName = iconName
        self.onTap = onTap
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(gradient)
                    .frame(width: size.width, height: size.height)
                
                VStack {
                    Image(systemName: iconName)
                        .font(.system(size: size.iconSize))
                        .foregroundColor(.white)
                    
                    Text(title)
                        .font(.system(size: size.titleSize, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                }
            }
            
            Text("\(songCount) songs")
                .font(.system(size: size.subtitleSize))
                .foregroundColor(.secondary)
        }
        .frame(width: size.width)
        .onTapGesture {
            onTap?()
        }
    }
}

enum PlaylistCardSize {
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
        case .small: return 30
        case .medium: return 40
        case .large: return 50
        }
    }
    
    var titleSize: CGFloat {
        switch self {
        case .small: return 12
        case .medium: return 16
        case .large: return 18
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