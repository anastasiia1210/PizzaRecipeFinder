//
//  RecipeModel.swift
//  PizzaRecipeFinder
//
//  Created by Svitlana on 13.06.2024.
//

import Foundation

class RecipeModel : ObservableObject {
    
    //@Published var listOfRecipes: [Recipe] = []
    
    @Published var allRecipes: [Recipe] = []
//    @Published var savedRecipes: [Recipe] = []
//    
//    var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("savedRecipe.json")

    init() {
        self.allRecipes = load("recipe.json")
    }
    
    func load<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
