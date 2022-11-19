
import UIKit

class FeedViewController: UIViewController {
    
    private let secretWordChecker: FeedProtocol
    
    private lazy var showPostButton: CustomButton = {
        let button = CustomButton(title: "Show post")
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        
        button.touchButtonAction = openPostButtonAction
        button.toAutoLayout()
        return button
    }()
    
    private lazy var secretWordTextField: UITextFieldWithPadding = {
        let textField = UITextFieldWithPadding()
        textField.backgroundColor = .systemGray6.withAlphaComponent(0.1)
        textField.textColor = .black
        
        textField.attributedPlaceholder = NSAttributedString(string: "Secret word", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        
        textField.addTarget(self, action: #selector(secretWordChanged(_ :)), for: .editingChanged)
        
        textField.toAutoLayout()
        return textField
    }()
    
    private lazy var checkWordLabel: UILabel = {
        let label = UILabel()
        label.text = "Check result will be here..."
        label.font =  UIFont.systemFont(ofSize: 20)
        label.textColor = .gray
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(title: "Check guess")
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        
        button.setTitleColor(.white, for: .disabled)
        
        button.touchButtonAction = checkGuessAction
        button.toAutoLayout()
        
        return button
    }()
    
    init(secretWordChecker: FeedProtocol) {
        self.secretWordChecker = secretWordChecker
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(showPostButton)
        view.addSubview(secretWordTextField)
        view.addSubview(checkWordLabel)
        view.addSubview(checkGuessButton)
        
        NSLayoutConstraint.activate([
            showPostButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            showPostButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            showPostButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            showPostButton.heightAnchor.constraint(equalToConstant: 50),
            
            secretWordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            secretWordTextField.topAnchor.constraint(equalTo: showPostButton.bottomAnchor, constant: 100),
            secretWordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            secretWordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            checkWordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            checkWordLabel.topAnchor.constraint(equalTo: secretWordTextField.bottomAnchor, constant: 16),
            checkWordLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            checkWordLabel.heightAnchor.constraint(equalToConstant: 50),
            
            checkGuessButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            checkGuessButton.topAnchor.constraint(equalTo: checkWordLabel.bottomAnchor, constant: 16),
            checkGuessButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        setButtonState(isEnabled: false)
    }
    
    @objc func openPostButtonAction() {
        let postViewController = PostViewController()
        postViewController.title = "Post"
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    @objc func checkGuessAction() {
        guard let secretWord = secretWordTextField.text else {
            checkGuessButton.isEnabled = false
            return
        }
        
        if (secretWordChecker.check(word: secretWord)) {
            checkWordLabel.text = "Guess!"
            checkWordLabel.textColor = .systemGreen
        } else {
            checkWordLabel.text = "Didn't guess!"
            checkWordLabel.textColor = .systemRed
        }
    }
    
    @objc func secretWordChanged(_ textField: UITextField){
    
        guard let text = textField.text else {
            checkGuessButton.isEnabled = false
            return
        }
        
        let isEnabled = !text.isEmpty
        checkGuessButton.isEnabled = isEnabled
        
        setButtonState(isEnabled: isEnabled)
    }
    
    private func setButtonState(isEnabled: Bool) {
        if (!isEnabled) {
            checkGuessButton.backgroundColor = .systemGray
        } else{
            checkGuessButton.backgroundColor = .systemGreen
        }
    }
}
