import SwiftUI

struct SafeTabItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
}

struct SafeBottomTabBar: View {
    @Binding var selectedTab: Int
    let items: [SafeTabItem]
    
    var body: some View {
        HStack {
            ForEach(items.indices, id: \.self) { index in
                SafeTabBarButton(
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

struct SafeTabBarButton: View {
    let item: SafeTabItem
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

struct SafeBottomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            
            SafeBottomTabBar(
                selectedTab: .constant(0),
                items: [
                    SafeTabItem(title: "Home", icon: "house.fill"),
                    SafeTabItem(title: "Search", icon: "magnifyingglass"),
                    SafeTabItem(title: "Library", icon: "books.vertical.fill"),
                    SafeTabItem(title: "Profile", icon: "person.fill")
                ]
            )
        }
    }
}