
import CoreData
import StorageService

final class CoreDataFavoritePublicationsStorage : FavoriteStorageProtocol {
    
    static let shared = CoreDataFavoritePublicationsStorage()
    
    private init() {
        fetchPublications()
    }
    
    var publications: [PublicationEntity] = []
    
    func addToFavorites(post: Post) -> PublicationEntity {
        let publication = PublicationEntity(context: persistentContainer.viewContext)
        publication.createdAt = Date()
        publication.text = post.description
        publication.author = post.author
        publication.imageData = post.image.pngData() ?? Data()
        saveContext()
        fetchPublications()
        
        return publication
    }
    
    func removeFromfavorites(publication: PublicationEntity) {
        
    }
    
    private func fetchPublications() {
        let request = PublicationEntity.fetchRequest()
        do {
            request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
            publications = try persistentContainer.viewContext.fetch(request)
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

    private func saveContext () {
        let context = persistentContainer.viewContext
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
