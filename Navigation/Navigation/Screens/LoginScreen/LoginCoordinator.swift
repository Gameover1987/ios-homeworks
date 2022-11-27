
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
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        
        loginViewModel.goToProfileAction = { [weak self] in
            self?.showMainTabBar()
        }
        
        rootViewController.setViewControllers([loginViewController], animated: true)
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    private func showMainTabBar() {
        tabBarController.setViewControllers(
            [configureProfileCoordinator(), configureFeedCoordinator(),],
            animated: false
        )
        
        guard let tabBarItems = tabBarController.tabBar.items else {
            return
        }
        
        for (index, item) in tabBarItems.enumerated() {
            switch index {
            case 0:
                item.image = UIImage(systemName: "house")
            case 1:
                item.image = UIImage(systemName: "person")
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
}
