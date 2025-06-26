import SwiftUI

struct ComponentStatesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Button States
                StateSection(title: "Button States") {
                    VStack(spacing: 12) {
                        HStack(spacing: 12) {
                            ActionButton(title: "Normal", style: .primary) {}
                            ActionButton(title: "Loading", style: .primary) {}
                                .disabled(true)
                                .opacity(0.6)
                        }
                        
                        HStack(spacing: 12) {
                            ActionButton(title: "Disabled", style: .secondary) {}
                                .disabled(true)
                            ActionButton(title: "Selected", style: .primary) {}
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(24)
                        }
                    }
                }
                
                // List Item States
                StateSection(title: "List Item States") {
                    VStack(spacing: 1) {
                        // Normal State
                        ListItemWithState(
                            title: "Normal Item",
                            subtitle: "Standard state",
                            state: .normal
                        )
                        
                        // Loading State
                        ListItemWithState(
                            title: "Loading Item",
                            subtitle: "Please wait...",
                            state: .loading
                        )
                        
                        // Error State
                        ListItemWithState(
                            title: "Error Item",
                            subtitle: "Failed to load",
                            state: .error
                        )
                        
                        // Selected State
                        ListItemWithState(
                            title: "Selected Item",
                            subtitle: "Currently selected",
                            state: .selected
                        )
                    }
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(12)
                }
                
                // Media Card States
                StateSection(title: "Media Card States") {
                    VStack(spacing: 16) {
                        HStack(spacing: 16) {
                            MediaCardWithState(
                                title: "Available",
                                subtitle: "Ready to play",
                                state: .available
                            )
                            
                            MediaCardWithState(
                                title: "Loading",
                                subtitle: "Buffering...",
                                state: .loading
                            )
                        }
                        
                        HStack(spacing: 16) {
                            MediaCardWithState(
                                title: "Downloaded",
                                subtitle: "Offline ready",
                                state: .downloaded
                            )
                            
                            MediaCardWithState(
                                title: "Unavailable",
                                subtitle: "Not available",
                                state: .unavailable
                            )
                        }
                    }
                }
                
                // Empty States
                StateSection(title: "Empty States") {
                    VStack(spacing: 20) {
                        EmptyStateView(
                            icon: "music.note.list",
                            title: "No Music",
                            subtitle: "Add some music to get started",
                            actionTitle: "Browse Music"
                        ) {}
                        
                        EmptyStateView(
                            icon: "magnifyingglass",
                            title: "No Search Results",
                            subtitle: "Try adjusting your search terms",
                            actionTitle: "Clear Search"
                        ) {}
                        
                        EmptyStateView(
                            icon: "wifi.slash",
                            title: "No Connection",
                            subtitle: "Check your internet connection",
                            actionTitle: "Retry"
                        ) {}
                    }
                }
                
                // Content Length Variations
                StateSection(title: "Content Length Variations") {
                    VStack(spacing: 12) {
                        ContentLengthCard(
                            title: "Short",
                            subtitle: "Brief"
                        )
                        
                        ContentLengthCard(
                            title: "Medium Length Title That Spans More",
                            subtitle: "A subtitle that provides more context and information"
                        )
                        
                        ContentLengthCard(
                            title: "Very Long Title That Would Definitely Need Truncation in Most UI Contexts",
                            subtitle: "An extremely long subtitle that demonstrates how the component handles extensive text content and whether it truncates properly or adapts to the available space"
                        )
                    }
                }
                
                Spacer(minLength: 50)
            }
            .padding(.vertical)
        }
        .navigationTitle("Component States")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct StateSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            
            content
                .padding(.horizontal)
        }
    }
}

enum ItemState {
    case normal, loading, error, selected
}

struct ListItemWithState: View {
    let title: String
    let subtitle: String
    let state: ItemState
    
    var body: some View {
        HStack(spacing: 12) {
            // Icon based on state
            Group {
                switch state {
                case .normal:
                    Image(systemName: "music.note")
                        .foregroundColor(.blue)
                case .loading:
                    ProgressView()
                        .scaleEffect(0.8)
                case .error:
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.red)
                case .selected:
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
            .frame(width: 24, height: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(state == .error ? .red : .primary)
                
                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(state == .error ? .red.opacity(0.7) : .secondary)
            }
            
            Spacer()
            
            if state == .selected {
                Image(systemName: "chevron.right")
                    .foregroundColor(.blue)
                    .font(.system(size: 14))
            }
        }
        .padding()
        .background(state == .selected ? Color.blue.opacity(0.1) : Color.clear)
    }
}

enum MediaCardState {
    case available, loading, downloaded, unavailable
}

struct MediaCardWithState: View {
    let title: String
    let subtitle: String
    let state: MediaCardState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 150, height: 150)
                
                // State overlay
                Group {
                    switch state {
                    case .available:
                        PlayButton(size: 44)
                    case .loading:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                    case .downloaded:
                        VStack {
                            Image(systemName: "arrow.down.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.green)
                            Text("Downloaded")
                                .font(.caption)
                                .foregroundColor(.green)
                        }
                    case .unavailable:
                        VStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.red)
                            Text("Unavailable")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .lineLimit(1)
                    .foregroundColor(state == .unavailable ? .secondary : .primary)
                
                Text(subtitle)
                    .font(.system(size: 12))
                    .lineLimit(1)
                    .foregroundColor(.secondary)
            }
            .frame(width: 150, alignment: .leading)
        }
        .opacity(state == .unavailable ? 0.6 : 1.0)
    }
}

struct EmptyStateView: View {
    let icon: String
    let title: String
    let subtitle: String
    let actionTitle: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            
            VStack(spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Button(action: action) {
                Text(actionTitle)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
    }
}

struct ContentLengthCard: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.blue)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .lineLimit(2)
                
                Text(subtitle)
                    .font(.system(size: 14))
                    .lineLimit(3)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 1)
    }
}

struct ComponentStatesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ComponentStatesView()
        }
    }
}