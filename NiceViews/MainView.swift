import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Catalogs").font(.headline)) {
                    NavigationLink(destination: ComponentsCatalogView()) {
                        HStack {
                            Image(systemName: "square.grid.2x2")
                                .foregroundColor(.blue)
                            Text("Components Catalog")
                        }
                    }
                    
                    NavigationLink(destination: ViewsCatalogView()) {
                        HStack {
                            Image(systemName: "rectangle.3.group")
                                .foregroundColor(.green)
                            Text("Views Catalog")
                        }
                    }
                }
            }
            .navigationTitle("NiceViews")
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}