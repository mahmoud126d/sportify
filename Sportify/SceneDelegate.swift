//
//  SceneDelegate.swift
//  Sportify
//
//  Created by Macos on 14/05/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        
        let homeIcon = UIImage(systemName: "house")
        let fvIcon = UIImage(systemName: "heart.fill")
        
        let tabBarController = UITabBarController()
        let tab1 = HomeViewController(nibName: "HomeViewController", bundle: nil)
        
        let tab2 = FavoriteTableViewController(nibName: "FavoriteTableViewController", bundle: nil)
        
        tab1.tabBarItem = UITabBarItem(title: "Home", image: homeIcon, tag: 1)
        tab2.tabBarItem = UITabBarItem(title: "Favourite", image: fvIcon, tag: 2)
        
        let controllers = [tab1, tab2]
        
        tabBarController.viewControllers = controllers
        
        window = UIWindow(windowScene: windowScene)

        let navController = UINavigationController(rootViewController: tabBarController)
        

        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
        
    }
    

    
}

