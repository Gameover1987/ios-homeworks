
import Foundation

protocol UserProviderProtocol {
    
    func getStoredUser() -> User?
    
    func storeUser(user: User)
}
