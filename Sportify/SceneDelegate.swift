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
        window = UIWindow(windowScene: windowScene)

        let splashVC = SplashViewController(nibName: "SplashViewController", bundle: nil)
        window?.rootViewController = splashVC
        window?.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showMainApp()
        }
    }
    private func showMainApp() {

        let tabBarController = UITabBarController()

        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let favoriteVC = FavoriteTableViewController(nibName: "FavoriteTableViewController", bundle: nil)
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        favoriteVC.tabBarItem = UITabBarItem(title: "Favourite", image: UIImage(systemName: "heart.fill"), tag: 1)

        tabBarController.viewControllers = [homeVC, favoriteVC]
        tabBarController.tabBar.tintColor = .label
        tabBarController.tabBar.unselectedItemTintColor = .lightGray

        let navController = UINavigationController(rootViewController: tabBarController)
        navController.navigationBar.tintColor = .label
        navController.navigationBar.barTintColor = .systemBackground

        window?.rootViewController = navController
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

