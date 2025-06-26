import SwiftUI

struct SectionHeader: View {
    let title: String
    let subtitle: String?
    let showSeeAll: Bool
    let onSeeAll: (() -> Void)?
    
    init(
        title: String,
        subtitle: String? = nil,
        showSeeAll: Bool = true,
        onSeeAll: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.showSeeAll = showSeeAll
        self.onSeeAll = onSeeAll
    }
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            if showSeeAll {
                Button(action: { onSeeAll?() }) {
                    Text("See All")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

struct SectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            SectionHeader(
                title: "Recently Played"
            )
            
            SectionHeader(
                title: "Made for You",
                subtitle: "Your personal mix"
            )
            
            SectionHeader(
                title: "Categories",
                showSeeAll: false
            )
        }
    }
}