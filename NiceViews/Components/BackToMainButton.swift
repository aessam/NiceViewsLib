import SwiftUI

struct BackToMainButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: {
            // Dismiss current view
            dismiss()
            
            // For deeper navigation, we need to dismiss multiple times
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                NotificationCenter.default.post(name: .popToRoot, object: nil)
            }
        }) {
            HStack {
                Image(systemName: "house.circle.fill")
                Text("Main")
            }
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.blue)
            .cornerRadius(20)
        }
    }
}

extension Notification.Name {
    static let popToRoot = Notification.Name("popToRoot")
}

struct DemoToolbar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    BackToMainButton()
                }
            }
    }
}

extension View {
    func withDemoToolbar() -> some View {
        modifier(DemoToolbar())
    }
}