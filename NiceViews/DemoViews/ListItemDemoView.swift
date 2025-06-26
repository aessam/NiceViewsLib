import SwiftUI

struct EnhancedListItem: View {
    let imageUrl: String?
    let title: String
    let subtitle: String?
    let metadata: String?
    let showPlayButton: Bool
    let trailing: AnyView?
    let onTap: (() -> Void)?
    
    init(
        imageUrl: String? = nil,
        title: String,
        subtitle: String? = nil,
        metadata: String? = nil,
        showPlayButton: Bool = false,
        trailing: AnyView? = nil,
        onTap: (() -> Void)? = nil
    ) {
        self.imageUrl = imageUrl
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
                if let imageUrl = imageUrl {
                    AsyncImageView(url: imageUrl, width: 56, height: 56)
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

struct ListItemDemoView: View {
    var body: some View {
        List {
            Section(header: Text("Music Style")) {
                ForEach(Array(SampleData.albumImages.prefix(5)), id: \.url) { image in
                    EnhancedListItem(
                        imageUrl: image.url,
                        title: image.description,
                        subtitle: "Artist Name",
                        metadata: "3:42",
                        showPlayButton: true
                    )
                }
            }
            
            Section(header: Text("Video Style")) {
                ForEach(SampleData.videoThumbnails, id: \.url) { image in
                    EnhancedListItem(
                        imageUrl: image.url,
                        title: image.description,
                        subtitle: "Behind the Scenes",
                        metadata: "12M views • 2 days ago",
                        trailing: AnyView(
                            Image(systemName: "ellipsis")
                                .foregroundColor(.gray)
                        )
                    )
                }
            }
            
            Section(header: Text("Event Style")) {
                ForEach(SampleData.eventImages, id: \.url) { image in
                    EnhancedListItem(
                        imageUrl: image.url,
                        title: image.description,
                        subtitle: "Live Event",
                        metadata: "Tomorrow • 7:00 PM",
                        trailing: AnyView(
                            Button(action: {}) {
                                Text("Join")
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
            
            Section(header: Text("Settings Style")) {
                EnhancedListItem(
                    title: "Account Settings",
                    subtitle: "Privacy, security, and more",
                    trailing: AnyView(
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    )
                )
                
                EnhancedListItem(
                    title: "Notifications",
                    subtitle: "Push notifications, sounds",
                    trailing: AnyView(
                        Toggle("", isOn: .constant(true))
                    )
                )
                
                EnhancedListItem(
                    title: "Help & Support",
                    subtitle: "Get help with your account",
                    trailing: AnyView(
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    )
                )
            }
        }
        .navigationTitle("List Items")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ListItemDemoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListItemDemoView()
        }
    }
}