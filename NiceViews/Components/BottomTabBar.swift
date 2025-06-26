import SwiftUI

struct TabItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let destination: AnyView
}

struct BottomTabBar: View {
    @Binding var selectedTab: Int
    let items: [TabItem]
    
    var body: some View {
        HStack {
            ForEach(items.indices, id: \.self) { index in
                TabBarButton(
                    item: items[index],
                    isSelected: selectedTab == index
                ) {
                    selectedTab = index
                }
                
                if index < items.count - 1 {
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .background(
            Rectangle()
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
        )
    }
}

struct TabBarButton: View {
    let item: TabItem
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: item.icon)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .blue : .gray)
                
                Text(item.title)
                    .font(.system(size: 11))
                    .foregroundColor(isSelected ? .blue : .gray)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct BottomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            
            BottomTabBar(
                selectedTab: .constant(0),
                items: [
                    TabItem(title: "Home", icon: "house.fill", destination: AnyView(Text("Home"))),
                    TabItem(title: "Search", icon: "magnifyingglass", destination: AnyView(Text("Search"))),
                    TabItem(title: "Library", icon: "books.vertical.fill", destination: AnyView(Text("Library"))),
                    TabItem(title: "Profile", icon: "person.fill", destination: AnyView(Text("Profile")))
                ]
            )
        }
    }
}