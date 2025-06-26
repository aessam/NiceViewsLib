import SwiftUI

struct HomeView2: View {
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            ScrollView {
            VStack(spacing: 0) {
                VStack(spacing: 16) {
                    HStack {
                        Text("Welcome back!")
                            .font(.system(size: 32, weight: .bold))
                        
                        Spacer()
                        
                        UserAvatar(name: "User", size: .medium)
                    }
                    .padding(.horizontal, 16)
                    
                    SearchBar(text: $searchText, placeholder: "What do you want to listen to?")
                        .padding(.horizontal, 16)
                }
                .padding(.top, 16)
                .padding(.bottom, 24)
                
                EnhancedHeroSection(
                    imageUrl: SampleData.albumImages.first?.url ?? "",
                    title: "Today's Hits",
                    subtitle: "The biggest songs right now",
                    badge: "TRENDING",
                    primaryAction: { print("Play") },
                    secondaryAction: { print("Shuffle") }
                )
                .padding(.bottom, 24)
                
                VStack(spacing: 20) {
                    SectionHeader(title: "Quick Picks") {
                        print("See all quick picks")
                    }
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(Array(SampleData.albumImages.prefix(6)), id: \.url) { image in
                            QuickPickCard(
                                imageUrl: image.url,
                                title: image.description
                            ) {
                                print("Tapped \(image.description)")
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 24)
                
                VStack(spacing: 16) {
                    SectionHeader(title: "Made for You") {
                        print("See all made for you")
                    }
                    
                    HorizontalScrollSection {
                        ForEach(Array(SampleData.albumImages.prefix(5)), id: \.url) { image in
                            EnhancedMediaCard(
                                imageUrl: image.url,
                                title: "Daily Mix",
                                subtitle: "Based on your taste",
                                size: .medium
                            )
                        }
                    }
                }
                .padding(.bottom, 24)
                
                VStack(spacing: 16) {
                    SectionHeader(title: "Recently Played") {
                        print("See all recently played")
                    }
                    
                    HorizontalScrollSection {
                        ForEach(SampleData.eventImages, id: \.url) { image in
                            EnhancedMediaCard(
                                imageUrl: image.url,
                                title: image.description,
                                subtitle: "Event",
                                size: .small,
                                showPlayButton: true
                            )
                        }
                    }
                }
                
                Spacer(minLength: 100)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        
        // Floating back button
        VStack {
            HStack {
                Spacer()
                BackToMainButton()
                    .padding()
            }
            Spacer()
        }
        }
    }
}

struct HomeView2_Previews: PreviewProvider {
    static var previews: some View {
        HomeView2()
    }
}