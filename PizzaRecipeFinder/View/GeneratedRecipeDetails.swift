//
//  GeneratedRecipeDetails.swift
//  PizzaRecipeFinder
//
//  Created by Svitlana on 22.06.2024.
//

import SwiftUI

struct GeneratedRecipeDetails: View {
    
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                                
                Text(recipe.name)
                    .padding(.horizontal)
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .foregroundColor(Color("Accent"))
                
                Divider()
                    .background(.secondary)
                    .padding(.horizontal)
                Text("Ingredients")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .padding(.horizontal)
                    .foregroundColor(Color("Accent"))
                ForEach(recipe.ingredients) { ingredient in
                    HStack {
                        Text("\(ingredient.quantity, specifier: "%.1f") \(ingredient.measure)")
                        Text("- \(ingredient.name)")
                    }
                    .padding(.horizontal)
                }
                Divider()
                    .background(.secondary)
                    .padding(.horizontal)
                Text("Steps")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .padding(.horizontal)
                    .foregroundColor(Color("Accent"))
                
                ForEach(Array(recipe.steps.enumerated()), id: \.offset) { index, step in
                    HStack(alignment: .top) {
                        Text("\(index + 1).")
                        Text(step)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    }


#Preview {
    GeneratedRecipeDetails(recipe: Recipe.sampleRecipe)
}
