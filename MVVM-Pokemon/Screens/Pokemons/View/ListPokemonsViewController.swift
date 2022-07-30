//
//  ViewController.swift
//  MVVM-Pokemon
//
//  Created by C330593 on 11/07/22.
//

import UIKit

class ListPokemonsViewController: UIViewController {
    
    lazy var viewModel = {
        PokemonsViewModel()
    }()
    
    // MARK: - IBOutlets
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .clear
        scroll.isScrollEnabled = true
        scroll.bounces = true
        scroll.alwaysBounceVertical = true
        scroll.showsVerticalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var listPokemonsTableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.constraints()
        self.initView()
        self.initViewModel()
    }
    
    // MARK: - Private Methods
    
    private func initView() {
        // TableView customization
        self.listPokemonsTableView.delegate = self
        self.listPokemonsTableView.dataSource = self
        self.listPokemonsTableView.backgroundColor = .white
        self.listPokemonsTableView.separatorColor = .red
        self.listPokemonsTableView.separatorStyle = .singleLine
        self.listPokemonsTableView.tableFooterView = UIView()
        
        self.listPokemonsTableView.register(PokemonCell.nib, forCellReuseIdentifier: PokemonCell.identifier)
    }
    
    private func initViewModel() {
        self.viewModel.getPokemons()
        self.viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.listPokemonsTableView.reloadData()
            }
        }
    }
    
    private func constraints() -> Void {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.listPokemonsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        /// TitleLabel
        view.addSubview(self.titleLabel)
        self.titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        self.titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        self.titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        /// Scroll View
        view.addSubview(self.scrollView)
        self.scrollView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 24).isActive = true
        self.scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50).isActive = true
        
        /// Table
        self.scrollView.addSubview(self.listPokemonsTableView)
        self.listPokemonsTableView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0.0).isActive = true
        self.listPokemonsTableView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        self.listPokemonsTableView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor).isActive = true
        self.listPokemonsTableView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        self.listPokemonsTableView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        
    }
}

// MARK: - UITableViewDelegate

extension ListPokemonsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - UITableViewDataSource

extension ListPokemonsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.pokemonsCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PokemonCell.identifier,
            for: indexPath
        ) as? PokemonCell else { fatalError("xib does not exists") }
        
        let cellVM = self.viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let pokemonSelected = self.viewModel.pokemonsCellViewModels[index]
        
        self.performSegue(withIdentifier: "DetailPokemon", sender: pokemonSelected)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailPokemon" {
            let pokemonSelected = sender as! PokemonsCellViewModel
            let screenDetailPokemon: DetailPokemonViewController = segue.destination as! DetailPokemonViewController
            
            screenDetailPokemon.pokemon = pokemonSelected
        }
    }
    
}

extension ListPokemonsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            
            self.viewModel.getPokemons(next: "https://pokeapi.co/api/v2/pokemon?offset=\(self.viewModel.pokemonsCellViewModels.count)&limit=10")
            self.viewModel.reloadTableView = { [weak self] in
                DispatchQueue.main.async {
                    self?.listPokemonsTableView.reloadData()
                }
            }
            
        }
    }
}
