//
//  RecipeCell.swift
//  PizzaRecipeFinder
//
//  Created by Svitlana on 13.06.2024.
//

import SwiftUI

struct RecipeCell: View {
    
    let recipe: Recipe
    
    
    var body: some View {
        VStack() {
            
            AsyncImage(url: URL(string: recipe.imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .clipped()
                        .cornerRadius(10)
                case .failure:
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .foregroundColor(Color.gray)
                        .padding()
                @unknown default:
                    EmptyView()
                }
                
                Text(recipe.name)
     
                Text(recipe.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
        }
        .frame(alignment: .center)
        .padding()
    }
}

#Preview {
    RecipeCell(recipe: Recipe.sampleRecipe)
}
