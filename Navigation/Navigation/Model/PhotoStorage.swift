
import Foundation

final class PhotoStorage {
    
    public let photos: [Photo] = [Photo("photo1"),
                           Photo("photo2"),
                           Photo("photo3"),
                           Photo("photo4"),
                           Photo("photo5"),
                           Photo("photo6"),
                           Photo("photo7"),
                           Photo("photo8"),
                           Photo("photo9"),
                           Photo("photo10"),
                           Photo("photo11"),
                           Photo("photo12"),
                           Photo("photo13"),
                           Photo("photo14"),
                           Photo("photo15"),
                           Photo("photo16"),
                           Photo("photo17"),
                           Photo("photo18"),
                           Photo("photo19"),
                           Photo("photo20")]
    
    public static let instance: PhotoStorage = .init()
    
    private init() {}
  }
