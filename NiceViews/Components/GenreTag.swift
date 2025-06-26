import SwiftUI

struct GenreTag: View {
    let title: String
    let gradient: LinearGradient
    let style: GenreTagStyle
    let onTap: (() -> Void)?
    
    init(
        title: String,
        gradient: LinearGradient = LinearGradient(
            gradient: Gradient(colors: [.purple, .blue]),
            startPoint: .leading,
            endPoint: .trailing
        ),
        style: GenreTagStyle = .filled,
        onTap: (() -> Void)? = nil
    ) {
        self.title = title
        self.gradient = gradient
        self.style = style
        self.onTap = onTap
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(style.textColor)
                .padding()
            
            Spacer()
        }
        .background(style.background(gradient: gradient))
        .cornerRadius(8)
        .onTapGesture {
            onTap?()
        }
    }
}

enum GenreTagStyle {
    case filled, outlined, minimal
    
    var textColor: Color {
        switch self {
        case .filled: return .white
        case .outlined: return .primary
        case .minimal: return .primary
        }
    }
    
    func background(gradient: LinearGradient) -> AnyView {
        switch self {
        case .filled:
            return AnyView(gradient)
        case .outlined:
            return AnyView(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(gradient, lineWidth: 2)
                    .background(Color.clear)
            )
        case .minimal:
            return AnyView(
                Color.gray.opacity(0.1)
            )
        }
    }
}