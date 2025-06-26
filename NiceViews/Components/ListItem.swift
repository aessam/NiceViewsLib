import SwiftUI

struct ListItem: View {
    let image: String
    let title: String
    let subtitle: String?
    let metadata: String?
    let showPlayButton: Bool
    let trailing: AnyView?
    let onTap: (() -> Void)?
    
    init(
        image: String,
        title: String,
        subtitle: String? = nil,
        metadata: String? = nil,
        showPlayButton: Bool = false,
        trailing: AnyView? = nil,
        onTap: (() -> Void)? = nil
    ) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.metadata = metadata
        self.showPlayButton = showPlayButton
        self.trailing = trailing
        self.onTap = onTap
    }
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                if let uiImage = UIImage(systemName: image) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 56, height: 56)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 56, height: 56)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(.gray.opacity(0.5))
                        )
                }
                
                if showPlayButton {
                    PlayButton(size: 32)
                }
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .lineLimit(1)
                    .foregroundColor(.primary)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.system(size: 14))
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                }
                
                if let metadata = metadata {
                    Text(metadata)
                        .font(.system(size: 12))
                        .lineLimit(1)
                        .foregroundColor(.secondary.opacity(0.8))
                }
            }
            
            Spacer()
            
            if let trailing = trailing {
                trailing
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .contentShape(Rectangle())
        .onTapGesture {
            onTap?()
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            ListItem(
                image: "music.note",
                title: "Song Title",
                subtitle: "Artist Name",
                metadata: "3:42"
            )
            
            Divider()
            
            ListItem(
                image: "play.circle.fill",
                title: "Video Title",
                subtitle: "Channel Name",
                metadata: "1.2M views",
                showPlayButton: true
            )
            
            Divider()
            
            ListItem(
                image: "book.fill",
                title: "Book Title",
                subtitle: "Author Name",
                trailing: AnyView(
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                )
            )
            
            Divider()
            
            ListItem(
                image: "person.circle.fill",
                title: "User Name",
                subtitle: "Online",
                trailing: AnyView(
                    Button(action: {}) {
                        Text("Follow")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 6)
                            .background(Color.blue)
                            .cornerRadius(16)
                    }
                )
            )
        }
    }
}