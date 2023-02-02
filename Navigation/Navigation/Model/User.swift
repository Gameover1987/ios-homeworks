
import Foundation

class User {
    var login: String
    var UID: String
    
    init(UID: String, login: String) {
        self.UID = UID
        self.login = login
    }
}
