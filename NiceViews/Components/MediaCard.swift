import SwiftUI

enum MediaCardSize {
    case small, medium, large
    
    var width: CGFloat {
        switch self {
        case .small: return 150
        case .medium: return 180
        case .large: return 280
        }
    }
}

struct MediaCard: View {
    let image: String
    let title: String
    let subtitle: String?
    let size: MediaCardSize
    let showPlayButton: Bool
    let onTap: (() -> Void)?
    
    init(
        image: String,
        title: String,
        subtitle: String? = nil,
        size: MediaCardSize = .medium,
        showPlayButton: Bool = false,
        onTap: (() -> Void)? = nil
    ) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.size = size
        self.showPlayButton = showPlayButton
        self.onTap = onTap
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .bottomTrailing) {
                if let uiImage = UIImage(systemName: image) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.width)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: size.width, height: size.width)
                        .overlay(
                            Image(systemName: "photo")
                                .font(.system(size: 40))
                                .foregroundColor(.gray.opacity(0.5))
                        )
                }
                
                if showPlayButton {
                    PlayButton(size: 44)
                        .padding(8)
                }
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .lineLimit(1)
                    .foregroundColor(.primary)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.system(size: 12))
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                }
            }
            .frame(width: size.width, alignment: .leading)
        }
        .onTapGesture {
            onTap?()
        }
    }
}

struct PlayButton: View {
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.black.opacity(0.7))
                .frame(width: size, height: size)
            
            Image(systemName: "play.fill")
                .font(.system(size: size * 0.4))
                .foregroundColor(.white)
        }
    }
}

struct MediaCard_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack(spacing: 16) {
                    MediaCard(
                        image: "music.note",
                        title: "Album Title",
                        subtitle: "Artist Name",
                        size: .small
                    )
                    
                    MediaCard(
                        image: "tv",
                        title: "Video Title",
                        subtitle: "Channel Name",
                        size: .small,
                        showPlayButton: true
                    )
                }
                
                HStack(spacing: 16) {
                    MediaCard(
                        image: "book",
                        title: "Book Title",
                        subtitle: "Author Name",
                        size: .medium
                    )
                    
                    MediaCard(
                        image: "music.mic",
                        title: "Podcast Episode",
                        subtitle: "Podcast Name",
                        size: .medium,
                        showPlayButton: true
                    )
                }
            }
            .padding()
        }
    }
}