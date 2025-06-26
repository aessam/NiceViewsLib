import SwiftUI

struct VideoThumbnailCard: View {
    let imageUrl: String
    let title: String
    let subtitle: String
    let showPlayButton: Bool
    let size: VideoThumbnailSize
    let onTap: (() -> Void)?
    
    init(
        imageUrl: String,
        title: String,
        subtitle: String = "Video",
        showPlayButton: Bool = true,
        size: VideoThumbnailSize = .medium,
        onTap: (() -> Void)? = nil
    ) {
        self.imageUrl = imageUrl
        self.title = title
        self.subtitle = subtitle
        self.showPlayButton = showPlayButton
        self.size = size
        self.onTap = onTap
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .center) {
                AsyncImageView(url: imageUrl, width: size.width, height: size.height)
                    .cornerRadius(8)
                
                if showPlayButton {
                    PlayButton(size: size.playButtonSize)
                }
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: size.titleSize, weight: .medium))
                    .lineLimit(2)
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

enum VideoThumbnailSize {
    case small, medium, large
    
    var width: CGFloat {
        switch self {
        case .small: return 120
        case .medium: return 180
        case .large: return 240
        }
    }
    
    var height: CGFloat {
        switch self {
        case .small: return 68  // 16:9 aspect ratio
        case .medium: return 120
        case .large: return 135
        }
    }
    
    var playButtonSize: CGFloat {
        switch self {
        case .small: return 32
        case .medium: return 44
        case .large: return 56
        }
    }
    
    var titleSize: CGFloat {
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