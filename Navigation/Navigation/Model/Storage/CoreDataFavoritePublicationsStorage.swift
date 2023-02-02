
import CoreData
import StorageService

final class CoreDataFavoritePublicationsStorage : FavoriteStorageProtocol {
    
    static let shared = CoreDataFavoritePublicationsStorage()
    
    private init() {
        
    }
    
    func addToFavorites(post: Post) {
        persistentContainer.performBackgroundTask {[weak self] context in
            guard let self = self else { return }
            let publication = self.getOrCreatePublication(post: post, in: context)
            self.save(in: context)
        }
    }
    
    func removeFromfavorites(publication: PublicationEntity) {
        persistentContainer.viewContext.delete(publication)
      
        try! persistentContainer.viewContext.save()
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private func getOrCreatePublication(post: Post, in context: NSManagedObjectContext) -> PublicationEntity {
        let request = PublicationEntity.fetchRequest()
        request.predicate = NSPredicate(format: "author == %@ AND text == %@", post.author, post.description)
        
        if let publicationEntity = (try? context.fetch(request))?.first {
            return publicationEntity
        }
        else {
            let publicationEntity = PublicationEntity(context: context)
            publicationEntity.author = post.author
            publicationEntity.createdAt = Date()
            publicationEntity.text = post.description
            publicationEntity.imageData = post.image.pngData() ?? Data()
            
            return publicationEntity
        }
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Navigation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()

    private func save(in context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
