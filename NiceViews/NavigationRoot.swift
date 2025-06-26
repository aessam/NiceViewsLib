import SwiftUI

class NavigationViewModel: ObservableObject {
    static let shared = NavigationViewModel()
    @Published var shouldPopToRoot = false
}

struct NavigationRoot: View {
    @StateObject private var navigationVM = NavigationViewModel.shared
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ContentView()
                .navigationDestination(for: String.self) { destination in
                    // Handle navigation destinations if needed
                }
        }
        .onReceive(navigationVM.$shouldPopToRoot) { shouldPop in
            if shouldPop {
                navigationPath = NavigationPath() // Clear the navigation stack
                navigationVM.shouldPopToRoot = false
            }
        }
    }
}