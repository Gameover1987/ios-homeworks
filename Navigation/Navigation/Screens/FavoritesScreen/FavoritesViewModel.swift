
import CoreData

final class FavoritesViewModel : NSObject {
    
    private var favoriteStorage: FavoriteStorageProtocol
    private var fetchedResultsController: NSFetchedResultsController<PublicationEntity>!
    
    init (favoriteStorage: FavoriteStorageProtocol) {
        
        self.favoriteStorage = favoriteStorage
    
        super.init()
        
        self.fetchedResultsController = createFetchedResultsController(byFilter: "")
    }
    
    var insertRowsAction: ((_ newIndexPath: IndexPath) -> Void)?
    var deleteRowsAction: ((_ indexPath: IndexPath) -> Void)?
    var moveRowAction: ((_ indexPath: IndexPath, _ newIndexPath: IndexPath) -> Void)?
    var updateRowsAction: ((_ indexPath: IndexPath) -> Void)?
    
    var publicationsCount: Int {
        let count = fetchedResultsController.sections?[0].numberOfObjects ?? 0
        return count
    }
    
    func applyFilter(filter: String) {
        self.fetchedResultsController = createFetchedResultsController(byFilter: filter)
    }
    
    func getPublication(at indexPath: IndexPath) -> PublicationEntity {
        return fetchedResultsController.object(at: indexPath)
    }
    
    func removePublication(publication: PublicationEntity) {
        favoriteStorage.removeFromfavorites(publication: publication)
    }
    
    private func createFetchedResultsController(byFilter searchString: String) -> NSFetchedResultsController<PublicationEntity> {
        let request = PublicationEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        if searchString != "" {
            request.predicate = NSPredicate(format: "author contains[c] %@", searchString)
        }

        let controller = NSFetchedResultsController(fetchRequest: request,
                                                    managedObjectContext: CoreDataFavoritePublicationsStorage.shared.context,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        do {
            try controller.performFetch()
        }
        catch {
           print(error)
        }
        
        controller.delegate = self
        
        return controller
    }
}

extension FavoritesViewModel : NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            insertRowsAction?(newIndexPath)
            
        case .delete:
            guard let indexPath = indexPath else { return }
            deleteRowsAction?(indexPath)
            
        case .move:
            guard let indexPath = indexPath else { return }
            guard let newIndexPath = newIndexPath else {return}
            moveRowAction?(indexPath, newIndexPath)
            
        case.update:
            guard let indexPath = indexPath else { return }
            updateRowsAction?(indexPath)
            
        @unknown default:
            print("Unknown fetch action!")
        }
    }
}
