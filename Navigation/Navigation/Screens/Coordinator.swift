
import Foundation

public protocol Coordinator : AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var isCompleted: (() -> Void)? { get set }
    
    func start()
}

extension Coordinator {
    func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func release(coordinator: Coordinator?) {
        if let coordinator = coordinator {
            childCoordinators = childCoordinators.filter { $0 !== coordinator }
        }
    }
}
