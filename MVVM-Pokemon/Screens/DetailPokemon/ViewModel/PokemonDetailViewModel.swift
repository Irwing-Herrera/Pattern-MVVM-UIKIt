//
//  PokemonDetailViewModel.swift
//  MVVM-Pokemon
//
//  Created by C330593 on 11/07/22.
//

import Foundation

class PokemonDetailViewModel: NSObject {
    
    // MARK: - Private Variables
    
    private var pokemonsService: PokemonServiceProtocol
    
    // MARK: - Public Variables
    
    public var pokemonDetail: PokemonDetailModel = PokemonDetailModel(
        baseExperience: 0,
        height: 0,
        id: 0,
        isDefault: false,
        locationAreaEncounters: "",
        name: "",
        order: 0,
        sprites: Sprites(
            backDefault: "",
            backShiny: "",
            frontDefault: "",
            frontShiny: ""
        ),
        weight: 0
    )
    
    // MARK: - Public Methods
    
    public init(pokemonsService: PokemonServiceProtocol = PokemonsService()) {
        self.pokemonsService = pokemonsService
    }
    
    public func getPokemonDetail(
        name: String,
        onfinish:@escaping ((PokemonDetailModel?, String?)->Void)
    ) {
        self.pokemonsService.getPokemonDetail(pokemon: name) { success, results, error in
            
            if success,let pokemon = results {
                let response = self.fetchData(detail: pokemon)
                onfinish(response, nil)
            } else {
                onfinish(nil, error!)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func fetchData(detail pokemon: PokemonDetailModel) -> PokemonDetailModel {
        self.pokemonDetail = pokemon // Cache
        return self.pokemonDetail
    }
}
