import SwiftUI

struct RecipeList: View {
    
    @ObservedObject var recipeModel = RecipeModel.model
    @State private var searchText = ""
    @State private var showSavedOnly = false
    
    var filterResults: [Recipe] {
        if searchText.isEmpty {
            if(showSavedOnly){
                return recipeModel.allRecipes.filter {$0.isSaved}
            } else{
                return recipeModel.allRecipes
            }
        } else {
            if showSavedOnly {
                return recipeModel.allRecipes.filter { $0.isSaved && $0.name.contains(searchText) }
            } else {
                return recipeModel.allRecipes.filter { $0.name.contains(searchText) }
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            
            VStack {
                HStack {
                    TextField("Search", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading)
                    Button(action: {
                        showSavedOnly.toggle()
                    }) {
                        Image(systemName: showSavedOnly ? "heart.fill" : "heart")
                            .foregroundColor(Color("Accent"))
                            .font(.title)
                    }
                    .padding()
                }
            }
            
            ScrollView{
                VStack(spacing: 10){
                    ForEach(filterResults) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeCell(recipe: recipe)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                .navigationTitle("Pizza")
                .navigationDestination(for: Recipe.self) { selectedRecipe in
                    RecipeDetails(recipe: $recipeModel.allRecipes[recipeModel.allRecipes.firstIndex(where: { $0.id == selectedRecipe.id })!])
                }
            }
        }
    }
}

#Preview {
    RecipeList()
}

