
import Foundation
import UIKit

public class TestUserService : UserService {
    
    private let user : User = User(login: "Gamever", avatar: getBlurImage(), status: "Test user")
    
    public func getUser(login: String) -> User? {
        if (login == user.login) {
            return user
        }
        
        return nil
    }
    
    private static func getBlurImage() -> UIImage {
        let image = UIImage(named: "Ava")!
        
        let inputImage = CIImage(cgImage: image.cgImage!)
        
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: "inputImage")
        filter?.setValue(10, forKey: "inputRadius")
        let blurred = filter?.outputImage
        let blurImage = UIImage(ciImage: blurred!)
        return blurImage
    }
    
}
