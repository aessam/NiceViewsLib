import SwiftUI

struct HorizontalScrollSection<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                content
            }
            .padding(.horizontal, 16)
        }
    }
}

struct HorizontalScrollSection_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            SectionHeader(title: "Popular Albums")
            
            HorizontalScrollSection {
                ForEach(0..<5) { index in
                    MediaCard(
                        image: "music.note",
                        title: "Album \(index + 1)",
                        subtitle: "Artist Name",
                        size: .medium
                    )
                }
            }
        }
    }
}