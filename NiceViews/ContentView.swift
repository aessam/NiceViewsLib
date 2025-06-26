//
//  ContentView.swift
//  NiceViews
//
//  Created by Ahmed Essam on 6/1/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Catalogs").font(.headline)) {
                    MenuItemView(
                        icon: "square.grid.2x2",
                        iconColor: .blue,
                        title: "Components Catalog",
                        destination: ComponentsCatalogView()
                    )
                    
                    MenuItemView(
                        icon: "rectangle.3.group",
                        iconColor: .green,
                        title: "Views Catalog",
                        destination: ViewsCatalogView()
                    )
                }
                
                Section(header: Text("Interactive").font(.headline)) {
                    MenuItemView(
                        icon: "message.badge.filled.fill",
                        iconColor: .purple,
                        title: "Chat Experience",
                        subtitle: "Ask for content and get random views",
                        destination: ChatExperienceView()
                    )
                    
                    MenuItemView(
                        icon: "slider.horizontal.3",
                        iconColor: .orange,
                        title: "Component Playground",
                        subtitle: "Customize components in real-time",
                        destination: ComponentPlaygroundView()
                    )
                }
                
                Section(header: Text("Advanced").font(.headline)) {
                    MenuItemView(
                        icon: "wand.and.stars",
                        iconColor: .pink,
                        title: "Animation Showcase",
                        subtitle: "Loading states, transitions & effects",
                        destination: AnimationShowcaseView()
                    )
                    
                    MenuItemView(
                        icon: "list.bullet.rectangle",
                        iconColor: .indigo,
                        title: "Component States",
                        subtitle: "Normal, loading, error & empty states",
                        destination: ComponentStatesView()
                    )
                }
                
                Section(header: Text("Settings").font(.headline)) {
                    HStack {
                        Image(systemName: "paintbrush.fill")
                            .foregroundColor(.cyan)
                        ThemeToggle()
                    }
                }
            }
            .navigationTitle("NiceViews")
            .listStyle(InsetGroupedListStyle())
        }
    }
}

#Preview {
    ContentView()
}
