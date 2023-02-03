
import Foundation
import UIKit

final class LoginCoordinator : Coordinator {
    
    var childCoordinators = [Coordinator]()
    var isCompleted: (() -> Void)?
    
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private let tabBarController: UITabBarController
    
    init (window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        self.tabBarController = UITabBarController()
    }
    
    public func start() {
        
        let loginViewModel = LoginViewModel()
        let authorizer = Authorizer.shared
        let loginViewController = LoginViewController(viewModel: loginViewModel, authorizer: authorizer)
        
        loginViewModel.goToProfileAction = { [weak self] in
            self?.showMainTabBar()
        }
        
        rootViewController.setViewControllers([loginViewController], animated: true)
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    private func showMainTabBar() {
        tabBarController.setViewControllers(
            [configureProfileCoordinator(), configureFeedCoordinator(), configureFavoritePublicationsCoordinator()],
            animated: false
        )
        
        guard let tabBarItems = tabBarController.tabBar.items else {
            return
        }
        
        for (index, item) in tabBarItems.enumerated() {
            switch index {
            case 0:
                item.image = UIImage(systemName: "house")
                item.title = ProfileScreenLocalizer.title.rawValue.localize(from: .profileDictionary)
            case 1:
                item.image = UIImage(systemName: "person")
                item.title = FeedScreenLocalizer.title.rawValue.localize(from: .feedDictionary)
            case 2:
                item.image = UIImage(systemName: "star")
                item.title = FavoritesScreenLocalizer.title.rawValue.localize(from: .favoritesDictionary)
            default:
                break
            }
        }
        
        rootViewController.pushViewController(tabBarController, animated: true)
    }
    
    private func configureFeedCoordinator() -> UINavigationController {
        let navigationController = UINavigationController()
        let feedCoordinator = FeedCoordinator(navigationController: navigationController)
        
        feedCoordinator.isCompleted = { [weak self, weak feedCoordinator] in
            self?.release(coordinator: feedCoordinator)
        }
        
        store(coordinator: feedCoordinator)
        feedCoordinator.start()
        
        return navigationController
    }
    
    private func configureProfileCoordinator() -> UINavigationController {
        let navigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
        
        profileCoordinator.isCompleted = { [weak self, weak profileCoordinator] in
            self?.release(coordinator: profileCoordinator)
        }
        
        store(coordinator: profileCoordinator)
        profileCoordinator.start()
        
        return navigationController
    }
    
    private func configureFavoritePublicationsCoordinator() -> UINavigationController {
        let navigationController = UINavigationController()
        let favoritesCoordinator = FavoritesCoordinator(navigationController: navigationController)
        
        favoritesCoordinator.isCompleted = { [weak self, weak favoritesCoordinator] in
            self?.release(coordinator: favoritesCoordinator)
        }
        
        store(coordinator: favoritesCoordinator)
        favoritesCoordinator.start()
        
        return navigationController
    }
}
