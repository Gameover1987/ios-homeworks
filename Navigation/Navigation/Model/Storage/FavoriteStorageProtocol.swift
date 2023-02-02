
import CoreData
import StorageService

protocol FavoriteStorageProtocol {
    
    func addToFavorites(post: Post)
    
    func removeFromfavorites(publication: PublicationEntity)
    
    var context: NSManagedObjectContext {get}
}
