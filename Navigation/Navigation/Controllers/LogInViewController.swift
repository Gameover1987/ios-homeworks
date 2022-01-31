
import Foundation
import UIKit

class LogInViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(vkLogo)
        contentView.addSubview(inputFieldStackView)
        contentView.addSubview(logInButton)
        inputFieldStackView.addArrangedSubview(loginInputTextField)
        inputFieldStackView.addArrangedSubview(passwordInputTextField)
        
        activateConstraints()
    }
    
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
        loginTextFileld.attributedPlaceholder = NSAttributedString(string: "Email of phone", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        loginTextFileld.font = .systemFont(ofSize: 16.0)
        loginTextFileld.tintColor = UIColor(named: "colorBaseVK")
        loginTextFileld.autocapitalizationType = .none
        loginTextFileld.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        loginTextFileld.leftViewMode = .always
        loginTextFileld.layer.borderWidth = 0.5
        loginTextFileld.layer.borderColor = UIColor.lightGray.cgColor
        loginTextFileld.translatesAutoresizingMaskIntoConstraints = false
        return loginTextFileld
    }()
    
    private var passwordInputTextField: UITextField = {
        let passworfTextFileld = UITextField()
        passworfTextFileld.backgroundColor = .systemGray6.withAlphaComponent(0.1)
        passworfTextFileld.textColor = .black
        passworfTextFileld.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        passworfTextFileld.font = .systemFont(ofSize: 16.0)
        passworfTextFileld.tintColor = UIColor(named: "vkColor")
        passworfTextFileld.autocapitalizationType = .none
        passworfTextFileld.isSecureTextEntry = true
        passworfTextFileld.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        passworfTextFileld.leftViewMode = .always
        passworfTextFileld.translatesAutoresizingMaskIntoConstraints = false
        return passworfTextFileld
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
        //button.addTarget(nil, action: #selector(buttonLogInAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            vkLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120.0),
            vkLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vkLogo.widthAnchor.constraint(equalToConstant: 100),
            vkLogo.heightAnchor.constraint(equalToConstant: 100),
            
            inputFieldStackView.topAnchor.constraint(equalTo: vkLogo.bottomAnchor, constant: 120),
            inputFieldStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            inputFieldStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            inputFieldStackView.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.topAnchor.constraint(equalTo: inputFieldStackView.bottomAnchor, constant: 16.0),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            logInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
