import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
    let contentView: AnyView?
    let timestamp: Date = Date()
}

struct ChatExperienceView: View {
    @State private var messages: [ChatMessage] = []
    @State private var inputText = ""
    @State private var isTyping = false
    
    let responses = [
        "Here's something you might enjoy!",
        "I found this for you:",
        "Check out this cool content:",
        "Here's what I discovered:",
        "This might interest you:",
        "Take a look at this:",
        "I think you'll like this:"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Chat messages
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(messages) { message in
                            ChatBubble(message: message)
                                .id(message.id)
                        }
                        
                        if isTyping {
                            TypingIndicator()
                                .id("typing")
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
                .onChange(of: messages.count) {
                    withAnimation {
                        proxy.scrollTo(messages.last?.id.uuidString ?? "typing", anchor: .bottom)
                    }
                }
            }
            
            Divider()
            
            // Input area
            HStack(spacing: 12) {
                TextField("Ask for content...", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onSubmit {
                        sendMessage()
                    }
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .frame(width: 36, height: 36)
                        .background(Circle().fill(Color.blue))
                }
                .disabled(inputText.isEmpty)
            }
            .padding()
        }
        .navigationTitle("Chat Experience")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            addWelcomeMessage()
        }
    }
    
    private func addWelcomeMessage() {
        let welcome = ChatMessage(
            text: "Hi! Ask me to show you some content and I'll surprise you with random views from our collection!",
            isUser: false,
            contentView: nil
        )
        messages.append(welcome)
    }
    
    private func sendMessage() {
        guard !inputText.isEmpty else { return }
        
        // Add user message
        let userMessage = ChatMessage(text: inputText, isUser: true, contentView: nil)
        messages.append(userMessage)
        inputText = ""
        
        // Show typing indicator
        isTyping = true
        
        // Simulate response delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isTyping = false
            addBotResponse()
        }
    }
    
    private func addBotResponse() {
        let responseText = responses.randomElement() ?? "Here's something for you:"
        let randomContent = createRandomContent()
        
        let botMessage = ChatMessage(
            text: responseText,
            isUser: false,
            contentView: randomContent
        )
        messages.append(botMessage)
    }
    
    private func createRandomContent() -> AnyView {
        return ContentFactory.shared.createRandomContent()
    }
}

struct ChatBubble: View {
    let message: ChatMessage
    
    var body: some View {
        VStack(spacing: 12) {
            // Text bubble
            if !message.text.isEmpty {
                HStack {
                    if message.isUser { Spacer() }
                    
                    VStack(alignment: message.isUser ? .trailing : .leading, spacing: 4) {
                        Text(message.text)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(message.isUser ? Color.blue : Color(UIColor.secondarySystemBackground))
                            .foregroundColor(message.isUser ? .white : .primary)
                            .cornerRadius(20)
                        
                        Text(message.timestamp, style: .time)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    
                    if !message.isUser { Spacer() }
                }
                .padding(.horizontal)
            }
            
            // Content view in its own section
            if let contentView = message.contentView {
                VStack(alignment: .leading, spacing: 8) {
                    // Content section divider
                    HStack {
                        Rectangle()
                            .fill(Color.secondary.opacity(0.3))
                            .frame(height: 1)
                            .frame(maxWidth: 60)
                        
                        Text("Content")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Rectangle()
                            .fill(Color.secondary.opacity(0.3))
                            .frame(height: 1)
                    }
                    .padding(.horizontal)
                    
                    // Full-width content
                    contentView
                    
                    // End divider
                    Rectangle()
                        .fill(Color.secondary.opacity(0.3))
                        .frame(height: 1)
                        .padding(.horizontal)
                }
                .padding(.vertical, 8)
            }
        }
    }
}

struct TypingIndicator: View {
    @State private var animationOffset: CGFloat = 0
    
    var body: some View {
        HStack {
            HStack(spacing: 4) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 8, height: 8)
                        .offset(y: animationOffset)
                        .animation(
                            Animation.easeInOut(duration: 0.5)
                                .repeatForever()
                                .delay(Double(index) * 0.1),
                            value: animationOffset
                        )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(20)
            
            Spacer()
        }
        .onAppear {
            animationOffset = -5
        }
    }
}

struct ChatExperienceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatExperienceView()
        }
    }
}
