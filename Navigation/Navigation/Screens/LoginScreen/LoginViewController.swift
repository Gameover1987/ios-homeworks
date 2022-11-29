
import Foundation
import UIKit

class LoginViewController : UIViewController {
    
    var loginView: LoginView!
    
    private let viewModel: LoginViewModel
    
    private var timerAlert: Timer?
    
    init (viewModel: LoginViewModel) {
        self.viewModel = viewModel

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
        loginView.loginRequest = {
            self.timerAlert?.invalidate()
            self.timerAlert = nil
            self.viewModel.goToProfileAction?()
        }
        loginView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginView)
   
        loginView.arrange(parentView: view)
        
        timerAlert = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: timerAlertHandler(timer:))
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
    
    private func timerAlertHandler(timer: Timer) {
        let buttonOK = { (_: UIAlertAction) -> Void in print("Yes button pressed") }
        let buttonCancel = { (_: UIAlertAction) ->  Void in self.alertContinuation() }
        
        let alert = UIAlertController(title: "Твой телефон", message: "Че стоим? Кого ждем?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да счас я, счас", style: .default, handler: buttonOK))
        alert.addAction(UIAlertAction(title: "А что, кто здесь?", style: .default, handler: buttonCancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func alertContinuation(){
        let buttonOK = { (_: UIAlertAction) -> Void in print("Yes button pressed") }
    
        let alert = UIAlertController(title: "Твой телефон", message: "Это, я твой телефон! Логинься давай!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Уже логинюсь", style: .default, handler: buttonOK))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc fileprivate func willShowKeyboard(_ notification: NSNotification) {
        loginView.handleShowKeyboard(notification)
    }

    @objc fileprivate func willHideKeyboard(_ notification: NSNotification) {
        loginView.handleHideKeyboard(notification)
    }
}
