
import CoreData
import StorageService

protocol FavoriteStorageProtocol {
    
    var publications: [PublicationEntity] {get}
    
    func addToFavorites(post: Post) -> PublicationEntity
    
    func removeFromfavorites(publication: PublicationEntity)
}
