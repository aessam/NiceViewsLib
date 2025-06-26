import Foundation

struct SampleImage: Identifiable {
    let id = UUID()
    let url: String
    let description: String
    let category: String
}

struct SampleData {
    static let albumImages = [
        SampleImage(
            url: "sample_album",
            description: "Echoes of the Night",
            category: "Album"
        ),
        SampleImage(
            url: "sample_album2",
            description: "Eternal Echoes",
            category: "Album"
        ),
        SampleImage(
            url: "sample_album3",
            description: "Nightfall Reverie",
            category: "Album"
        ),
        SampleImage(
            url: "sample_album",
            description: "Celestial Dreams",
            category: "Album"
        )
    ]
    
    static let eventImages = [
        SampleImage(
            url: "sample_event",
            description: "Live Music Festival",
            category: "Event"
        ),
        SampleImage(
            url: "sample_event2",
            description: "VR Gaming Tournament",
            category: "Event"
        ),
        SampleImage(
            url: "sample_event",
            description: "Culinary Masterclass",
            category: "Event"
        )
    ]
    
    static let videoThumbnails = [
        SampleImage(
            url: "sample_video",
            description: "The Making of 'Starlight'",
            category: "Video"
        ),
        SampleImage(
            url: "sample_video2",
            description: "Unveiling the Art of 'Mystic'",
            category: "Video"
        )
    ]
    
    static let userAvatars = [
        SampleImage(
            url: "sample_avatar",
            description: "User Avatar 1",
            category: "Avatar"
        )
    ]
    
    static let heroImages = [
        SampleImage(
            url: "sample_hero",
            description: "The Lost City of Eldoria",
            category: "Hero"
        )
    ]
    
    static func getRandomImage(from category: String? = nil) -> SampleImage {
        let allImages = albumImages + eventImages + videoThumbnails + userAvatars + heroImages
        
        if let category = category {
            let filtered = allImages.filter { $0.category == category }
            return filtered.randomElement() ?? allImages.randomElement()!
        }
        
        return allImages.randomElement()!
    }
}