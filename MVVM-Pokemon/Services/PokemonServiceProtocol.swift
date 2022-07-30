//
//  PokemonServiceProtocol.swift
//  MVVM-Pokemon
//
//  Created by C330593 on 11/07/22.
//

import Foundation

protocol PokemonServiceProtocol {
    func getPokemons(url: String, completion: @escaping (_ success: Bool, _ results: PokemonModel?, _ error: String?) -> ())
    func getPokemonDetail(pokemon: String, completion: @escaping (_ success: Bool, _ results: PokemonDetailModel?, _ error: String?) -> ())
}
