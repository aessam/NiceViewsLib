import SwiftUI

struct CategoryCard: View {
    let title: String
    let iconName: String
    let backgroundColor: Color
    let size: CategoryCardSize
    let onTap: (() -> Void)?
    
    init(
        title: String,
        iconName: String,
        backgroundColor: Color,
        size: CategoryCardSize = .medium,
        onTap: (() -> Void)? = nil
    ) {
        self.title = title
        self.iconName = iconName
        self.backgroundColor = backgroundColor
        self.size = size
        self.onTap = onTap
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 8)
                .fill(backgroundColor)
                .frame(height: size.height)
            
            HStack {
                Text(title)
                    .font(.system(size: size.titleSize, weight: .bold))
                    .foregroundColor(.white)
                    .padding(12)
                
                Spacer()
                
                Image(systemName: iconName)
                    .font(.system(size: size.iconSize))
                    .foregroundColor(.white.opacity(0.8))
                    .rotationEffect(.degrees(25))
                    .padding(12)
            }
        }
        .onTapGesture {
            onTap?()
        }
    }
}

enum CategoryCardSize {
    case small, medium, large
    
    var height: CGFloat {
        switch self {
        case .small: return 80
        case .medium: return 100
        case .large: return 120
        }
    }
    
    var titleSize: CGFloat {
        switch self {
        case .small: return 16
        case .medium: return 18
        case .large: return 20
        }
    }
    
    var iconSize: CGFloat {
        switch self {
        case .small: return 20
        case .medium: return 24
        case .large: return 28
        }
    }
}