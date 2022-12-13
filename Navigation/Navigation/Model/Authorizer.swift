
import Foundation
import UIKit
import FirebaseAuth

protocol AuthorizerProtocol {
    func checkCredentionals(login: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func signUp(login: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
}

class Authorizer : AuthorizerProtocol {
    func checkCredentionals(login: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: login, password: password) { result, error in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(User(
                UID: result.user.uid,
                login: result.user.email!
            )))
        }
    }
    
    func signUp(login: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: login, password: password) { result, error in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(User(
                UID: result.user.uid,
                login: result.user.email!
            )))
        }
    }
    
    
    private init() {
        
    }
    
    public static let shared: Authorizer = .init()
}
