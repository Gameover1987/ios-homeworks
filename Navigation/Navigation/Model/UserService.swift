
import Foundation

public protocol UserService {
    func getUser(login : String) -> User?
}
