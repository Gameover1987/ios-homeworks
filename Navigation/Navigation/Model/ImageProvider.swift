
import Foundation
import UIKit

protocol UserImageProviderProtocol {
    func getUserImageBy(name: String) -> Result<UIImage, ImageDownloadError>
}

enum ImageDownloadError : Error {
    case imageNotFound
}

class ImageProvider : UserImageProviderProtocol {
    
    private init() {
        
    }
    
    public static let shared: ImageProvider = .init()
    
    func getUserImageBy(name: String) -> Result<UIImage, ImageDownloadError> {
        
        guard let image = UIImage(named: name) else {
            return Result.failure(.imageNotFound)
        }
        
        return Result.success(image)
    
    }
}
