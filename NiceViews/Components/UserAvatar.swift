import SwiftUI

enum AvatarSize {
    case small, medium, large
    
    var size: CGFloat {
        switch self {
        case .small: return 40
        case .medium: return 64
        case .large: return 128
        }
    }
}

struct UserAvatar: View {
    let image: String?
    let name: String
    let size: AvatarSize
    let showBorder: Bool
    
    init(
        image: String? = nil,
        name: String,
        size: AvatarSize = .medium,
        showBorder: Bool = false
    ) {
        self.image = image
        self.name = name
        self.size = size
        self.showBorder = showBorder
    }
    
    var initials: String {
        let words = name.split(separator: " ")
        let initials = words.prefix(2).compactMap { $0.first }.map { String($0) }.joined()
        return initials.uppercased()
    }
    
    var body: some View {
        ZStack {
            if let image = image, let uiImage = UIImage(systemName: image) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.size, height: size.size)
                    .clipShape(Circle())
            } else {
                Circle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(width: size.size, height: size.size)
                    .overlay(
                        Text(initials)
                            .font(.system(size: size.size * 0.4, weight: .medium))
                            .foregroundColor(.blue)
                    )
            }
        }
        .overlay(
            Circle()
                .stroke(Color.blue, lineWidth: showBorder ? 2 : 0)
        )
    }
}

struct UserAvatar_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                UserAvatar(
                    image: "person.circle.fill",
                    name: "John Doe",
                    size: .small
                )
                
                UserAvatar(
                    name: "Jane Smith",
                    size: .small
                )
            }
            
            HStack(spacing: 20) {
                UserAvatar(
                    image: "person.circle.fill",
                    name: "User Name",
                    size: .medium,
                    showBorder: true
                )
                
                UserAvatar(
                    name: "AB",
                    size: .medium
                )
            }
            
            UserAvatar(
                name: "Profile User",
                size: .large,
                showBorder: true
            )
        }
    }
}