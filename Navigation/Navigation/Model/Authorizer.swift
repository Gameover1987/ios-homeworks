
import Foundation
import UIKit
import FirebaseAuth

protocol AuthorizerProtocol {
    var currentUser: User? {get}
    func checkCredentionals(login: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func signUp(login: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func signOut()
}

class Authorizer : AuthorizerProtocol {
    var currentUser: User? = nil
    
    func signOut() {
        do {
            try Auth.auth().signOut();
        }
        catch let error {
            print(error)
        }
    }
    
    func checkCredentionals(login: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: login, password: password) { result, error in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            
            let user = User(
                UID: result.user.uid,
                login: result.user.email!
            )
            self.currentUser = user
            completion(.success(user))
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
