//
//  AppDelegate.swift
//  Navigation
//
//  Created by Вячеслав on 02.12.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Creating chilren viewcontrollers
        let feedViewController = FeedViewController(secretWordChecker: FeedModel.shared)
        feedViewController.title = "Feed"
        
        let myLoginFactory = MyLoginFactory()
        let loginInspector = myLoginFactory.makeLoginInspector()
        
#if DEBUG
        let profileViewController = LoginViewController(userService: TestUserService(), loginDelegate: loginInspector)
#else
        let profileViewController = LoginViewController(userService: CurrentUserService(), loginDelegate: loginInspector)
#endif
       
        profileViewController.title = "Profile"
        
        // Creating tab bar items
        let itemFeedView = UITabBarItem()
        itemFeedView.image = UIImage(systemName: "house")
        let itemProfileView = UITabBarItem()
        itemProfileView.image = UIImage(systemName: "person")
        
        // Connect tab bars with view controllers
        feedViewController.tabBarItem = itemFeedView
        profileViewController.tabBarItem = itemProfileView
       
        // Create navigation tabs
        let feedNavigationController = UINavigationController(rootViewController: feedViewController)
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
            
        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = [profileNavigationController, feedNavigationController]
        tabBarController.selectedViewController = profileNavigationController
        
        window = UIWindow()

        // Connect tab navigation with window
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}
