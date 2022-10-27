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
        let detailsVC = DetailsViewController()
        let registrationVC = RegistrationViewController()
        let navigationDetailsController = UINavigationController(rootViewController: detailsVC)
        let navigationRegController = UINavigationController(rootViewController: registrationVC)
        
        let tabBarController = UITabBarController()
        navigationDetailsController.tabBarItem = UITabBarItem(tabBarSystemItem:.search, tag: 0)
        navigationRegController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        
        tabBarController.viewControllers = [navigationRegController, navigationDetailsController]
        window?.rootViewController = tabBarController
    }
}

