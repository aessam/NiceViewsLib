import SwiftUI

struct GenreCircle: View {
    let title: String
    let iconName: String
    let gradient: LinearGradient
    let size: GenreCircleSize
    let onTap: (() -> Void)?
    
    init(
        title: String,
        iconName: String = "music.note",
        gradient: LinearGradient = LinearGradient(
            gradient: Gradient(colors: [.blue, .purple]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ),
        size: GenreCircleSize = .medium,
        onTap: (() -> Void)? = nil
    ) {
        self.title = title
        self.iconName = iconName
        self.gradient = gradient
        self.size = size
        self.onTap = onTap
    }
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(gradient)
                    .frame(width: size.diameter, height: size.diameter)
                
                Image(systemName: iconName)
                    .font(.system(size: size.iconSize))
                    .foregroundColor(.white)
            }
            
            Text(title)
                .font(.system(size: size.titleSize, weight: .medium))
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(width: size.diameter)
        .onTapGesture {
            onTap?()
        }
    }
}

enum GenreCircleSize {
    case small, medium, large
    
    var diameter: CGFloat {
        switch self {
        case .small: return 80
        case .medium: return 120
        case .large: return 160
        }
    }
    
    var iconSize: CGFloat {
        switch self {
        case .small: return 24
        case .medium: return 40
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
}