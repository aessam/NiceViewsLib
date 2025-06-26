import SwiftUI

struct UserContentCard: View {
    let imageUrl: String
    let title: String
    let username: String
    let size: UserContentCardSize
    let onTap: (() -> Void)?
    
    init(
        imageUrl: String,
        title: String = "User Creation",
        username: String,
        size: UserContentCardSize = .medium,
        onTap: (() -> Void)? = nil
    ) {
        self.imageUrl = imageUrl
        self.title = title
        self.username = username
        self.size = size
        self.onTap = onTap
    }
    
    var body: some View {
        VStack(spacing: 8) {
            AsyncImageView(url: imageUrl, width: size.width, height: size.height)
                .cornerRadius(12)
            
            VStack(spacing: 4) {
                Text(title)
                    .font(.system(size: size.titleSize, weight: .medium))
                    .lineLimit(1)
                    .foregroundColor(.primary)
                
                Text("by \(username)")
                    .font(.system(size: size.subtitleSize))
                    .foregroundColor(.secondary)
            }
            .frame(width: size.width)
        }
        .onTapGesture {
            onTap?()
        }
    }
}

enum UserContentCardSize {
    case small, medium, large
    
    var width: CGFloat {
        switch self {
        case .small: return 100
        case .medium: return 140
        case .large: return 180
        }
    }
    
    var height: CGFloat {
        switch self {
        case .small: return 100
        case .medium: return 140
        case .large: return 180
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