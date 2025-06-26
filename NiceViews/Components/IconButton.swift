import SwiftUI

struct IconButton: View {
    let icon: String
    let size: CGFloat
    let backgroundColor: Color
    let foregroundColor: Color
    let action: () -> Void
    
    init(
        icon: String,
        size: CGFloat = 44,
        backgroundColor: Color = .clear,
        foregroundColor: Color = .primary,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.size = size
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: size * 0.5))
                .foregroundColor(foregroundColor)
                .frame(width: size, height: size)
                .background(backgroundColor)
                .clipShape(Circle())
        }
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 20) {
            IconButton(
                icon: "heart",
                foregroundColor: .red
            ) {
                print("Heart pressed")
            }
            
            IconButton(
                icon: "square.and.arrow.up",
                backgroundColor: .gray.opacity(0.1)
            ) {
                print("Share pressed")
            }
            
            IconButton(
                icon: "ellipsis",
                size: 36,
                backgroundColor: .blue,
                foregroundColor: .white
            ) {
                print("More pressed")
            }
        }
    }
}