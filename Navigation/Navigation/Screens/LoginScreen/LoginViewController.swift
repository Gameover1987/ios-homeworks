
import Foundation
import UIKit

class LoginViewController : UIViewController {
    
    var loginView: LoginView!
    
    private let viewModel: LoginViewModel
    private let authorizer: AuthorizerProtocol
    
    init (viewModel: LoginViewModel, authorizer: AuthorizerProtocol) {
        self.viewModel = viewModel
        self.authorizer = authorizer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        loginView = LoginView()
        loginView.loginRequest = { (login: String, password: String) in
            self.performAuthorization(login, password)
        }
        loginView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginView)
   
        loginView.arrange(parentView: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.willShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.willHideKeyboard(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func willShowKeyboard(_ notification: NSNotification) {
        loginView.handleShowKeyboard(notification)
    }

    @objc fileprivate func willHideKeyboard(_ notification: NSNotification) {
        loginView.handleHideKeyboard(notification)
    }
    
    private func performAuthorization (_ login: String, _ password: String) {
        
        do {
            try authorizer.authorize(login: login, password: password)
            self.viewModel.goToProfileAction?()
        } catch AuthorizationError.userNotFound {
            showAlert(title: "Auth error", message: "User not found!")
        } catch AuthorizationError.userNotAuthorized {
            showAlert(title: "Auth error", message: "User not authorized!")
        }
        catch {
            fatalError("Unknown authorization error!")
        }
    }
}

extension UIViewController {
    func showAlert(title: String, message: String) {
//        let buttonOK = { (_: UIAlertAction) -> Void in print("OK button pressed") }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
