import SwiftUI

struct AnimationShowcaseView: View {
    @State private var isLoading = false
    @State private var selectedCard = 0
    @State private var showDetails = false
    @State private var progressValue: Double = 0.0
    @State private var pulseScale: CGFloat = 1.0
    @State private var rotationAngle: Double = 0
    @State private var slideOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Loading States
                VStack(alignment: .leading, spacing: 16) {
                    Text("Loading States")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        // Shimmer Loading Card
                        ShimmerLoadingCard()
                        
                        // Pulse Loading Button
                        Button("Loading...") {
                            withAnimation(.easeInOut(duration: 1.0).repeatForever()) {
                                pulseScale = pulseScale == 1.0 ? 1.1 : 1.0
                            }
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                        .scaleEffect(pulseScale)
                        .disabled(true)
                        
                        // Progress Bar
                        VStack(spacing: 8) {
                            Text("Download Progress")
                                .font(.caption)
                            
                            ProgressView(value: progressValue)
                                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                                .onAppear {
                                    withAnimation(.linear(duration: 3.0).repeatForever(autoreverses: false)) {
                                        progressValue = 1.0
                                    }
                                }
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Interactive Animations
                VStack(alignment: .leading, spacing: 16) {
                    Text("Interactive Animations")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    // Card Flip Animation
                    FlipCard(isFlipped: $showDetails)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                showDetails.toggle()
                            }
                        }
                    
                    // Rotation Animation
                    Button(action: {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            rotationAngle += 360
                        }
                    }) {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.blue)
                    }
                    .rotationEffect(.degrees(rotationAngle))
                    
                    // Slide Animation
                    HStack {
                        Button("Slide") {
                            withAnimation(.bouncy) {
                                slideOffset = slideOffset == 0 ? 100 : 0
                            }
                        }
                        
                        Spacer()
                        
                        Circle()
                            .fill(Color.red)
                            .frame(width: 30, height: 30)
                            .offset(x: slideOffset)
                    }
                    .padding(.horizontal)
                }
                
                // Parallax Effect
                VStack(alignment: .leading, spacing: 16) {
                    Text("Parallax & Scroll Effects")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ParallaxScrollView()
                }
                
                // Transition Animations
                VStack(alignment: .leading, spacing: 16) {
                    Text("Transition Effects")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    TransitionDemo()
                }
                
                Spacer(minLength: 50)
            }
            .padding(.vertical)
        }
        .navigationTitle("Animation Showcase")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ShimmerLoadingCard: View {
    @State private var phase: CGFloat = 0
    
    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 60, height: 60)
                .overlay(shimmerOverlay)
            
            VStack(alignment: .leading, spacing: 8) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 16)
                    .overlay(shimmerOverlay)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 120, height: 12)
                    .overlay(shimmerOverlay)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding(.horizontal)
        .onAppear {
            withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                phase = 1
            }
        }
    }
    
    private var shimmerOverlay: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.clear,
                Color.white.opacity(0.3),
                Color.clear
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
        .offset(x: phase * 200 - 100)
        .clipped()
    }
}

struct FlipCard: View {
    @Binding var isFlipped: Bool
    
    var body: some View {
        ZStack {
            if isFlipped {
                // Back of card
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue)
                    .frame(height: 120)
                    .overlay(
                        VStack {
                            Image(systemName: "info.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                            Text("Card Details")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                    )
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            } else {
                // Front of card
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.green)
                    .frame(height: 120)
                    .overlay(
                        VStack {
                            Image(systemName: "creditcard.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                            Text("Tap to Flip")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                    )
            }
        }
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .padding(.horizontal)
    }
}

struct ParallaxScrollView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(0..<5) { index in
                    GeometryReader { geometry in
                        let offset = geometry.frame(in: .global).minX
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [.purple, .blue]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .frame(width: 200, height: 120)
                            
                            Text("Card \(index + 1)")
                                .font(.headline)
                                .foregroundColor(.white)
                                .offset(x: offset * 0.1) // Parallax effect
                        }
                    }
                    .frame(width: 200, height: 120)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct TransitionDemo: View {
    @State private var showContent = false
    
    var body: some View {
        VStack(spacing: 16) {
            Button("Toggle Content") {
                withAnimation(.spring()) {
                    showContent.toggle()
                }
            }
            
            if showContent {
                VStack(spacing: 12) {
                    ForEach(0..<3) { index in
                        HStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 30, height: 30)
                            
                            Text("Item \(index + 1)")
                                .font(.headline)
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(8)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                        .animation(.spring().delay(Double(index) * 0.1), value: showContent)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct AnimationShowcaseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AnimationShowcaseView()
        }
    }
}