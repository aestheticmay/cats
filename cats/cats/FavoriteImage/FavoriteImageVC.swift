//
//  FavoriteImageVC.swift
//  cats
//
//  Created by Майя Калицева on 25.10.2022.
//

import UIKit

final class FavoriteImageVC: UIViewController {
    
    // MARK: - Private Properties
    
    // MARK: - Life-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - Private Methods

    private func setupUI() {
        navigationController?.navigationBar.backItem?.title = "Favorite Image"
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .clear
    }
}
