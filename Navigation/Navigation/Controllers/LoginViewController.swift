
import Foundation
import UIKit

class LoginViewController : UIViewController {
    
    var loginView: LoginView!
    
    var loginDelegate: LoginViewControllerDelegate
    
    private let userService : UserService

    init(userService: UserService, loginDelegate: LoginViewControllerDelegate) {
        self.userService = userService
        self.loginDelegate = loginDelegate
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
        
        loginView.loginRequest = { [self] in
            let user = userService.getUser(login: loginView.getLogin())
            if (user == nil) {
                showLoginAlert()
                return
            }
                
            if (loginDelegate.check(login: user!.login, password: loginView.getPassword())){
                self.navigationController?.pushViewController(ProfileViewController(user: user!), animated: true)
            }
            else {
                showLoginAlert()
            }
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
    
    private func showLoginAlert(){
        let alert = UIAlertController(title: "Вход в систему", message: "Пользователь с такими учетными данными не найден", preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
