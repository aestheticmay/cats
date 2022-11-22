//
//  TabBar.swift
//  cats
//
//  Created by Майя Калицева on 27.10.2022.
//

import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Private Properties
    
    private let searchViewController = SearchViewController()
    private let firstItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    
    private let favoritesViewController = FavoritesViewController()
    private let secondItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
    
    // MARK: - Life-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        tabBar.backgroundColor = UIColor.white
        searchViewController.tabBarItem = firstItem
        favoritesViewController.tabBarItem = secondItem
        viewControllers = [searchViewController, favoritesViewController]
    }
}

