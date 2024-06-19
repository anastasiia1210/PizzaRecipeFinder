//
//  RecipeDetails.swift
//  PizzaRecipeFinder
//
//  Created by Svitlana on 13.06.2024.
//

import SwiftUI

struct RecipeDetails: View {
    
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
    
                AsyncImage(url: URL(string: recipe.imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .frame(maxHeight: .infinity)
                            .padding()
                    case .failure:
                        Image(systemName: "questionmark.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.gray)
                            .frame(maxHeight: .infinity)
                            .padding()
                    @unknown default:
                        EmptyView()
                    }
                }
                
                Text(recipe.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                Text(recipe.description)
                    .font(.body)
                    .padding(.horizontal)
                
                Text("Ingredients")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                
                ForEach(recipe.ingredients) { ingredient in
                    HStack {
                        Text(ingredient.name)
                        Spacer()
                        Text("\(ingredient.quantity, specifier: "%.1f") \(ingredient.measure)")
                    }
                    .padding(.horizontal)
                }
                
                Text("Steps")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                
                ForEach(Array(recipe.steps.enumerated()), id: \.offset) { index, step in
                    HStack(alignment: .top) {
                        Text("Step \(index + 1).")
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
    RecipeDetails(recipe: Recipe.sampleRecipe)
}
