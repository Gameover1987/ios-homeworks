
import Foundation

final class FavoritesViewModel {
    
    private let favoriteStorage: FavoriteStorageProtocol
    
    init (favoriteStorage: FavoriteStorageProtocol) {
        self.favoriteStorage = favoriteStorage
    }
    
    var publications: [PublicationEntity] {
        
        favoriteStorage.applyFilter(searchString: searchString)
        
        return favoriteStorage.publications
    }
    
    var searchString: String = ""
    
    func removePublication(publication: PublicationEntity) {
        favoriteStorage.removeFromfavorites(publication: publication)
    }
}
