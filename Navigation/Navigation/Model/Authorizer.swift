
import Foundation
import UIKit

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
        if (login == "123") {
            return User(login: "123", fullName: "Vyacheslav Nekrasov")
        }
        
        if (login == "Vasya") {
            throw AuthorizationError.userNotAuthorized
        }
        
        throw AuthorizationError.userNotFound
    }
    
}
