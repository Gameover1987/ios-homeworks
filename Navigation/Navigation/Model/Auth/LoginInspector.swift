
import Foundation

public class LoginInspector : LoginViewControllerDelegate {
    public func check(login: String, password: String) -> Bool {
        return Checker.shared.check(login: login, password: password)
    }
    
    
}
