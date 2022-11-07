//
//  UIImageView-extension.swift
//  cats
//
//  Created by Майя Калицева on 07.11.2022.
//

import UIKit


extension UIImageView {
    
    func loadImage(url: URL?) {
        guard let path = url else {
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: path),
                  let image = UIImage(data: imageData) else {
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
 
