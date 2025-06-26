import SwiftUI

struct QuickPickCard: View {
    let imageUrl: String?
    let title: String
    let backgroundColor: Color
    let size: QuickPickCardSize
    let onTap: (() -> Void)?
    
    init(
        imageUrl: String? = nil,
        title: String,
        backgroundColor: Color = Color.gray.opacity(0.1),
        size: QuickPickCardSize = .medium,
        onTap: (() -> Void)? = nil
    ) {
        self.imageUrl = imageUrl
        self.title = title
        self.backgroundColor = backgroundColor
        self.size = size
        self.onTap = onTap
    }
    
    var body: some View {
        HStack(spacing: 12) {
            if let imageUrl = imageUrl {
                AsyncImageView(url: imageUrl, width: size.imageSize, height: size.imageSize)
                    .cornerRadius(4)
            } else {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: size.imageSize, height: size.imageSize)
                    .overlay(
                        Image(systemName: "music.note")
                            .font(.system(size: size.imageSize * 0.4))
                            .foregroundColor(.gray.opacity(0.6))
                    )
            }
            
            Text(title)
                .font(.system(size: size.titleSize, weight: .medium))
                .lineLimit(2)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding(size.padding)
        .background(backgroundColor)
        .cornerRadius(8)
        .onTapGesture {
            onTap?()
        }
    }
}

enum QuickPickCardSize {
    case small, medium, large
    
    var imageSize: CGFloat {
        switch self {
        case .small: return 40
        case .medium: return 56
        case .large: return 72
        }
    }
    
    var titleSize: CGFloat {
        switch self {
        case .small: return 12
        case .medium: return 14
        case .large: return 16
        }
    }
    
    var padding: CGFloat {
        switch self {
        case .small: return 6
        case .medium: return 8
        case .large: return 10
        }
    }
}