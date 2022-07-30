//
//  PokemonModel.swift
//  MVVM-Pokemon
//
//  Created by C330593 on 11/07/22.
//

import Foundation

struct PokemonModel: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let name: String
    let url: String
}
