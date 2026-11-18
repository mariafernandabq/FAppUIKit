//
//  Recipe.swift
//  FoodAppUIKit
//
//  Created by Maria Fernanda Braga Queiroz on 17/11/26.
//

import Foundation

struct RecipeFile: Decodable {
    let receitas: [Recipe]
}

struct Recipe: Decodable {
    let name: String
    let time: Int
    let level: String
    let category: String
    let portions: String
    let steps: [RecipeStep]
    let ingredients: [Ingredient]
}

struct RecipeStep: Decodable {
    let order: Int
    let instruction: String
    let process: String
}

struct Ingredient: Decodable {
    let name: String
    let quantity: String
    let unit: String
}
