
import Foundation

public class LoginViewModel {
    var goToProfileAction: (() -> Void)?
    
    init() {
        print("LoginViewModel")
    }
}
