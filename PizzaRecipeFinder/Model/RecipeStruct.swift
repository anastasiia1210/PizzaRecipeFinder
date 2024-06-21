//
//  RecipeStruct.swift
//  PizzaRecipeFinder
//
//  Created by Svitlana on 13.06.2024.
//

import Foundation

struct Recipe : Codable, Identifiable, Hashable {
    let id : Int
    let name : String
    let imageUrl : String
    let description : String
    let ingredients : [Ingredient]
    let steps : [String]
}

struct Ingredient : Codable, Identifiable, Hashable {
    let id : Int
    let name : String
    let quantity : Double
    let measure : String
}

extension Recipe {
    
   static let sampleIngredients = [
        Ingredient(id: 1, name: "Flour", quantity: 2.5, measure: "cups"),
        Ingredient(id: 2, name: "Sugar", quantity: 1.0, measure: "cup"),
        Ingredient(id: 3, name: "Butter", quantity: 0.5, measure: "cup"),
        Ingredient(id: 4, name: "Eggs", quantity: 3, measure: "pcs"),
        Ingredient(id: 5, name: "Milk", quantity: 1.5, measure: "cups")
    ]
    
    static let sampleRecipe = Recipe (
        id: 1,
        name: "Pancake",
        imageUrl: "https://www.recipetineats.com/wp-content/uploads/2024/05/Pizza-Capricciosa_8.jpg",
        description: "A simple and delicious pancake recipe that's perfect for breakfast.",
        ingredients: sampleIngredients,
        steps: [
            "Mix flour, sugar, and butter together.",
            "Beat in the eggs one at a time.",
            "Gradually add milk, stirring until the batter is smooth.",
            "Heat a lightly oiled griddle or frying pan over medium-high heat.",
            "Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake.",
            "Brown on both sides and serve hot."
        ]
    )
}



