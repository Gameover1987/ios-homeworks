
import UIKit

final class FavoritesCoordinator : Coordinator {
    var childCoordinators = [Coordinator]()
    var isCompleted: (() -> Void)?
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = FavoritesViewModel(favoriteStorage: CoreDataFavoritePublicationsStorage.shared)
        let viewController = FavoritesViewController(viewModel: viewModel)
        
        navigationController.setViewControllers([viewController], animated: true)
    }
}
