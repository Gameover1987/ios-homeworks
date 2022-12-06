
import Foundation
import UIKit

final class ProfileCoordinator : Coordinator {
    var childCoordinators = [Coordinator]()
    var isCompleted: (() -> Void)?
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = ProfileViewModel(dataService: DataService.shared)
        let viewController = ProfileViewController(viewModel: viewModel, imageProvider: ImageProvider.shared)
        
        viewModel.gotToPhotosAction = { [weak self] in
            self?.showPhotosScreen()
        }
        
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    private func showPhotosScreen() {
        navigationController.pushViewController(configurePhotosCoordinator(), animated: true)
    }
    
    private func configurePhotosCoordinator() -> UINavigationController {
        let navigationController = UINavigationController()
        let photosCoordinator = PhotosCoordinator(navigationController: navigationController)
        
        photosCoordinator.isCompleted = { [weak self, weak photosCoordinator] in
            self?.release(coordinator: photosCoordinator)
        }
        
        store(coordinator: photosCoordinator)
        photosCoordinator.start()
        
        return navigationController
    }
}
