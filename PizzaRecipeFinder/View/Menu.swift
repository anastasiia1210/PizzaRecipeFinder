import SwiftUI
import PhotosUI

struct Menu: View {
    @State var selectedImage: PhotosPickerItem? = nil
    var body: some View {
        TabView {
            
            RecipeList()
                .tabItem {
                    Label("Recipes", systemImage: "list.bullet")
                }
            
            RecognizerView()
                .tabItem {
                    Label("Photo", systemImage: "photo")
                }
        }
        .accentColor(Color("Accent"))
    }
}

#Preview {
    Menu()
}
