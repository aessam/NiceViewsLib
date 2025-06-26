import SwiftUI

struct BottomTabBarDemoView: View {
    @State private var selectedTab = 0
    
    let tabNames = ["Home", "Search", "Library", "Profile", "Settings"]
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Selected Tab: \(tabNames[selectedTab])")
                .font(.title2)
                .padding()
            
            Spacer()
            
            SafeBottomTabBar(
                selectedTab: $selectedTab,
                items: [
                    SafeTabItem(title: "Home", icon: "house.fill"),
                    SafeTabItem(title: "Search", icon: "magnifyingglass"),
                    SafeTabItem(title: "Library", icon: "books.vertical.fill"),
                    SafeTabItem(title: "Profile", icon: "person.fill"),
                    SafeTabItem(title: "Settings", icon: "gearshape.fill")
                ]
            )
        }
        .navigationTitle("Bottom Tab Bar")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct BottomTabBarDemoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BottomTabBarDemoView()
        }
    }
}