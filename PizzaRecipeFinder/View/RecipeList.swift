//
//  RecipeList.swift
//  PizzaRecipeFinder
//
//  Created by Svitlana on 13.06.2024.
//

import SwiftUI

struct RecipeList: View {
    
    @StateObject var recipeModel = RecipeModel()
    @State private var searchText = ""
    @State private var showSavedOnly = false
    
    var searchResults: [Recipe] {
        if searchText.isEmpty {
            return recipeModel.allRecipes
        } else {
            return recipeModel.allRecipes.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
            NavigationStack{
                ScrollView{
                    VStack(spacing: 10){
                        ForEach(searchResults) { recipe in
                            NavigationLink(value: recipe) {
                                RecipeCell(recipe: recipe)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    .navigationTitle("Pizza")
                    .navigationDestination(for: Recipe.self) { selectedRecipe in
                        RecipeDetails(recipe: selectedRecipe)
                    }
                }
                .searchable(text: $searchText)
            }
        }
}

#Preview {
    RecipeList()
}
