
import Foundation

final class FavoritesViewModel {
    
    private let favoriteStorage: FavoriteStorageProtocol
    
    init (favoriteStorage: FavoriteStorageProtocol) {
        self.favoriteStorage = favoriteStorage
    }
    
    var publications: [PublicationEntity] {
        return favoriteStorage.publications
    }
}
