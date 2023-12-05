//
//  UIImageView.swift
//  UIKitVIPStudy
//
//  Created by Marcelo de Araújo on 05/12/2023.
//

import UIKit

extension UIImageView {
    
    func load(url: String) {
        DispatchQueue.global().async { [weak self] in
            guard let url = URL(string: url),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
}
