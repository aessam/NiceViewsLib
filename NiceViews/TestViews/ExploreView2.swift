import SwiftUI

struct ExploreView2: View {
    @State private var searchText = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 16) {
                    HStack {
                        Text("Discover")
                            .font(.system(size: 32, weight: .bold))
                        
                        Spacer()
                        
                        IconButton(icon: "bell", backgroundColor: .gray.opacity(0.1)) {
                            print("Notifications")
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    SearchBar(text: $searchText, placeholder: "Search for anything")
                        .padding(.horizontal, 16)
                }
                .padding(.top, 16)
                
                if let heroImage = SampleData.heroImages.first {
                    EnhancedHeroSection(
                        imageUrl: heroImage.url,
                        title: "Interactive Story",
                        subtitle: "The Lost City of Eldoria - Embark on an adventure",
                        badge: "INTERACTIVE",
                        primaryAction: { print("Start Story") },
                        secondaryAction: { print("Learn More") }
                    )
                }
                
                VStack(spacing: 16) {
                    SectionHeader(title: "Live Events") {
                        print("See all live events")
                    }
                    
                    ForEach(SampleData.eventImages, id: \.url) { image in
                        LiveEventCard(
                            imageUrl: image.url,
                            title: image.description,
                            subtitle: "Live Event",
                            status: .live
                        ) {
                            print("Join event")
                        }
                    }
                }
                
                VStack(spacing: 16) {
                    SectionHeader(title: "Behind the Scenes") {
                        print("See all behind the scenes")
                    }
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(SampleData.videoThumbnails, id: \.url) { image in
                            VideoThumbnailCard(
                                imageUrl: image.url,
                                title: image.description,
                                subtitle: "Behind the Scenes",
                                showPlayButton: true
                            ) {
                                print("Play video: \(image.description)")
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                VStack(spacing: 16) {
                    SectionHeader(title: "User Showcase") {
                        print("See all user content")
                    }
                    
                    HorizontalScrollSection {
                        ForEach(Array(SampleData.albumImages.prefix(6)), id: \.url) { image in
                            UserContentCard(
                                imageUrl: image.url,
                                title: "User Creation",
                                username: "@user\(Int.random(in: 1...999))"
                            ) {
                                print("Tapped user content")
                            }
                        }
                    }
                }
                
                Spacer(minLength: 50)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct ExploreView2_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView2()
    }
}