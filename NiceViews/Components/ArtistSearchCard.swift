import SwiftUI

struct ArtistSearchCard: View {
    let artistName: String
    let monthlyListeners: String
    let imageUrl: String?
    let isFollowing: Bool
    let onFollow: (() -> Void)?
    
    init(
        artistName: String,
        monthlyListeners: String,
        imageUrl: String? = nil,
        isFollowing: Bool = false,
        onFollow: (() -> Void)? = nil
    ) {
        self.artistName = artistName
        self.monthlyListeners = monthlyListeners
        self.imageUrl = imageUrl
        self.isFollowing = isFollowing
        self.onFollow = onFollow
    }
    
    var body: some View {
        HStack(spacing: 12) {
            UserAvatar(
                image: imageUrl,
                name: artistName,
                size: .medium
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(artistName)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                
                Text(monthlyListeners)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if let onFollow = onFollow {
                ActionButton(
                    title: isFollowing ? "Following" : "Follow",
                    style: isFollowing ? .secondary : .primary,
                    action: onFollow
                )
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}