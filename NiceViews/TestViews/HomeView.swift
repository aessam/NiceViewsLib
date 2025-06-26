import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Good Morning")
                            .font(.system(size: 28, weight: .bold))
                            .padding(.horizontal, 16)
                        
                        SearchBar(text: $searchText, placeholder: "Search music, artists, albums")
                            .padding(.horizontal, 16)
                    }
                    .padding(.top, 16)
                    
                    HeroSection(
                        image: "music.note",
                        title: "Today's Top Hits",
                        subtitle: "The hottest tracks right now",
                        badge: "NEW",
                        primaryAction: { print("Play") },
                        secondaryAction: { print("Add") }
                    )
                    
                    VStack(spacing: 16) {
                        SectionHeader(
                            title: "Recently Played",
                            onSeeAll: { print("See all recently played") }
                        )
                        
                        HorizontalScrollSection {
                            ForEach(0..<5) { index in
                                MediaCard(
                                    image: "music.note",
                                    title: "Album \(index + 1)",
                                    subtitle: "Artist \(index + 1)",
                                    size: .medium,
                                    showPlayButton: index % 2 == 0
                                )
                            }
                        }
                    }
                    
                    VStack(spacing: 16) {
                        SectionHeader(
                            title: "Made for You",
                            subtitle: "Your personal mixes"
                        )
                        
                        HorizontalScrollSection {
                            ForEach(0..<4) { index in
                                MediaCard(
                                    image: "music.mic",
                                    title: "Daily Mix \(index + 1)",
                                    subtitle: "Playlist • Made for you",
                                    size: .small
                                )
                            }
                        }
                    }
                    
                    VStack(spacing: 0) {
                        SectionHeader(
                            title: "Top Songs",
                            onSeeAll: { print("See all top songs") }
                        )
                        .padding(.bottom, 12)
                        
                        ForEach(0..<5) { index in
                            VStack(spacing: 0) {
                                ListItem(
                                    image: "music.note",
                                    title: "Song Title \(index + 1)",
                                    subtitle: "Artist Name",
                                    metadata: "3:4\(index)",
                                    trailing: AnyView(
                                        IconButton(
                                            icon: "ellipsis",
                                            foregroundColor: .gray
                                        ) {
                                            print("More options")
                                        }
                                    )
                                )
                                
                                if index < 4 {
                                    Divider()
                                        .padding(.leading, 84)
                                }
                            }
                        }
                    }
                    
                    Spacer(minLength: 100)
                }
            }
            
            BottomTabBar(
                selectedTab: $selectedTab,
                items: [
                    TabItem(title: "Home", icon: "house.fill", destination: AnyView(Text("Home"))),
                    TabItem(title: "Search", icon: "magnifyingglass", destination: AnyView(Text("Search"))),
                    TabItem(title: "Library", icon: "books.vertical.fill", destination: AnyView(Text("Library"))),
                    TabItem(title: "Profile", icon: "person.fill", destination: AnyView(Text("Profile")))
                ]
            )
            }
            .ignoresSafeArea(edges: .bottom)
            
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}