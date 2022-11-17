//
//  UITableViewCell-extension.swift
//  cats
//
//  Created by Майя Калицева on 07.11.2022.
//

import UIKit

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
}
