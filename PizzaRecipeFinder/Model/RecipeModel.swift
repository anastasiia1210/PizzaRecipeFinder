//
//  RecipeModel.swift
//  PizzaRecipeFinder
//
//  Created by Svitlana on 13.06.2024.
//

import Foundation

class RecipeModel : ObservableObject {
    
    @Published var allRecipes: [Recipe] = []
    
    //@Published var savedRecipes: [Recipe] = []
    
    static let model = RecipeModel()
    
    var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("recipedata.json")
    
    init() {
        print("init")
        let recipesFromApi: [RecipeFromApi] = load("recipe.json")
        let savedRecipes = loadSavedRecipeFromFile() ?? []
        
        var recipes: [Recipe] = []
        
        for recipe in recipesFromApi {
            var newRecipe = Recipe(from: recipe)
            if savedRecipes.contains(where: { $0.id == newRecipe.id }) {
                newRecipe.isSaved = true
            }
            recipes.append(newRecipe)
        }
        
        self.allRecipes = recipes
        
    }
    
    deinit {
        saveSavedRecipeToFile()
    }
    
    func loadSavedRecipeFromFile() -> [Recipe]? {
        print("loadSavedRecipeFromFile")
        if !FileManager.default.fileExists(atPath: path.path){
            return nil
        }
        do {
            let data = try Data(contentsOf: path)
            let decoder = JSONDecoder()
            let recipes = try decoder.decode([Recipe].self, from: data)
            return recipes
        } catch {
            print("Error while getting saved recipes: \(error)")
            return nil
        }
    }
    
    func saveSavedRecipeToFile() {
        print("saveSavedRecipeToFile")
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let savedRecipes = allRecipes.filter({ $0.isSaved })
            let data = try encoder.encode(savedRecipes)
            try data.write(to: path, options: .atomic)
        } catch {
            print("Error while saving recipes: \(error)")
        }
    }
    
    func getRecipeById(id: Int) -> Recipe? {
        return allRecipes.filter({$0.id == id}).first
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
    
    func saveButtonTap(recipe: Recipe){
        if(!recipe.isSaved){
            saveRecipeToSaved(recipe: recipe)
        } else {
            deleteRecipeFromSaved(recipe: recipe)
        }
    }
    
    private func saveRecipeToSaved(recipe: Recipe){
        //        if (!savedRecipes.contains { $0.id == recipe.id }) {
        self.allRecipes = self.allRecipes.map { p in
            var temp = p
            if(temp.id == recipe.id){
                temp.isSaved = true
            }
            return temp
        }
        //            var temp = recipe
        //            temp.isSaved = true
        //            self.savedRecipes.append(temp)
        //}
}
    
    private func deleteRecipeFromSaved(recipe: Recipe){
        //        if (savedRecipes.contains { $0.id == recipe.id }) {
        self.allRecipes = self.allRecipes.map { p in
            var temp = p
            if(temp.id == recipe.id){
                temp.isSaved = false
            }
            return temp
            //            }
            //            self.savedRecipes = self.savedRecipes.filter {$0.id != recipe.id}
            
        }
    }
}
