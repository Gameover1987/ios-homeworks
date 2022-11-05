
import Foundation

public final class Checker {
    private let login: String = "Gamever"
    private let password: String = "123"
    
    public static let shared: Checker = .init()
    
    private init() {}
    
    public func check(login: String, password: String) -> Bool {
        return login == self.login && password == self.password
    }
}
