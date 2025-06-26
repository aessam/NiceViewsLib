import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let placeholder: String
    let onSubmit: (() -> Void)?
    
    init(
        text: Binding<String>,
        placeholder: String = "Search",
        onSubmit: (() -> Void)? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.onSubmit = onSubmit
    }
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .font(.system(size: 16))
            
            TextField(placeholder, text: $text)
                .font(.system(size: 16))
                .onSubmit {
                    onSubmit?()
                }
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(24)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            SearchBar(
                text: .constant(""),
                placeholder: "Search music"
            )
            
            SearchBar(
                text: .constant("Taylor Swift"),
                placeholder: "Search"
            )
        }
        .padding()
    }
}