import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    
    let categories = [
        ("Music", "music.note", Color.purple),
        ("Podcasts", "mic", Color.green),
        ("Live", "dot.radiowaves.left.and.right", Color.red),
        ("Made for You", "heart.fill", Color.blue),
        ("New Releases", "sparkles", Color.orange),
        ("Charts", "chart.line.uptrend.xyaxis", Color.pink),
        ("Discover", "compass", Color.teal),
        ("Radio", "radio", Color.indigo)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Explore")
                        .font(.system(size: 32, weight: .bold))
                        .padding(.horizontal, 16)
                    
                    SearchBar(text: $searchText, placeholder: "Artists, songs, or podcasts")
                        .padding(.horizontal, 16)
                }
                .padding(.top, 16)
                
                VStack(spacing: 16) {
                    SectionHeader(
                        title: "Browse All",
                        showSeeAll: false
                    )
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(categories, id: \.0) { category in
                            CategoryCard(
                                title: category.0,
                                iconName: category.1,
                                backgroundColor: category.2
                            ) {
                                print("Tapped \(category.0)")
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                VStack(spacing: 16) {
                    SectionHeader(
                        title: "Trending Now",
                        onSeeAll: { print("See all trending") }
                    )
                    
                    ForEach(0..<5) { index in
                        RankedListItem(
                            rank: index + 1,
                            title: "Trending Song \(index + 1)",
                            subtitle: "Artist Name",
                            metadata: "\(100 - index * 10)M plays",
                            trendDirection: index < 3 ? .up : .down
                        ) {
                            print("Tapped trending song \(index + 1)")
                        }
                    }
                }
                
                VStack(spacing: 16) {
                    SectionHeader(
                        title: "Popular Genres",
                        onSeeAll: { print("See all genres") }
                    )
                    
                    HorizontalScrollSection {
                        ForEach(["Pop", "Rock", "Hip-Hop", "Electronic", "Classical", "Jazz"], id: \.self) { genre in
                            GenreCircle(
                                title: genre,
                                iconName: "music.note",
                                gradient: LinearGradient(
                                    gradient: Gradient(colors: [.blue, .purple]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            ) {
                                print("Tapped \(genre)")
                            }
                        }
                    }
                }
                
                Spacer(minLength: 50)
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}