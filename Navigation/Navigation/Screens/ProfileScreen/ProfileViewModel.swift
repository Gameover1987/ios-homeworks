
import Foundation
import StorageService

final class ProfileViewModel {
    private let dataService: DataService
    var gotToPhotosAction: (() -> Void)?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func getNumberOfPosts() -> Int {
        return dataService.publications.count
    }
    
    func data(for indexPath: IndexPath) -> Post {
        return dataService.publications[indexPath.row]
    }
}
