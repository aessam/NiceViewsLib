import SwiftUI

struct ViewsCatalogView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List {
            Section {
                HStack {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.blue)
                    Text("All views have a blue 'Main' button in the top-right corner to return here")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
            }
            Section(header: Text("Home Samples")) {
                NavigationLink(destination: HomeView()) {
                    HStack {
                        Image(systemName: "house")
                        Text("Home View")
                    }
                }
                
                NavigationLink(destination: HomeView2()) {
                    HStack {
                        Image(systemName: "house.fill")
                        Text("Home View Alternative")
                    }
                }
                
                NavigationLink(destination: PinHomeView()) {
                    HStack {
                        Image(systemName: "pin")
                        Text("Pin Home View")
                    }
                }
            }
            
            Section(header: Text("Explore Samples")) {
                NavigationLink(destination: ExploreView()) {
                    HStack {
                        Image(systemName: "compass")
                        Text("Explore View")
                    }
                }
                
                NavigationLink(destination: ExploreView2()) {
                    HStack {
                        Image(systemName: "compass.fill")
                        Text("Explore View Alternative")
                    }
                }
            }
            
            Section(header: Text("Content Views")) {
                NavigationLink(destination: LibraryView()) {
                    HStack {
                        Image(systemName: "books.vertical")
                        Text("Library View")
                    }
                }
                
                NavigationLink(destination: ProfileView()) {
                    HStack {
                        Image(systemName: "person.circle")
                        Text("Profile View")
                    }
                }
                
                NavigationLink(destination: AlbumDetailsView()) {
                    HStack {
                        Image(systemName: "music.note.list")
                        Text("Album Details View")
                    }
                }
                
                NavigationLink(destination: VideoPlayerView()) {
                    HStack {
                        Image(systemName: "play.rectangle")
                        Text("Video Player View")
                    }
                }
                
                NavigationLink(destination: SearchResultsView()) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search Results View")
                    }
                }
            }
            
            Section(header: Text("Special Views")) {
                NavigationLink(destination: ForYouView()) {
                    HStack {
                        Image(systemName: "heart.text.square")
                        Text("For You View")
                    }
                }
                
                NavigationLink(destination: TrailerView()) {
                    HStack {
                        Image(systemName: "film")
                        Text("Trailer View")
                    }
                }
            }
        }
        .navigationTitle("Views")
        .navigationBarTitleDisplayMode(.large)
        .onReceive(NotificationCenter.default.publisher(for: .popToRoot)) { _ in
            dismiss()
        }
    }
}

struct ViewsCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ViewsCatalogView()
        }
    }
}