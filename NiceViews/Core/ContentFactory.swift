import SwiftUI

// MARK: - Content Factory
class ContentFactory {
    static let shared = ContentFactory()
    
    private init() {}
    
    // MARK: - Random Content Generation
    func createRandomContent() -> AnyView {
        let contentTypes: [ContentType] = [.mediaCard, .listItem, .hero, .userContent, .collection, .grid]
        let selectedType = contentTypes.randomElement() ?? .mediaCard
        
        return createContent(of: selectedType)
    }
    
    func createContent(of type: ContentType) -> AnyView {
        switch type {
        case .mediaCard:
            return createMediaCard()
        case .listItem:
            return createListItem()
        case .hero:
            return createHeroSection()
        case .userContent:
            return createUserContent()
        case .collection:
            return createCollection()
        case .grid:
            return createGrid()
        }
    }
    
    // MARK: - Private Content Creators
    private func createMediaCard() -> AnyView {
        let image = SampleData.albumImages.randomElement() ?? SampleData.albumImages[0]
        return AnyView(
            HStack {
                Spacer()
                EnhancedMediaCard(
                    imageUrl: image.url,
                    title: image.description,
                    subtitle: "Recommended for you",
                    size: .medium,
                    showPlayButton: Bool.random()
                )
                Spacer()
            }
            .padding(.horizontal, 16)
        )
    }
    
    private func createListItem() -> AnyView {
        let image = (SampleData.albumImages + SampleData.eventImages).randomElement()!
        return AnyView(
            VStack {
                EnhancedListItem(
                    imageUrl: image.url,
                    title: image.description,
                    subtitle: "Popular right now",
                    metadata: "3:42",
                    showPlayButton: true
                )
            }
            .cardStyle()
        )
    }
    
    private func createHeroSection() -> AnyView {
        let image = SampleData.heroImages.first ?? SampleData.eventImages.first!
        return AnyView(
            EnhancedHeroSection(
                imageUrl: image.url,
                title: "Featured Content",
                subtitle: "Specially selected for you",
                badge: ["NEW", "TRENDING", "HOT"].randomElement(),
                primaryAction: { print("Play") },
                secondaryAction: nil
            )
        )
    }
    
    private func createUserContent() -> AnyView {
        return AnyView(
            VStack {
                HStack(spacing: 16) {
                    UserAvatar(name: "Content Creator", size: .medium)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("New from Creator")
                            .font(.headline)
                        Text("Check out their latest work")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    ActionButton(title: "Follow", style: .secondary) {
                        print("Follow")
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
            }
            .padding(.horizontal, 16)
        )
    }
    
    private func createCollection() -> AnyView {
        return AnyView(
            VStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Trending Collection")
                        .font(.headline)
                        .padding(.horizontal, 16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(Array(SampleData.albumImages.prefix(4)), id: \.url) { image in
                                EnhancedMediaCard(
                                    imageUrl: image.url,
                                    title: image.description,
                                    subtitle: "Trending",
                                    size: .small
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .sectionStyle()
            }
            .padding(.horizontal, 16)
        )
    }
    
    private func createGrid() -> AnyView {
        return AnyView(
            VStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Explore Categories")
                        .font(.headline)
                        .padding(.horizontal, 16)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(Array(SampleData.albumImages.prefix(4)), id: \.url) { image in
                            EnhancedMediaCard(
                                imageUrl: image.url,
                                title: image.description,
                                subtitle: "Category",
                                size: .medium
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .sectionStyle()
            }
            .padding(.horizontal, 16)
        )
    }
}

// MARK: - Content Types
enum ContentType: String, CaseIterable {
    case mediaCard = "Media Card"
    case listItem = "List Item"
    case hero = "Hero Section"
    case userContent = "User Content"
    case collection = "Collection"
    case grid = "Grid"
}