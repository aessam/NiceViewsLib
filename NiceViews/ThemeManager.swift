import SwiftUI

public class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    @Published var isDarkMode: Bool = false {
        didSet {
            applyTheme()
        }
    }
    
    private init() {
        isDarkMode = UITraitCollection.current.userInterfaceStyle == .dark
    }
    
    func applyTheme() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
            }
        }
    }
    
    func toggleTheme() {
        isDarkMode.toggle()
    }
}

struct ThemeToggle: View {
    @ObservedObject var themeManager = ThemeManager.shared
    
    var body: some View {
        Toggle(isOn: $themeManager.isDarkMode) {
            HStack {
                Image(systemName: themeManager.isDarkMode ? "moon.fill" : "sun.max.fill")
                    .foregroundColor(themeManager.isDarkMode ? .yellow : .orange)
                Text(themeManager.isDarkMode ? "Dark Mode" : "Light Mode")
            }
        }
        .toggleStyle(SwitchToggleStyle(tint: .blue))
    }
}
