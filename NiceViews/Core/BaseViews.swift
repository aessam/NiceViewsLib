import SwiftUI

// MARK: - Base Navigation View
struct BaseNavigationView<Content: View>: View {
    let title: String
    let displayMode: NavigationBarItem.TitleDisplayMode
    let showBackButton: Bool
    let content: Content
    
    init(
        title: String,
        displayMode: NavigationBarItem.TitleDisplayMode = .large,
        showBackButton: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.displayMode = displayMode
        self.showBackButton = showBackButton
        self.content = content()
    }
    
    var body: some View {
        content
            .navigationStyle(title: title, displayMode: displayMode)
            .toolbar {
                if showBackButton {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        BackToMainButton()
                    }
                }
            }
    }
}

// MARK: - Base Catalog View
struct BaseCatalogView<Content: View>: View {
    let title: String
    let infoText: String
    let content: Content
    @Environment(\.dismiss) var dismiss
    
    init(
        title: String,
        infoText: String,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.infoText = infoText
        self.content = content()
    }
    
    var body: some View {
        List {
            Section {
                HStack {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.blue)
                    Text(infoText)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
            }
            
            content
        }
        .navigationStyle(title: title)
        .onReceive(NotificationCenter.default.publisher(for: .popToRoot)) { _ in
            dismiss()
        }
    }
}

// MARK: - Base Section View
struct BaseSectionView<Content: View>: View {
    let title: String
    let subtitle: String?
    let showSeeAll: Bool
    let onSeeAll: (() -> Void)?
    let content: Content
    
    init(
        title: String,
        subtitle: String? = nil,
        showSeeAll: Bool = true,
        onSeeAll: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.showSeeAll = showSeeAll
        self.onSeeAll = onSeeAll
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 16) {
            SectionHeader(
                title: title,
                subtitle: subtitle,
                showSeeAll: showSeeAll,
                onSeeAll: onSeeAll
            )
            
            content
        }
    }
}

// MARK: - Base Card View
struct BaseCardView<Content: View>: View {
    let content: Content
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    let backgroundColor: Color
    let padding: EdgeInsets
    
    init(
        cornerRadius: CGFloat = 12,
        shadowRadius: CGFloat = 2,
        backgroundColor: Color = Color(UIColor.systemBackground),
        padding: EdgeInsets = EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16),
        @ViewBuilder content: () -> Content
    ) {
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.backgroundColor = backgroundColor
        self.padding = padding
        self.content = content()
    }
    
    var body: some View {
        content
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .shadow(radius: shadowRadius)
            .padding(padding)
    }
}

// MARK: - Base Demo View
struct BaseDemoView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                content
                Spacer(minLength: 50)
            }
            .padding(.vertical)
        }
        .navigationStyle(title: title)
    }
}

// MARK: - Menu Item View
struct MenuItemView: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String?
    let destination: AnyView
    
    init<Destination: View>(
        icon: String,
        iconColor: Color,
        title: String,
        subtitle: String? = nil,
        destination: Destination
    ) {
        self.icon = icon
        self.iconColor = iconColor
        self.title = title
        self.subtitle = subtitle
        self.destination = AnyView(destination)
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
                
                if let subtitle = subtitle {
                    VStack(alignment: .leading) {
                        Text(title)
                        Text(subtitle)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                } else {
                    Text(title)
                }
            }
        }
    }
}