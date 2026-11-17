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
    let receita: String
    let ingredientes: String
    let ingredientesBase: [String: String]
    let modoPreparo: String
    let linkImagem: String

    enum CodingKeys: String, CodingKey {
        case receita
        case ingredientes
        case ingredientesBase
        case modoPreparo
        case linkImagem = "link_imagem"
    }
}
