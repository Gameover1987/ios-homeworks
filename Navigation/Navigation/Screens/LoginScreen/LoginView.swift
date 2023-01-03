
import Foundation
import UIKit

public class LoginView : UIView {
    
    private let imageWidth = 100.0
    private let imageHeight = 100.0
    private let imageTopMargin = 120.0
    private let imageBottomMargin = 120.0
    private let loginPasswordStackHeight = 100.0
    private let buttonHeight = 50.0
    private let defaultSideMargin = 16.0
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private var vkLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vk_logo")!
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var loginInputTextField: UITextField = {
        let loginTextFileld = UITextField()
        loginTextFileld.backgroundColor = .systemGray6.withAlphaComponent(0.1)
        loginTextFileld.textColor = .black
        loginTextFileld.attributedPlaceholder = NSAttributedString(string: "Email or phone", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        loginTextFileld.font = .systemFont(ofSize: 16.0)
        loginTextFileld.tintColor = UIColor(named: "vkColor")
        loginTextFileld.autocapitalizationType = .none
        loginTextFileld.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        loginTextFileld.leftViewMode = .always
        loginTextFileld.layer.borderWidth = 0.5
        loginTextFileld.layer.borderColor = UIColor.lightGray.cgColor
        loginTextFileld.translatesAutoresizingMaskIntoConstraints = false
        return loginTextFileld
    }()
    
    private var passwordInputTextField: UITextField = {
        let passwordTextFileld = UITextField()
        passwordTextFileld.backgroundColor = .systemGray6.withAlphaComponent(0.1)
        passwordTextFileld.textColor = .black
        passwordTextFileld.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        passwordTextFileld.font = .systemFont(ofSize: 16.0)
        passwordTextFileld.tintColor = UIColor(named: "vkColor")
        passwordTextFileld.autocapitalizationType = .none
        passwordTextFileld.isSecureTextEntry = true
        passwordTextFileld.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        passwordTextFileld.leftViewMode = .always
        passwordTextFileld.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextFileld
    }()
    
    private var inputFieldStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.layer.cornerRadius = 10
        stack.layer.borderWidth = 0.5
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.spacing = 0.5
        stack.clipsToBounds = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor.init(named: "vkColor")
        button.layer.cornerRadius = 10
        button.addTarget(nil, action: #selector(buttonLogInAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var loginRequest: ((_ login: String, _ password: String) -> ())?
    
    func setUserData(user: User) {
        loginInputTextField.text = user.login
        passwordInputTextField.text = user.password
    }
    
    func arrange(parentView: UIView) {
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(vkLogo)
        contentView.addSubview(inputFieldStackView)
        contentView.addSubview(logInButton)
        inputFieldStackView.addArrangedSubview(loginInputTextField)
        inputFieldStackView.addArrangedSubview(passwordInputTextField)
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor),
            leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor),
            bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            vkLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: imageTopMargin),
            vkLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vkLogo.widthAnchor.constraint(equalToConstant: imageWidth),
            vkLogo.heightAnchor.constraint(equalToConstant: imageHeight),
            
            inputFieldStackView.topAnchor.constraint(equalTo: vkLogo.bottomAnchor, constant: imageBottomMargin),
            inputFieldStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultSideMargin),
            inputFieldStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultSideMargin),
            inputFieldStackView.heightAnchor.constraint(equalToConstant: loginPasswordStackHeight),
            
            logInButton.topAnchor.constraint(equalTo: inputFieldStackView.bottomAnchor, constant: defaultSideMargin),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultSideMargin),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultSideMargin),
            logInButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    func handleShowKeyboard(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.convert(keyboardFrame, from: nil)
        var contentInset: UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }
    
    func handleHideKeyboard(_ notification: NSNotification) {
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    @objc private func buttonLogInAction() {
        let login = loginInputTextField.text!
        let password = passwordInputTextField.text!
        
        loginRequest?(login, password)
    }
}
