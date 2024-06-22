//
//  ProductTypeIDs.swift
//  PizzaRecipeFinder
//
//  Created by Svitlana on 21.06.2024.
//

import Foundation

let productIdMapping: [String : Int] = [
    "arugula" : 10,
    "bacon" : 11,
    "black_olives" :12,
    "broccoli" : 13,
    "corn" : 14,
    "fresh_basil" : 15,
    "mushrooms" : 16,
    "onions" : 17,
    "pepperoni" : 18,
    "peppers" : 19,
    "pineapple" : 20,
    "spinach" : 21,
    "tomatoes" : 22
]

let ingredientIdMapping: [Int : Ingredient] = [
    10 : Ingredient(id: 10, name: "Arugula", quantity: 30, measure: "grams"),
    11 : Ingredient(id: 11, name: "Bacon", quantity: 50, measure: "grams"),
    12: Ingredient(id: 12, name: "Black Olives", quantity: 50, measure: "grams"),
    13: Ingredient(id: 13, name: "Broccoli", quantity: 70, measure: "grams"),
    14: Ingredient(id: 14, name: "Corn", quantity: 60, measure: "grams"),
    15: Ingredient(id: 15, name: "Fresh Basil", quantity: 10, measure: "leaves"),
    16: Ingredient(id: 16, name: "Mushrooms", quantity: 100, measure: "grams"),
    17 : Ingredient(id: 17, name: "Onions", quantity: 50, measure: "grams"),
    18 : Ingredient(id: 18, name: "Pepperoni", quantity: 100, measure: "grams"),
    19 : Ingredient(id: 19, name: "Bell Peppers", quantity: 50, measure: "grams"),
    20 : Ingredient(id: 20, name: "Pineapple", quantity: 80, measure: "grams"),
    21 : Ingredient(id: 21, name: "Spinach", quantity: 40, measure: "grams"),
    22 : Ingredient(id: 22, name: "Tomatoes", quantity: 70, measure: "grams")
]
