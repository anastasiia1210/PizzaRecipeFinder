

import SwiftUI

@main
struct PizzaRecipeFinderApp: App {
    
    @StateObject private var recipeModel = RecipeModel.model
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onChange(of: scenePhase) {
                    switch scenePhase {
                    case .background:
                        print("App is background")
                        recipeModel.saveSavedRecipeToFile()
                    case .inactive:
                        print("App is inactive")
                    case .active:
                        print("App is active")
                    @unknown default:
                        print("Phase is unknown")
                    }
                }
        }
    }
}
