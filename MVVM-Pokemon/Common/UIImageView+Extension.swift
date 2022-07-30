//
//  UIImageView+Extension.swift
//  MVVM-Pokemon
//
//  Created by C330593 on 11/07/22.
//

import UIKit

extension UIImageView {
    
    // MARK: - Public Methods
    
    public func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        self.downloaded(from: url, contentMode: mode)
    }
    
    // MARK: - Private Methods
    
    private func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        DispatchQueue.main.async {
            self.contentMode = mode
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
