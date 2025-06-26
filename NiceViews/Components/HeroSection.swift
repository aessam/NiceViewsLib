import SwiftUI

struct HeroSection: View {
    let image: String
    let title: String
    let subtitle: String?
    let badge: String?
    let primaryAction: (() -> Void)?
    let secondaryAction: (() -> Void)?
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let uiImage = UIImage(systemName: image) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 400)
                    .clipped()
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            } else {
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.gray.opacity(0.3), .gray.opacity(0.7)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: 400)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.system(size: 60))
                            .foregroundColor(.white.opacity(0.5))
                    )
            }
            
            VStack(alignment: .leading, spacing: 12) {
                if let badge = badge {
                    StatusBadge(text: badge, style: .live)
                }
                
                Text(title)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.9))
                }
                
                HStack(spacing: 12) {
                    if primaryAction != nil {
                        Button(action: primaryAction!) {
                            HStack {
                                Image(systemName: "play.fill")
                                Text("Play")
                            }
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(Color.white)
                            .cornerRadius(24)
                        }
                    }
                    
                    if secondaryAction != nil {
                        Button(action: secondaryAction!) {
                            HStack {
                                Image(systemName: "plus")
                                Text("Add")
                            }
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(24)
                        }
                    }
                }
            }
            .padding(24)
        }
        .cornerRadius(16)
        .padding(.horizontal, 16)
    }
}

struct HeroSection_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 20) {
                HeroSection(
                    image: "music.note",
                    title: "Featured Album",
                    subtitle: "New release from your favorite artist",
                    badge: "NEW",
                    primaryAction: { print("Play") },
                    secondaryAction: { print("Add") }
                )
                
                HeroSection(
                    image: "tv",
                    title: "Live Concert",
                    subtitle: "Watch now",
                    badge: "LIVE",
                    primaryAction: { print("Watch") }, secondaryAction: (() -> Void)?(nil)
                )
            }
        }
    }
}
