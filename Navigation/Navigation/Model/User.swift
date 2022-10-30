
import Foundation
import UIKit

public class User {
    public var login : String
    
    public var fullName : String = ""
    
    public var avatar : UIImage!
    
    public var status : String = ""
    
    init(login : String, avatar : UIImage, status: String) {
        self.login = login
        self.avatar = avatar
        self.status = status
    }
}






