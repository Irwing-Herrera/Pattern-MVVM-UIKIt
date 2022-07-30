//
//  PokemonCell.swift
//  MVVM-Pokemon
//
//  Created by C330593 on 11/07/22.
//

import UIKit

class PokemonCell: UITableViewCell {
    
    private let view: UIView = {
        let vw = UIView()
        vw.backgroundColor = .white
        vw.layer.cornerRadius = 5
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Nombre:"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let nameResultLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let urlLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Url:"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let urlResultLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // MARK: - Variables Class
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    // MARK: - Public Variables
    
    var cellViewModel: PokemonsCellViewModel? {
        didSet {
            self.nameResultLabel.text = cellViewModel?.name.uppercased()
            self.urlResultLabel.text = cellViewModel?.url.lowercased()
        }
    }
    
    // MARK: - Override UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.nameResultLabel.text = nil
        self.urlResultLabel.text = nil
    }
    
    // MARK: - Private Methods
    
    private func initView() -> Void {
        // Cell view customization
        backgroundColor = .clear
        
        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        
        self.contraints()
    }
    
    private func contraints() -> Void {
        
        self.addSubview(self.view)
        
        
        self.view.addSubview(self.nameLabel)
        self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        self.nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        self.nameLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.nameLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.view.addSubview(self.nameResultLabel)
        self.nameResultLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        self.nameResultLabel.leftAnchor.constraint(equalTo: self.nameLabel.rightAnchor, constant: 24).isActive = true
        self.nameResultLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
                
        self.view.addSubview(self.urlLabel)
        self.urlLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 10).isActive = true
        self.urlLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        self.urlLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.view.addSubview(self.urlResultLabel)
        self.urlResultLabel.topAnchor.constraint(equalTo: self.nameResultLabel.bottomAnchor, constant: 10).isActive = true
        self.urlResultLabel.leftAnchor.constraint(equalTo: self.urlLabel.rightAnchor, constant: 24).isActive = true
        self.urlResultLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
}
