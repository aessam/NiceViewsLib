import SwiftUI

struct LibraryView: View {
    @State private var selectedTab = 0
    @State private var searchText = ""
    let tabs = ["Songs", "Albums", "Artists", "Playlists", "Downloads"]
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack {
                    Text("Your Library")
                        .font(.system(size: 28, weight: .bold))
                    
                    Spacer()
                    
                    IconButton(
                        icon: "plus",
                        backgroundColor: .blue,
                        foregroundColor: .white
                    ) {
                        print("Add new")
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                
                SearchBar(text: $searchText)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                
                TabSelector(
                    selectedIndex: $selectedTab,
                    tabs: tabs
                )
            }
            
            ScrollView {
                VStack(spacing: 0) {
                    if selectedTab == 0 {
                        ForEach(0..<15) { index in
                            VStack(spacing: 0) {
                                ListItem(
                                    image: "music.note",
                                    title: "Song \(index + 1)",
                                    subtitle: "Artist Name",
                                    metadata: "Album • 3:42",
                                    showPlayButton: true
                                )
                                
                                if index < 14 {
                                    Divider()
                                        .padding(.leading, 84)
                                }
                            }
                        }
                    } else if selectedTab == 1 {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(0..<10) { index in
                                MediaCard(
                                    image: "music.note",
                                    title: "Album \(index + 1)",
                                    subtitle: "Artist Name",
                                    size: .medium
                                )
                            }
                        }
                        .padding(16)
                    } else if selectedTab == 2 {
                        ForEach(0..<8) { index in
                            VStack(spacing: 0) {
                                ArtistRowCard(
                                    artistName: "Artist \(index + 1)",
                                    songCount: 10 + index
                                ) {
                                    print("Tapped Artist \(index + 1)")
                                }
                                
                                if index < 7 {
                                    Divider()
                                        .padding(.leading, 92)
                                }
                            }
                        }
                    } else if selectedTab == 3 {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(0..<6) { index in
                                PlaylistCard(
                                    title: "Playlist \(index + 1)",
                                    songCount: 20 + index * 5,
                                    gradient: LinearGradient(
                                        gradient: Gradient(colors: [.blue, .purple]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    size: .large
                                ) {
                                    print("Tapped Playlist \(index + 1)")
                                }
                            }
                        }
                        .padding(16)
                    }
                }
                
                Spacer(minLength: 100)
            }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}