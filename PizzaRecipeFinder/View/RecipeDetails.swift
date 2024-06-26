//
//  RecipeDetails.swift
//  PizzaRecipeFinder
//
//  Created by Svitlana on 13.06.2024.
//

import SwiftUI

struct RecipeDetails: View {
    
    @Binding var recipe: Recipe
    
    @ObservedObject var recipeModel = RecipeModel.model
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                AsyncImage(url: URL(string: recipe.imageUrl ?? "")) { phase in
                    ZStack{
                        phase
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .clipped()
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(LinearGradient(gradient: Gradient(colors: [.clear, Color("CellBg")]), startPoint: .center, endPoint: .bottom))
                    }
                } placeholder: {
                    ProgressView()
                }
                HStack{
                    Text(recipe.name)
                        .padding(.horizontal)
                        .font(.system(size: 30, weight: .bold, design: .default))
                        .foregroundColor(Color("Accent"))
                    Spacer()
                    Button(action: {
                        recipeModel.saveButtonTap(recipe: recipe)
                    }) {
                        Image(systemName: recipe.isSaved ? "heart.fill" : "heart")
                            .imageScale(.large)
                            .foregroundColor(Color("Accent"))
                            .bold()
                    }.padding(.horizontal)
                }
                Text(recipe.description ?? "")
                    .font(.body)
                    .padding(.horizontal)
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

//#Preview {
//    RecipeDetails(recipe: Recipe.sampleRecipe)
//}
