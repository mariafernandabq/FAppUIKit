//
//  RecipeLoader.swift
//  FoodAppUIKit
//
//  Created by Maria Fernanda Braga Queiroz on 17/11/26.
//

import Foundation

enum RecipeLoader {
    enum LoadError: LocalizedError {
        case fileNotFound

        var errorDescription: String? {
            "O arquivo recipes.json não foi encontrado."
        }
    }

    static func load() throws -> [Recipe] {
        guard let url = Bundle.main.url(
            forResource: "recipes",
            withExtension: "json"
        ) else {
            throw LoadError.fileNotFound
        }

        let data = try Data(contentsOf: url)

        let file = try JSONDecoder().decode(
            RecipeFile.self,
            from: data
        )

        return file.receitas
    }
}
