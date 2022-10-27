//
//  TabBar.swift
//  cats
//
//  Created by Майя Калицева on 27.10.2022.
//

import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Private Properties
    
    private let detailsTabBarController = DetailsViewController()
    private let firstTabBarItem = UITabBarItem(title: "Details", image: UIImage(systemName: "pencil.circle"), selectedImage: UIImage(systemName: "pencil.cirle.fill"))
    
    private let secondVC = RegistrationViewController()
    private let secondItem = UITabBarItem(title: "Details", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
    
    // MARK: - Life-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsTabBarController.tabBarItem = firstTabBarItem
        secondVC.tabBarItem = secondItem
        
        viewControllers = [detailsTabBarController, secondVC]
    }
    
    // MARK: - Public Methods
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("selected")
    }
    
}
