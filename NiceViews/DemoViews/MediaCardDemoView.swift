import SwiftUI

struct AsyncImageView: View {
    let url: String
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        // Check if it's a local asset name or URL
        if url.hasPrefix("http") {
            AsyncImage(url: URL(string: url)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .clipped()
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: width, height: height)
                    .overlay(
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    )
            }
        } else {
            // Use local asset
            Image(url)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .clipped()
        }
    }
}

struct EnhancedMediaCard: View {
    let imageUrl: String
    let title: String
    let subtitle: String?
    let size: MediaCardSize
    let showPlayButton: Bool
    let onTap: (() -> Void)?
    
    init(
        imageUrl: String,
        title: String,
        subtitle: String? = nil,
        size: MediaCardSize = .medium,
        showPlayButton: Bool = false,
        onTap: (() -> Void)? = nil
    ) {
        self.imageUrl = imageUrl
        self.title = title
        self.subtitle = subtitle
        self.size = size
        self.showPlayButton = showPlayButton
        self.onTap = onTap
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .bottomTrailing) {
                AsyncImageView(
                    url: imageUrl,
                    width: size.width,
                    height: size.width
                )
                .cornerRadius(8)
                
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

struct MediaCardDemoView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Small Size")
                        .font(.headline)
                        .padding(.horizontal, 16)
                    
                    HorizontalScrollSection {
                        ForEach(SampleData.albumImages, id: \.url) { image in
                            EnhancedMediaCard(
                                imageUrl: image.url,
                                title: image.description,
                                subtitle: "Sample Artist",
                                size: .small,
                                showPlayButton: false
                            )
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Medium Size with Play Button")
                        .font(.headline)
                        .padding(.horizontal, 16)
                    
                    HorizontalScrollSection {
                        ForEach(SampleData.eventImages, id: \.url) { image in
                            EnhancedMediaCard(
                                imageUrl: image.url,
                                title: image.description,
                                subtitle: "Live Event",
                                size: .medium,
                                showPlayButton: true
                            )
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Large Size")
                        .font(.headline)
                        .padding(.horizontal, 16)
                    
                    HorizontalScrollSection {
                        ForEach(SampleData.videoThumbnails, id: \.url) { image in
                            EnhancedMediaCard(
                                imageUrl: image.url,
                                title: image.description,
                                subtitle: "Behind the Scenes",
                                size: .large,
                                showPlayButton: true
                            )
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Grid Layout")
                        .font(.headline)
                        .padding(.horizontal, 16)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(Array(SampleData.albumImages.prefix(4)), id: \.url) { image in
                            EnhancedMediaCard(
                                imageUrl: image.url,
                                title: image.description,
                                subtitle: "Album",
                                size: .medium
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .padding(.vertical, 20)
        }
        .navigationTitle("Media Cards")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct MediaCardDemoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MediaCardDemoView()
        }
    }
}
