
import CoreData
import StorageService

final class CoreDataFavoritePublicationsStorage : FavoriteStorageProtocol {
    
    static let shared = CoreDataFavoritePublicationsStorage()
    
    private var searchString: String = ""
    
    private lazy var mainContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()
    
    private init() {
        fetchPublications()
    }
    
    var publications: [PublicationEntity] = []
    
    func applyFilter(searchString: String) {
        self.searchString = searchString
        fetchPublications()
    }
    
    func addToFavorites(post: Post) {
        
        if isPublicationExists(author: post.author, text: post.description) {
            return
        }
        
        let publication = PublicationEntity(context: backgroundContext)
        publication.createdAt = Date()
        publication.text = post.description
        publication.author = post.author
        publication.imageData = post.image.pngData() ?? Data()
        
        saveBackgroundContext()
        
        fetchPublications()
    }
    
    func removeFromfavorites(publication: PublicationEntity) {
        
    }
    
    private func isPublicationExists(author: String, text: String) -> Bool {
        let request = PublicationEntity.fetchRequest()
        request.fetchLimit =  1
        request.predicate = NSPredicate(format: "author == %@", author)
        request.predicate = NSPredicate(format: "text == %@", text)

        do {
            let count = try backgroundContext.count(for: request)
            return count > 0
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    private func fetchPublications() {
        let request = PublicationEntity.fetchRequest()
        if !self.searchString.isEmpty {
            request.predicate = NSPredicate(format: "author contains[c] %@", searchString)
        }
        
        do {
            request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
            publications = try mainContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Navigation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private func saveMainContext () {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error in main context \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func saveBackgroundContext() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error in background context \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
