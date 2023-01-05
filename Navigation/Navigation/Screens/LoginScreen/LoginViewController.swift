
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
        loginView.loginAction = { (login: String, password: String) in
            self.signIn(login, password)
        }
        loginView.signUpAction = { (login: String, password: String) in
            self.signUp(login, password)
        }
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginView)
        
        loginView.arrange(parentView: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (authorizer.currentUser != nil) {
            authorizer.signOut()
            loginView.resetLoginAndPassword()
        }
      
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
    
    private func signIn (_ login: String, _ password: String) {
        
#if DEBUG
        self.viewModel.goToProfileAction?()
#else
      

        
        authorizer.checkCredentionals(login: login, password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                self.viewModel.goToProfileAction?()
                
            case .failure(let error):
                self.showAlert(title: "Sign in error", message: error.localizedDescription)
            }
        }
#endif
    }
    
    private func signUp (_ login: String, _ password: String) {
        authorizer.signUp(login: login, password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.showAlert(title: "Success", message: "User \(user.login) signed up successfully")
                
            case .failure(let error):
                self.showAlert(title: "Sign up error", message: error.localizedDescription)
            }
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
