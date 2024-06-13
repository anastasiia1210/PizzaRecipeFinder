//
//  Menu.swift
//  PizzaRecipeFinder
//
//  Created by Svitlana on 13.06.2024.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        TabView {
            
            RecipeList()
                .tabItem {
                    Label("Recipes", systemImage: "list.bullet")
                }
            
            RecipeList()
                .tabItem {
                    Label("Photo", systemImage: "photo")
                }
        }
    }
}

#Preview {
    Menu()
}
