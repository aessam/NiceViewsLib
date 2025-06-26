import SwiftUI

struct EnhancedHeroSection: View {
    let imageUrl: String
    let title: String
    let subtitle: String?
    let badge: String?
    let primaryAction: (() -> Void)?
    let secondaryAction: (() -> Void)?
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImageView(url: imageUrl, width: UIScreen.main.bounds.width - 32, height: 400)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .cornerRadius(16)
            
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
        .padding(.horizontal, 16)
    }
}

struct HeroSectionDemoView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                EnhancedHeroSection(
                    imageUrl: SampleData.heroImages.first?.url ?? "",
                    title: "Interactive Adventure",
                    subtitle: "Explore the lost city and uncover ancient mysteries",
                    badge: "NEW",
                    primaryAction: { print("Start Adventure") },
                    secondaryAction: { print("Save for Later") }
                )
                
                EnhancedHeroSection(
                    imageUrl: SampleData.eventImages.first?.url ?? "",
                    title: "Live Music Festival",
                    subtitle: "Join thousands of music lovers for an unforgettable night",
                    badge: "LIVE",
                    primaryAction: { print("Watch Live") },
                    secondaryAction: nil
                )
                
                EnhancedHeroSection(
                    imageUrl: SampleData.albumImages.first?.url ?? "",
                    title: "Featured Album",
                    subtitle: "New release from your favorite artist",
                    badge: nil,
                    primaryAction: { print("Play Album") },
                    secondaryAction: { print("Add to Library") }
                )
                
                EnhancedHeroSection(
                    imageUrl: SampleData.videoThumbnails.first?.url ?? "",
                    title: "Behind the Scenes",
                    subtitle: "See how your favorite content comes to life",
                    badge: "EXCLUSIVE",
                    primaryAction: { print("Watch Now") },
                    secondaryAction: { print("Share") }
                )
            }
            .padding(.vertical, 20)
        }
        .navigationTitle("Hero Sections")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct HeroSectionDemoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HeroSectionDemoView()
        }
    }
}
