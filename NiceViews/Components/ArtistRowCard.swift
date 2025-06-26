import SwiftUI

struct ArtistRowCard: View {
    let artistName: String
    let songCount: Int
    let imageUrl: String?
    let showChevron: Bool
    let onTap: (() -> Void)?
    
    init(
        artistName: String,
        songCount: Int,
        imageUrl: String? = nil,
        showChevron: Bool = true,
        onTap: (() -> Void)? = nil
    ) {
        self.artistName = artistName
        self.songCount = songCount
        self.imageUrl = imageUrl
        self.showChevron = showChevron
        self.onTap = onTap
    }
    
    var body: some View {
        HStack(spacing: 12) {
            UserAvatar(
                image: imageUrl ?? "person.circle.fill",
                name: artistName,
                size: .medium
            )
            
            VStack(alignment: .leading, spacing: 2) {
                Text(artistName)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                
                Text("\(songCount) songs")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if showChevron {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .contentShape(Rectangle())
        .onTapGesture {
            onTap?()
        }
    }
}