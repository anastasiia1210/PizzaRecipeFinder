//
//  RecipeGenerator.swift
//  PizzaRecipeFinder
//
//  Created by Svitlana on 21.06.2024.
//

import Foundation

let generalIngredients: [Ingredient] = [
    Ingredient(id: 1, name: "Pizza Dough", quantity: 1, measure: "piece"),
    Ingredient(id: 2, name: "Tomato Sauce", quantity: 1, measure: "cup"),
    Ingredient(id: 3, name: "Mozzarella Cheese", quantity: 200, measure: "grams")
]

let generalSteps = ["Preheat your oven to 250°C (482°F).",
                    "Roll out the pizza dough to your desired thickness.",
                    "Spread the tomato sauce evenly over the dough.",
                    "Sprinkle mozzarella cheese on top of the sauce.",
                    "Bake in the preheated oven for 10-15 minutes."
]

func generateRecipe(ingredients: [String]) -> Recipe{
    let cusomIngredient = mapIngridients(ingredients: ingredients)
    
    var recipeSteps = Array(generalSteps.prefix(4))
    recipeSteps.append("Add \(cusomIngredient.map({ $0.name.lowercased() }).joined(separator: ", ")).")
    recipeSteps.append(generalSteps.last!)
    
    let ingredients = Array(generalIngredients + cusomIngredient)
    
    return Recipe(id: 1, name: "Recognized pizza", imageUrl: nil, description: nil, ingredients: ingredients, steps: recipeSteps)
}

func mapIngridients (ingredients: [String]) -> [Ingredient] {
    return ingredients.compactMap { ingredient in
        guard let productId = productIdMapping[ingredient], let ingredient = ingredientIdMapping[productId] else {
            return nil
        }
        return ingredient
    }
}
