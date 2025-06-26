import SwiftUI

// MARK: - Common View Modifiers
struct CardStyle: ViewModifier {
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    let padding: EdgeInsets
    
    init(
        cornerRadius: CGFloat = 12,
        shadowRadius: CGFloat = 2,
        padding: EdgeInsets = EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
    ) {
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.padding = padding
    }
    
    func body(content: Content) -> some View {
        content
            .background(Color(UIColor.systemBackground))
            .cornerRadius(cornerRadius)
            .shadow(radius: shadowRadius)
            .padding(padding)
    }
}

struct SectionStyle: ViewModifier {
    let horizontalPadding: CGFloat
    let verticalPadding: CGFloat
    
    init(horizontalPadding: CGFloat = 16, verticalPadding: CGFloat = 12) {
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
    }
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)
    }
}

struct NavigationStyle: ViewModifier {
    let title: String
    let displayMode: NavigationBarItem.TitleDisplayMode
    
    init(title: String, displayMode: NavigationBarItem.TitleDisplayMode = .large) {
        self.title = title
        self.displayMode = displayMode
    }
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(displayMode)
    }
}

// MARK: - View Extensions
extension View {
    func cardStyle(
        cornerRadius: CGFloat = 12,
        shadowRadius: CGFloat = 2,
        padding: EdgeInsets = EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
    ) -> some View {
        modifier(CardStyle(cornerRadius: cornerRadius, shadowRadius: shadowRadius, padding: padding))
    }
    
    func sectionStyle(horizontalPadding: CGFloat = 16, verticalPadding: CGFloat = 12) -> some View {
        modifier(SectionStyle(horizontalPadding: horizontalPadding, verticalPadding: verticalPadding))
    }
    
    func navigationStyle(title: String, displayMode: NavigationBarItem.TitleDisplayMode = .large) -> some View {
        modifier(NavigationStyle(title: title, displayMode: displayMode))
    }
}

// MARK: - Animation Extensions
extension Animation {
    static let cardFlip = Animation.spring(response: 0.6, dampingFraction: 0.8)
    static let bounce = Animation.bouncy
    static let gentleSpring = Animation.spring(response: 0.4, dampingFraction: 0.8)
    static let shimmer = Animation.linear(duration: 1.5).repeatForever(autoreverses: false)
}