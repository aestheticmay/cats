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
        window?.rootViewController = DetailsViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

