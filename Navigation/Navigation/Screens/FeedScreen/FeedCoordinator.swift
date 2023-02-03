
import Foundation
import UIKit

final class FeedCoordinator : Coordinator {
    var childCoordinators = [Coordinator]()
    var isCompleted: (() -> Void)?
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = FeedViewModel()
        let viewController = FeedViewController(viewModel: viewModel)
        viewController.title = FeedScreenLocalizer.title.rawValue.localize(from: .feedDictionary)
        
        viewModel.goToPostAction = { [weak self] in
            self?.showPostScreen()
        }
        
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    private func showPostScreen() {
        let postViewModel = PostViewModel()
        postViewModel.goToInfoAction = { (controller: UIViewController) in
            let infoViewController = InfoViewController()
            let infoNavigationController = UINavigationController(rootViewController: infoViewController)
            controller.present(infoNavigationController, animated: true, completion: nil)
        }
        let postViewController = PostViewController(viewModel: postViewModel)
        postViewController.title = PostScreenLocalizer.title.rawValue.localize(from: .postDictionary)
        
        self.navigationController.pushViewController(postViewController, animated: true)
    }
}
