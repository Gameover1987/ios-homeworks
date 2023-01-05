
import CoreData
import StorageService

protocol FavoriteStorageProtocol {
    
    var publications: [PublicationEntity] {get}
    
    func applyFilter(searchString: String)
    
    func addToFavorites(post: Post)
    
    func removeFromfavorites(publication: PublicationEntity)
}
