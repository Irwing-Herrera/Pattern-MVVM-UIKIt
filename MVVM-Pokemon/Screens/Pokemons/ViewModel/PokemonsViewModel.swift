//
//  PokemonsViewModel.swift
//  MVVM-Pokemon
//
//  Created by C330593 on 11/07/22.
//

import Foundation

class PokemonsViewModel: NSObject {
    
    // MARK: - Private Variables
    
    private var pokemonsService: PokemonServiceProtocol
    
    // MARK: - Public Variables
    
    public var reloadTableView: (() -> Void)?
    public var pokemons: PokemonModel = PokemonModel(count: 0, next: "", previous: "", results: [])
    public var pokemonsCellViewModels = [PokemonsCellViewModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    
    // MARK: - Public Methods
    
    public init(pokemonsService: PokemonServiceProtocol = PokemonsService()) {
        self.pokemonsService = pokemonsService
    }
    
    public func getPokemons(next: String = Constants.GET_POKEMONS) {
        self.pokemonsService.getPokemons(url: next) { success, results, error in
            
            if success,let pokemons = results {
                if next == Constants.GET_POKEMONS {
                    self.fetchData(pokemons: pokemons)
                } else {
                    self.fetchDataAddRows(pokemons: pokemons)
                }
            } else {
                debugPrint("❌ \(error!)")
            }
        }
    }
    
    public func getCellViewModel(at indexPath: IndexPath) -> PokemonsCellViewModel {
        return self.pokemonsCellViewModels[indexPath.row]
    }
    
    // MARK: - Private Methods
    
    private func fetchData(pokemons: PokemonModel) {
        self.pokemons = pokemons // Cache
        var vms = [PokemonsCellViewModel]()
        for pokemon in self.pokemons.results {
            vms.append(self.createCellModel(pokemon: pokemon))
        }
        self.pokemonsCellViewModels = vms
    }
    
    private func fetchDataAddRows(pokemons: PokemonModel) {
        self.pokemons = pokemons // Cache
        var vms = [PokemonsCellViewModel]()
        for pokemon in self.pokemons.results {
            vms.append(self.createCellModel(pokemon: pokemon))
        }
        self.pokemonsCellViewModels.append(contentsOf: vms)
    }
    
    private func createCellModel(pokemon: Result) -> PokemonsCellViewModel {
        let name = pokemon.name
        let url = pokemon.url
        
        return PokemonsCellViewModel(name: name, url: url)
    }
}
