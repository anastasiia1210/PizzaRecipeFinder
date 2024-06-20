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
        VStack(spacing: -15) {
            AsyncImage(url: URL(string: recipe.imageUrl)) { phase in
                ZStack{
                    phase
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 220)
                        .clipped()
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(LinearGradient(gradient: Gradient(colors: [.clear, .white]), startPoint: .center, endPoint: .bottom))
                }
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading){
                Text(recipe.name)
                    .font(.system(size: 26, weight: .bold, design: .default))
                Text(recipe.description)
                    .lineLimit(2)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }.padding()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
        }
        .frame(maxWidth: 350)
        .frame(height: 300)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24.0))
        .shadow(radius: 8)
    }
}

#Preview {
    RecipeCell(recipe: Recipe.sampleRecipe)
}
