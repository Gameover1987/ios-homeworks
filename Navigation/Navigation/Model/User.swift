
import RealmSwift

class User : Object {
    @Persisted var login: String
    @Persisted var password: String
    @Persisted var fullName: String
    
    override init() {
       
    }
    
    init (login: String, password: String, fullName: String) {
        self.login = login
        self.password = password
        self.fullName = fullName
    }
}


