import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 16) {
                    UserAvatar(
                        name: "John Doe",
                        size: .large,
                        showBorder: true
                    )
                    
                    Text("John Doe")
                        .font(.system(size: 24, weight: .bold))
                    
                    HStack(spacing: 32) {
                        VStack(spacing: 4) {
                            Text("127")
                                .font(.system(size: 20, weight: .bold))
                            Text("Followers")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                        }
                        
                        VStack(spacing: 4) {
                            Text("89")
                                .font(.system(size: 20, weight: .bold))
                            Text("Following")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                        }
                        
                        VStack(spacing: 4) {
                            Text("45")
                                .font(.system(size: 20, weight: .bold))
                            Text("Playlists")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    HStack(spacing: 12) {
                        ActionButton(
                            title: "Edit Profile",
                            style: .secondary
                        ) {
                            print("Edit profile")
                        }
                        
                        ActionButton(
                            title: "Share",
                            icon: "square.and.arrow.up",
                            style: .secondary
                        ) {
                            print("Share profile")
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                
                VStack(spacing: 16) {
                    SectionHeader(
                        title: "Public Playlists",
                        onSeeAll: { print("See all playlists") }
                    )
                    
                    HorizontalScrollSection {
                        ForEach(0..<5) { index in
                            PlaylistCard(
                                title: "My Mix \(index + 1)",
                                songCount: 15 + index * 3,
                                gradient: LinearGradient(
                                    gradient: Gradient(colors: [.orange, .red]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            ) {
                                print("Tapped My Mix \(index + 1)")
                            }
                        }
                    }
                }
                
                VStack(spacing: 16) {
                    SectionHeader(
                        title: "Recently Played",
                        showSeeAll: false
                    )
                    
                    ForEach(0..<5) { index in
                        VStack(spacing: 0) {
                            ListItem(
                                image: "music.note",
                                title: "Recently Played \(index + 1)",
                                subtitle: "Artist Name",
                                metadata: "2 hours ago"
                            )
                            
                            if index < 4 {
                                Divider()
                                    .padding(.leading, 84)
                            }
                        }
                    }
                }
                
                VStack(spacing: 0) {
                    ListItem(
                        image: "gearshape.fill",
                        title: "Settings",
                        subtitle: nil,
                        trailing: AnyView(
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        )
                    )
                    
                    Divider()
                        .padding(.leading, 84)
                    
                    ListItem(
                        image: "questionmark.circle.fill",
                        title: "Help & Support",
                        subtitle: nil,
                        trailing: AnyView(
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        )
                    )
                    
                    Divider()
                        .padding(.leading, 84)
                    
                    ListItem(
                        image: "info.circle.fill",
                        title: "About",
                        subtitle: nil,
                        trailing: AnyView(
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        )
                    )
                }
                .padding(.top, 24)
                
                Spacer(minLength: 50)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}