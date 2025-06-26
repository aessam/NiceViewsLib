import SwiftUI

// MARK: - Component Configuration
protocol ComponentConfigurable {
    associatedtype ConfigType
    func configure(with config: ConfigType) -> Self
}

// MARK: - Configuration Types
struct MediaCardConfig {
    let title: String
    let subtitle: String
    let size: MediaCardSize
    let showPlayButton: Bool
    let imageUrl: String?
    
    static let `default` = MediaCardConfig(
        title: "Sample Title",
        subtitle: "Sample Subtitle",
        size: .medium,
        showPlayButton: false,
        imageUrl: nil
    )
}

struct ListItemConfig {
    let title: String
    let subtitle: String
    let metadata: String
    let showPlayButton: Bool
    let imageUrl: String?
    let trailingView: AnyView?
    
    static let `default` = ListItemConfig(
        title: "Sample Title",
        subtitle: "Sample Subtitle",
        metadata: "3:42",
        showPlayButton: false,
        imageUrl: nil,
        trailingView: nil
    )
}

struct ButtonConfig {
    let title: String
    let icon: String?
    let style: ButtonStyle
    let isEnabled: Bool
    
    static let `default` = ButtonConfig(
        title: "Action",
        icon: nil,
        style: .primary,
        isEnabled: true
    )
}

struct AvatarConfig {
    let name: String
    let size: AvatarSize
    let showBorder: Bool
    let imageUrl: String?
    
    static let `default` = AvatarConfig(
        name: "User Name",
        size: .medium,
        showBorder: false,
        imageUrl: nil
    )
}

struct BadgeConfig {
    let text: String
    let style: BadgeStyle
    
    static let `default` = BadgeConfig(
        text: "NEW",
        style: .new
    )
}

// MARK: - Configurable Components
struct ConfigurableMediaCard: View, ComponentConfigurable {
    private var config: MediaCardConfig
    
    init(config: MediaCardConfig = .default) {
        self.config = config
    }
    
    func configure(with config: MediaCardConfig) -> Self {
        ConfigurableMediaCard(config: config)
    }
    
    var body: some View {
        if let imageUrl = config.imageUrl {
            EnhancedMediaCard(
                imageUrl: imageUrl,
                title: config.title,
                subtitle: config.subtitle,
                size: config.size,
                showPlayButton: config.showPlayButton
            )
        } else if let sampleImage = SampleData.albumImages.first {
            EnhancedMediaCard(
                imageUrl: sampleImage.url,
                title: config.title,
                subtitle: config.subtitle,
                size: config.size,
                showPlayButton: config.showPlayButton
            )
        }
    }
}

struct ConfigurableListItem: View, ComponentConfigurable {
    private var config: ListItemConfig
    
    init(config: ListItemConfig = .default) {
        self.config = config
    }
    
    func configure(with config: ListItemConfig) -> Self {
        ConfigurableListItem(config: config)
    }
    
    var body: some View {
        if let imageUrl = config.imageUrl {
            EnhancedListItem(
                imageUrl: imageUrl,
                title: config.title,
                subtitle: config.subtitle,
                metadata: config.metadata,
                showPlayButton: config.showPlayButton,
                trailing: config.trailingView
            )
        } else if let sampleImage = SampleData.albumImages.first {
            EnhancedListItem(
                imageUrl: sampleImage.url,
                title: config.title,
                subtitle: config.subtitle,
                metadata: config.metadata,
                showPlayButton: config.showPlayButton,
                trailing: config.trailingView
            )
        }
    }
}

struct ConfigurableActionButton: View, ComponentConfigurable {
    private var config: ButtonConfig
    private let action: () -> Void
    
    init(config: ButtonConfig = .default, action: @escaping () -> Void = {}) {
        self.config = config
        self.action = action
    }
    
    func configure(with config: ButtonConfig) -> Self {
        ConfigurableActionButton(config: config, action: action)
    }
    
    var body: some View {
        ActionButton(
            title: config.title,
            icon: config.icon,
            style: config.style,
            action: action
        )
        .disabled(!config.isEnabled)
        .opacity(config.isEnabled ? 1.0 : 0.6)
    }
}

struct ConfigurableUserAvatar: View, ComponentConfigurable {
    private var config: AvatarConfig
    
    init(config: AvatarConfig = .default) {
        self.config = config
    }
    
    func configure(with config: AvatarConfig) -> Self {
        ConfigurableUserAvatar(config: config)
    }
    
    var body: some View {
        UserAvatar(
            image: config.imageUrl,
            name: config.name,
            size: config.size,
            showBorder: config.showBorder
        )
    }
}

struct ConfigurableStatusBadge: View, ComponentConfigurable {
    private var config: BadgeConfig
    
    init(config: BadgeConfig = .default) {
        self.config = config
    }
    
    func configure(with config: BadgeConfig) -> Self {
        ConfigurableStatusBadge(config: config)
    }
    
    var body: some View {
        StatusBadge(text: config.text, style: config.style)
    }
}