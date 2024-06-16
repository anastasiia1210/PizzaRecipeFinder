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
        
        NavigationStack {
            List(searchResults) { recipe in
                NavigationLink (value: recipe, label: {
                    RecipeCell(recipe: recipe)
                        .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                })
            }
            .navigationTitle("Pizza")
            .navigationDestination(for: Recipe.self) { selectedRecipet in
                RecipeDetails(recipe: selectedRecipet)
            }
        }.searchable(text: $searchText)
    }
    
}

#Preview {
    RecipeList()
}
