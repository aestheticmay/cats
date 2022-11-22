//
//  AppDelegate.swift
//  cats
//
//  Created by Майя Калицева on 14.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        configureControllers()
        
        return true
    }
    
    private func configureControllers() {
        let searchVC = SearchViewController()
      //  let detailsVC = DetailsViewController()
        let navigationSearch = UINavigationController(rootViewController: searchVC)
     //   let navigationDetails = UINavigationController(rootViewController: detailsVC)
        
        let tabBarController = UITabBarController()
        navigationSearch.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        tabBarController.tabBar.backgroundColor = UIColor.white
     //   navigationDetails.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 1)
        
        tabBarController.viewControllers = [navigationSearch]
        window?.rootViewController = tabBarController
    }
}

