import SwiftUI

struct TabSelectorDemoView: View {
    @State private var selectedIndex = 0
    let tabs = ["Songs", "Albums", "Artists", "Playlists", "Downloads"]
    
    var body: some View {
        VStack {
            TabSelector(selectedIndex: $selectedIndex, tabs: tabs)
            
            Text("Selected: \(tabs[selectedIndex])")
                .font(.title2)
                .padding()
            
            Spacer()
        }
        .navigationTitle("Tab Selector")
    }
}

struct SearchBarDemoView: View {
    @State private var searchText = ""
    @State private var searchText2 = "Sample query"
    
    var body: some View {
        VStack(spacing: 20) {
            SearchBar(text: $searchText, placeholder: "Search music")
            SearchBar(text: $searchText2, placeholder: "Search everything")
            
            Text("Search text: \(searchText)")
            Text("Search text 2: \(searchText2)")
            
            Spacer()
        }
        .padding()
        .navigationTitle("Search Bar")
    }
}

struct UserAvatarDemoView: View {
    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 16) {
                Text("Small Avatars")
                    .font(.headline)
                
                HStack(spacing: 16) {
                    UserAvatar(name: "John Doe", size: .small)
                    UserAvatar(name: "Jane Smith", size: .small, showBorder: true)
                    UserAvatar(name: "AB", size: .small)
                }
            }
            
            VStack(spacing: 16) {
                Text("Medium Avatars")
                    .font(.headline)
                
                HStack(spacing: 16) {
                    UserAvatar(name: "User Name", size: .medium)
                    UserAvatar(name: "Test User", size: .medium, showBorder: true)
                }
            }
            
            VStack(spacing: 16) {
                Text("Large Avatar")
                    .font(.headline)
                
                UserAvatar(name: "Profile User", size: .large, showBorder: true)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("User Avatars")
    }
}

struct StatusBadgeDemoView: View {
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 16) {
                Text("Status Badges")
                    .font(.headline)
                
                HStack(spacing: 12) {
                    StatusBadge(text: "LIVE", style: .live)
                    StatusBadge(text: "NEW", style: .new)
                    StatusBadge(text: "PRO", style: .premium)
                }
            }
            
            VStack(spacing: 16) {
                Text("In Context")
                    .font(.headline)
                
                HStack {
                    StatusBadge(text: "TRENDING", style: .new)
                    Text("Popular Song Title")
                        .font(.title3)
                    Spacer()
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Status Badges")
    }
}

struct ActionButtonDemoView: View {
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 16) {
                Text("Primary Buttons")
                    .font(.headline)
                
                ActionButton(title: "Play", icon: "play.fill", style: .primary) {
                    print("Play pressed")
                }
                
                ActionButton(title: "Download", icon: "arrow.down.circle", style: .primary) {
                    print("Download pressed")
                }
            }
            
            VStack(spacing: 16) {
                Text("Secondary Buttons")
                    .font(.headline)
                
                ActionButton(title: "Follow", style: .secondary) {
                    print("Follow pressed")
                }
                
                ActionButton(title: "Share", icon: "square.and.arrow.up", style: .secondary) {
                    print("Share pressed")
                }
            }
            
            VStack(spacing: 16) {
                Text("Text Buttons")
                    .font(.headline)
                
                ActionButton(title: "See All", style: .text) {
                    print("See All pressed")
                }
                
                ActionButton(title: "Learn More", icon: "info.circle", style: .text) {
                    print("Learn More pressed")
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Action Buttons")
    }
}

struct IconButtonDemoView: View {
    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 16) {
                Text("Icon Buttons")
                    .font(.headline)
                
                HStack(spacing: 20) {
                    IconButton(icon: "heart", foregroundColor: .red) {
                        print("Heart pressed")
                    }
                    
                    IconButton(icon: "square.and.arrow.up", backgroundColor: .gray.opacity(0.1)) {
                        print("Share pressed")
                    }
                    
                    IconButton(icon: "ellipsis", size: 36, backgroundColor: .blue, foregroundColor: .white) {
                        print("More pressed")
                    }
                }
            }
            
            VStack(spacing: 16) {
                Text("Different Sizes")
                    .font(.headline)
                
                HStack(spacing: 20) {
                    IconButton(icon: "play.fill", size: 32, backgroundColor: .blue, foregroundColor: .white) {
                        print("Small play")
                    }
                    
                    IconButton(icon: "play.fill", size: 44, backgroundColor: .blue, foregroundColor: .white) {
                        print("Medium play")
                    }
                    
                    IconButton(icon: "play.fill", size: 56, backgroundColor: .blue, foregroundColor: .white) {
                        print("Large play")
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Icon Buttons")
    }
}

struct SectionHeaderDemoView: View {
    var body: some View {
        VStack(spacing: 24) {
            SectionHeader(title: "Recently Played") {
                print("See all recently played")
            }
            
            SectionHeader(title: "Made for You", subtitle: "Your personal mix") {
                print("See all made for you")
            }
            
            SectionHeader(title: "Categories", showSeeAll: false)
            
            SectionHeader(title: "Trending Now", subtitle: "What everyone's listening to") {
                print("See all trending")
            }
            
            Spacer()
        }
        .navigationTitle("Section Headers")
    }
}

struct HorizontalScrollDemoView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Albums")
                        .font(.headline)
                        .padding(.horizontal, 16)
                    
                    HorizontalScrollSection {
                        ForEach(SampleData.albumImages, id: \.url) { image in
                            EnhancedMediaCard(
                                imageUrl: image.url,
                                title: image.description,
                                subtitle: "Artist",
                                size: .medium
                            )
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Events")
                        .font(.headline)
                        .padding(.horizontal, 16)
                    
                    HorizontalScrollSection {
                        ForEach(SampleData.eventImages, id: \.url) { image in
                            EnhancedMediaCard(
                                imageUrl: image.url,
                                title: image.description,
                                subtitle: "Live Event",
                                size: .small,
                                showPlayButton: true
                            )
                        }
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Horizontal Scroll")
    }
}

struct OtherDemoViews_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TabSelectorDemoView()
        }
    }
}