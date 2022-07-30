//
//  PokemonsService.swift
//  MVVM-Pokemon
//
//  Created by C330593 on 11/07/22.
//

import Foundation

class PokemonsService: PokemonServiceProtocol {
    
    // MARK: - Public Methods
    
    func getPokemons(url: String, completion: @escaping (Bool, PokemonModel?, String?) -> ()) {
        
        HttpRequestHelper().GET(
            url: url,
            params: ["": ""],
            httpHeader: .application_json
        ) { success, data in
            
            if success {
                do {
                    let model = try JSONDecoder().decode(PokemonModel.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Employees to model")
                }
            } else {
                completion(false, nil, "Error: Employees GET Request failed")
            }
        }
    }
    
    func getPokemonDetail(pokemon: String, completion: @escaping (Bool, PokemonDetailModel?, String?) -> ()) {
        HttpRequestHelper().GET(
            url: Constants.GET_POKEMONS_DETAIL + pokemon,
            params: ["": ""],
            httpHeader: .application_json
        ) { success, data in
            
            if success {
                do {
                    let model = try JSONDecoder().decode(PokemonDetailModel.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Employees to model")
                }
            } else {
                completion(false, nil, "Error: Employees GET Request failed")
            }
        }
    }
}
