
import Foundation
import UIKit

public class User {
    public var login : String
    
    public var fullName : String = ""
    
    public var avatar : UIImage!
    
    public var status : String = ""
    
    init(login : String, avatar : UIImage) {
        self.login = login
        self.avatar = avatar
    }
}

public protocol UserService {
    func getUser(login : String) -> User?
}

public class CurrentUserService : UserService {
    private let user : User = User(login: "Gamever", avatar: UIImage(named: "Ava")!)
    
    public func getUser(login: String) -> User? {
        if (login == user.login) {
            return user
        }
        
        return nil
    }
}
