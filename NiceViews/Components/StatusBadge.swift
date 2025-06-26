import SwiftUI

enum BadgeStyle {
    case live, new, premium, inactive
    
    var backgroundColor: Color {
        switch self {
        case .live: return .red
        case .new: return .blue
        case .premium: return .purple
        case .inactive: return .gray
        }
    }
}

struct StatusBadge: View {
    let text: String
    let style: BadgeStyle
    
    var body: some View {
        Text(text.uppercased())
            .font(.system(size: 11, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(style.backgroundColor)
            .cornerRadius(4)
    }
}

struct StatusBadge_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 12) {
            StatusBadge(text: "LIVE", style: .live)
            StatusBadge(text: "NEW", style: .new)
            StatusBadge(text: "PRO", style: .premium)
        }
    }
}