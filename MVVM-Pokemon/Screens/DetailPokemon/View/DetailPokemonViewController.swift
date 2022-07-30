//
//  DetailPokemonViewController.swift
//  MVVM-Pokemon
//
//  Created by C330593 on 11/07/22.
//

import Foundation
import UIKit


class DetailPokemonViewController: UIViewController {
    
    lazy var viewModel = {
        PokemonDetailViewModel()
    }()
    
    // MARK: - Private Variables
    
    public var pokemon: PokemonsCellViewModel? = nil
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    @IBOutlet weak var experienciaLabel: UILabel!
    @IBOutlet weak var alturaLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var pesoLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initViewModel()
    }
    
    // MARK: - Private Methods
    
    private func initViewModel() {
        self.viewModel.getPokemonDetail(name: pokemon!.name) { (result: PokemonDetailModel?, error: String?) in
            
            guard let detail = result else {
                // Mostrar error
                return
            }

            self.pokemonImageView.downloaded(from: detail.sprites.frontDefault)
            
            DispatchQueue.main.async {
                self.nameLabel.text = detail.name
                self.experienciaLabel.text = String(detail.baseExperience) 
                self.alturaLabel.text = String(detail.height)
                self.areaLabel.text = detail.locationAreaEncounters
                self.pesoLabel.text = String(detail.weight)
            }
        }
    }
}
