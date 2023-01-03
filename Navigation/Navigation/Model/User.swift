
import Foundation
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

protocol UserProviderProtocol {
    
    func getStoredUser() -> User?
    
    func storeUser(user: User)
}


final class UserProvider : UserProviderProtocol {
    
    public static let shared = UserProvider()
    
    private init () {
        let config = Realm.Configuration(schemaVersion: 1)
        Realm.Configuration.defaultConfiguration = config
    }
    
    func getStoredUser() -> User? {
        do {
            let realm = try Realm()
            return realm.objects(User.self).first
        }
        catch {
            print(error)
            return nil
        }
    }
    
    func storeUser(user: User) {
        do {
            let realm = try Realm()
            if realm.objects(User.self).contains(where: {storedUser in
                return storedUser.login == user.login &&
                       storedUser.password == user.password
            }) {
                return
            }
                
            try realm.write {
                realm.add(user)
            }
        }
        catch {
            print(error)
        }
    }
}
