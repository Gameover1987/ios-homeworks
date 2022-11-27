
import Foundation
import UIKit

final class PhotosCoordinator : Coordinator {
    
    var childCoordinators = [Coordinator]()
    var isCompleted: (() -> Void)?
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
}
