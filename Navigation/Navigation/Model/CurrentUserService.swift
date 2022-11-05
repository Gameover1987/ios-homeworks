
import Foundation
import UIKit

public class CurrentUserService : UserService {
    private let user : User = User(login: "Gamever", avatar: UIImage(named: "Ava")!,status: "Release user")
    
    public func getUser(login: String) -> User? {
        if (login == user.login) {
            return user
        }
        
        return nil
    }
}
