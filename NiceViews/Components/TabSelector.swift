import SwiftUI

struct TabSelector: View {
    @Binding var selectedIndex: Int
    let tabs: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(tabs.indices, id: \.self) { index in
                    TabButton(
                        title: tabs[index],
                        isSelected: selectedIndex == index
                    ) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedIndex = index
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .background(
            VStack {
                Spacer()
                Divider()
            }
        )
    }
}

struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 16, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? .primary : .secondary)
                
                Rectangle()
                    .fill(isSelected ? Color.blue : Color.clear)
                    .frame(height: 2)
            }
        }
    }
}

struct TabSelector_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TabSelector(
                selectedIndex: .constant(0),
                tabs: ["Songs", "Albums", "Artists", "Playlists", "Downloads"]
            )
            
            Spacer()
        }
    }
}