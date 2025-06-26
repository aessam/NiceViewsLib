import SwiftUI

struct ComponentsCatalogView: View {
    var body: some View {
        BaseCatalogView(
            title: "Components",
            infoText: "Full-screen views have a blue 'Main' button in the top-right corner"
        ) {
            Section(header: Text("Media Cards")) {
                NavigationLink(destination: MediaCardDemoView()) {
                    Text("Media Card Styles")
                }
            }
            
            Section(header: Text("List Items")) {
                NavigationLink(destination: ListItemDemoView()) {
                    Text("List Item Styles")
                }
            }
            
            Section(header: Text("Navigation")) {
                NavigationLink(destination: BottomTabBarDemoView()) {
                    Text("Bottom Tab Bar")
                }
                
                NavigationLink(destination: TabSelectorDemoView()) {
                    Text("Tab Selector")
                }
            }
            
            Section(header: Text("Hero & Features")) {
                NavigationLink(destination: HeroSectionDemoView()) {
                    Text("Hero Section")
                }
            }
            
            Section(header: Text("Inputs")) {
                NavigationLink(destination: SearchBarDemoView()) {
                    Text("Search Bar")
                }
            }
            
            Section(header: Text("User Interface")) {
                NavigationLink(destination: UserAvatarDemoView()) {
                    Text("User Avatar")
                }
                
                NavigationLink(destination: StatusBadgeDemoView()) {
                    Text("Status Badges")
                }
            }
            
            Section(header: Text("Buttons")) {
                NavigationLink(destination: ActionButtonDemoView()) {
                    Text("Action Buttons")
                }
                
                NavigationLink(destination: IconButtonDemoView()) {
                    Text("Icon Buttons")
                }
            }
            
            Section(header: Text("Layout")) {
                NavigationLink(destination: SectionHeaderDemoView()) {
                    Text("Section Headers")
                }
                
                NavigationLink(destination: HorizontalScrollDemoView()) {
                    Text("Horizontal Scroll")
                }
            }
        }
    }
}

struct ComponentsCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ComponentsCatalogView()
        }
    }
}