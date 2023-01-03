
import UIKit
import Realm

protocol AuthorizerProtocol {
    func authorize(login: String, password: String) throws -> User
}

enum AuthorizationError : Error {
    case userNotFound
    case userNotAuthorized
}

class Authorizer : AuthorizerProtocol {
    
    private init() {
        
    }
    
    public static let shared: Authorizer = .init()
    
    func authorize(login: String, password: String) throws -> User {
        if (login == "Slava" && password == "123") {
            let user = User(login: login, password: password, fullName: "Vyacheslav Nekrasov")
            return user
        }
        
        if (login == "Vasya") {
            throw AuthorizationError.userNotAuthorized
        }
        
        throw AuthorizationError.userNotFound
    }
    
}
