import SwiftUI

struct PinHomeView: View {
    @State private var searchText = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 16) {
                    HStack {
                        Text("Pin Home")
                            .font(.system(size: 28, weight: .bold))
                        
                        Spacer()
                        
                        IconButton(icon: "pin.fill", backgroundColor: .blue, foregroundColor: .white) {
                            print("Pin action")
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    SearchBar(text: $searchText, placeholder: "Search pinned content")
                        .padding(.horizontal, 16)
                }
                .padding(.top, 16)
                
                if let heroImage = SampleData.heroImages.first {
                    EnhancedHeroSection(
                        imageUrl: heroImage.url,
                        title: "The Last Frontier",
                        subtitle: "Explore uncharted territories",
                        badge: "FEATURED",
                        primaryAction: { print("Explore") },
                        secondaryAction: { print("Pin") }
                    )
                }
                
                VStack(spacing: 16) {
                    SectionHeader(title: "Trending Now") {
                        print("See trending")
                    }
                    
                    HorizontalScrollSection {
                        ForEach(SampleData.albumImages, id: \.url) { image in
                            EnhancedMediaCard(
                                imageUrl: image.url,
                                title: image.description,
                                subtitle: "Trending",
                                size: .medium,
                                showPlayButton: true
                            )
                        }
                    }
                }
                
                VStack(spacing: 16) {
                    SectionHeader(title: "Quick Bites") {
                        print("See all bites")
                    }
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(Array(SampleData.eventImages.prefix(4)), id: \.url) { image in
                            VStack(alignment: .leading, spacing: 8) {
                                AsyncImageView(url: image.url, width: 180, height: 100)
                                    .cornerRadius(8)
                                
                                Text(image.description)
                                    .font(.system(size: 14, weight: .medium))
                                    .lineLimit(2)
                                
                                Text("Quick Bite")
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                Spacer(minLength: 50)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct AlbumDetailsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                if let albumImage = SampleData.albumImages.first {
                    VStack(spacing: 16) {
                        AsyncImageView(url: albumImage.url, width: 250, height: 250)
                            .cornerRadius(12)
                            .shadow(radius: 10)
                        
                        VStack(spacing: 8) {
                            Text(albumImage.description)
                                .font(.system(size: 24, weight: .bold))
                            
                            Text("The Midnight Bloom")
                                .font(.system(size: 18))
                                .foregroundColor(.secondary)
                            
                            Text("2024 • 12 songs • 45 min")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                        }
                        
                        HStack(spacing: 16) {
                            ActionButton(title: "Play", icon: "play.fill", style: .primary) {
                                print("Play album")
                            }
                            
                            ActionButton(title: "Shuffle", icon: "shuffle", style: .secondary) {
                                print("Shuffle")
                            }
                            
                            IconButton(icon: "heart", foregroundColor: .red) {
                                print("Like")
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                VStack(spacing: 0) {
                    ForEach(1...12, id: \.self) { index in
                        EnhancedListItem(
                            title: "Track \(index)",
                            subtitle: "The Midnight Bloom",
                            metadata: "\(index + 2):\(String(format: "%02d", (index * 17) % 60))",
                            showPlayButton: true,
                            trailing: AnyView(
                                IconButton(icon: "ellipsis", foregroundColor: .gray) {
                                    print("More options")
                                }
                            )
                        )
                        
                        if index < 12 {
                            Divider()
                                .padding(.leading, 84)
                        }
                    }
                }
                
                VStack(spacing: 16) {
                    SectionHeader(title: "More by The Midnight Bloom") {
                        print("See artist")
                    }
                    
                    HorizontalScrollSection {
                        ForEach(Array(SampleData.albumImages.dropFirst().prefix(3)), id: \.url) { image in
                            EnhancedMediaCard(
                                imageUrl: image.url,
                                title: image.description,
                                subtitle: "The Midnight Bloom",
                                size: .medium
                            )
                        }
                    }
                }
                
                Spacer(minLength: 50)
            }
            .padding(.vertical, 20)
        }
        .navigationTitle("Album")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct VideoPlayerView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if let videoImage = SampleData.videoThumbnails.first {
                    ZStack {
                        AsyncImageView(url: videoImage.url, width: UIScreen.main.bounds.width, height: 250)
                        
                        PlayButton(size: 64)
                    }
                }
                
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("The Making of 'Starlight'")
                            .font(.system(size: 20, weight: .bold))
                        
                        HStack {
                            Text("1.2M views • 2 days ago")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            HStack(spacing: 16) {
                                IconButton(icon: "hand.thumbsup", foregroundColor: .blue) {
                                    print("Like")
                                }
                                
                                IconButton(icon: "hand.thumbsdown", foregroundColor: .gray) {
                                    print("Dislike")
                                }
                                
                                IconButton(icon: "square.and.arrow.up", foregroundColor: .gray) {
                                    print("Share")
                                }
                            }
                        }
                        
                        HStack(spacing: 12) {
                            UserAvatar(name: "Behind Scenes", size: .medium)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Behind the Scenes")
                                    .font(.system(size: 16, weight: .medium))
                                
                                Text("234K subscribers")
                                    .font(.system(size: 14))
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            ActionButton(title: "Subscribe", style: .primary) {
                                print("Subscribe")
                            }
                        }
                        
                        Text("Go behind the scenes of our latest production and see how the magic happens. From concept to final cut, discover the creative process.")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                            .padding(.top, 8)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    
                    Divider()
                        .padding(.horizontal, 16)
                    
                    VStack(spacing: 16) {
                        SectionHeader(title: "Related Videos") {
                            print("See more videos")
                        }
                        
                        ForEach(Array(SampleData.videoThumbnails.dropFirst() + SampleData.eventImages.prefix(2)), id: \.url) { image in
                            HStack(spacing: 12) {
                                ZStack {
                                    AsyncImageView(url: image.url, width: 120, height: 68)
                                        .cornerRadius(8)
                                    
                                    PlayButton(size: 32)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(image.description)
                                        .font(.system(size: 14, weight: .medium))
                                        .lineLimit(2)
                                    
                                    Text("Channel Name")
                                        .font(.system(size: 12))
                                        .foregroundColor(.secondary)
                                    
                                    Text("\(Int.random(in: 100...999))K views • \(Int.random(in: 1...7)) days ago")
                                        .font(.system(size: 12))
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                IconButton(icon: "ellipsis", foregroundColor: .gray) {
                                    print("More options")
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                }
                
                Spacer(minLength: 50)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SearchResultsView: View {
    @State private var searchText = "starlight"
    @State private var selectedFilter = 0
    let filters = ["All", "Songs", "Artists", "Albums", "Playlists"]
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 16) {
                SearchBar(text: $searchText, placeholder: "Search")
                    .padding(.horizontal, 16)
                
                TabSelector(selectedIndex: $selectedFilter, tabs: filters)
            }
            .padding(.bottom, 16)
            
            ScrollView {
                VStack(spacing: 0) {
                    if selectedFilter == 0 || selectedFilter == 1 {
                        Section(header: 
                            HStack {
                                Text("Songs")
                                    .font(.system(size: 18, weight: .semibold))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                Spacer()
                            }
                        ) {
                            ForEach(Array(SampleData.albumImages.prefix(5)), id: \.url) { image in
                                EnhancedListItem(
                                    imageUrl: image.url,
                                    title: "\(image.description) Song",
                                    subtitle: "Artist Name",
                                    metadata: "3:42",
                                    showPlayButton: true,
                                    trailing: AnyView(
                                        IconButton(icon: "ellipsis", foregroundColor: .gray) {
                                            print("More")
                                        }
                                    )
                                )
                                
                                Divider()
                                    .padding(.leading, 84)
                            }
                        }
                    }
                    
                    if selectedFilter == 0 || selectedFilter == 3 {
                        Section(header: 
                            HStack {
                                Text("Albums")
                                    .font(.system(size: 18, weight: .semibold))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                Spacer()
                            }
                        ) {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(SampleData.albumImages, id: \.url) { image in
                                    EnhancedMediaCard(
                                        imageUrl: image.url,
                                        title: image.description,
                                        subtitle: "Album • Artist",
                                        size: .medium
                                    )
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    
                    if selectedFilter == 0 || selectedFilter == 2 {
                        Section(header: 
                            HStack {
                                Text("Artists")
                                    .font(.system(size: 18, weight: .semibold))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                Spacer()
                            }
                        ) {
                            ForEach(0..<3) { index in
                                VStack(spacing: 0) {
                                    ArtistSearchCard(
                                        artistName: "Artist \(index + 1)",
                                        monthlyListeners: "\(Int.random(in: 1...10))M monthly listeners"
                                    ) {
                                        print("Follow artist")
                                    }
                                    
                                    if index < 2 {
                                        Divider()
                                            .padding(.leading, 88)
                                    }
                                }
                            }
                        }
                    }
                }
                
                Spacer(minLength: 50)
            }
        }
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ForYouView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("For You")
                            .font(.system(size: 32, weight: .bold))
                        
                        Spacer()
                        
                        UserAvatar(name: "You", size: .medium)
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.top, 16)
                
                VStack(spacing: 16) {
                    SectionHeader(title: "Your Daily Mix") {
                        print("See all mixes")
                    }
                    
                    HorizontalScrollSection {
                        ForEach(0..<6) { index in
                            DailyMixCard(
                                mixNumber: index + 1,
                                colors: [.blue, .purple, .pink].shuffled()
                            ) {
                                print("Tapped Daily Mix \(index + 1)")
                            }
                        }
                    }
                }
                
                VStack(spacing: 16) {
                    SectionHeader(title: "Because You Listened To...") {
                        print("See recommendations")
                    }
                    
                    HorizontalScrollSection {
                        ForEach(SampleData.albumImages, id: \.url) { image in
                            EnhancedMediaCard(
                                imageUrl: image.url,
                                title: image.description,
                                subtitle: "Recommended",
                                size: .medium
                            )
                        }
                    }
                }
                
                VStack(spacing: 16) {
                    SectionHeader(title: "Your Top Genres") {
                        print("See all genres")
                    }
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(["Alternative", "Indie Rock", "Electronic", "Ambient"], id: \.self) { genre in
                            GenreTag(
                                title: genre,
                                gradient: LinearGradient(
                                    gradient: Gradient(colors: [.purple, .blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            ) {
                                print("Tapped \(genre)")
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                Spacer(minLength: 50)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct TrailerView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if let heroImage = SampleData.heroImages.first {
                    ZStack {
                        AsyncImageView(url: heroImage.url, width: UIScreen.main.bounds.width, height: 300)
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(colors: [.clear, .black.opacity(0.8)]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        
                        VStack {
                            Spacer()
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    StatusBadge(text: "TRAILER", style: .new)
                                    
                                    Text("The Lost City")
                                        .font(.system(size: 28, weight: .bold))
                                        .foregroundColor(.white)
                                    
                                    Text("Adventure • 2024")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white.opacity(0.9))
                                }
                                
                                Spacer()
                            }
                            .padding(24)
                        }
                        
                        PlayButton(size: 80)
                    }
                }
                
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("An epic adventure awaits in the mysterious Lost City of Eldoria. Join our heroes as they uncover ancient secrets and face incredible challenges in this thrilling new interactive experience.")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                        
                        HStack(spacing: 16) {
                            ActionButton(title: "Watch Trailer", icon: "play.fill", style: .primary) {
                                print("Watch trailer")
                            }
                            
                            ActionButton(title: "Add to List", icon: "plus", style: .secondary) {
                                print("Add to list")
                            }
                        }
                        
                        HStack(spacing: 24) {
                            IconButton(icon: "heart", foregroundColor: .red) {
                                print("Like")
                            }
                            
                            IconButton(icon: "square.and.arrow.up", foregroundColor: .blue) {
                                print("Share")
                            }
                            
                            IconButton(icon: "star", foregroundColor: .yellow) {
                                print("Rate")
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                    
                    VStack(spacing: 16) {
                        SectionHeader(title: "Cast & Crew") {
                            print("See full cast")
                        }
                        
                        HorizontalScrollSection {
                            ForEach(0..<5) { index in
                                VStack(spacing: 8) {
                                    UserAvatar(name: "Actor \(index + 1)", size: .large)
                                    
                                    VStack(spacing: 2) {
                                        Text("Actor \(index + 1)")
                                            .font(.system(size: 14, weight: .medium))
                                        
                                        Text("Character Name")
                                            .font(.system(size: 12))
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .frame(width: 100)
                            }
                        }
                    }
                    
                    VStack(spacing: 16) {
                        SectionHeader(title: "Related Content") {
                            print("See more")
                        }
                        
                        HorizontalScrollSection {
                            ForEach(SampleData.eventImages, id: \.url) { image in
                                EnhancedMediaCard(
                                    imageUrl: image.url,
                                    title: "Related \(image.description)",
                                    subtitle: "Adventure",
                                    size: .medium,
                                    showPlayButton: true
                                )
                            }
                        }
                    }
                }
                
                Spacer(minLength: 50)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AdditionalViews_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PinHomeView()
        }
    }
}