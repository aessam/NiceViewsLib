import SwiftUI

enum ButtonStyle {
    case primary, secondary, text
}

struct ActionButton: View {
    let title: String
    let icon: String?
    let style: ButtonStyle
    let action: () -> Void
    
    init(
        title: String,
        icon: String? = nil,
        style: ButtonStyle = .primary,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.style = style
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 16))
                }
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
            }
            .foregroundColor(foregroundColor)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(backgroundColor)
            .cornerRadius(24)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(borderColor, lineWidth: style == .secondary ? 1 : 0)
            )
        }
    }
    
    private var foregroundColor: Color {
        switch style {
        case .primary: return .white
        case .secondary: return .blue
        case .text: return .blue
        }
    }
    
    private var backgroundColor: Color {
        switch style {
        case .primary: return .blue
        case .secondary: return .clear
        case .text: return .clear
        }
    }
    
    private var borderColor: Color {
        switch style {
        case .primary: return .clear
        case .secondary: return .blue
        case .text: return .clear
        }
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            ActionButton(
                title: "Play",
                icon: "play.fill",
                style: .primary
            ) {
                print("Play pressed")
            }
            
            ActionButton(
                title: "Follow",
                style: .secondary
            ) {
                print("Follow pressed")
            }
            
            ActionButton(
                title: "See All",
                style: .text
            ) {
                print("See All pressed")
            }
        }
        .padding()
    }
}