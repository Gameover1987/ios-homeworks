import Foundation
import UIKit

public class ProfileConstraints {
    public static let imageWidth = 130.0
    public static let imageHeight = 130.0
    public static let defaultMargin = 16.0
    public static let headerMargin = 27.0
}

public class ProfileHeaderView : UIView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImage)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(setStatusButton)
        
        NSLayoutConstraint.activate([
            profileImage.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: ProfileConstraints.defaultMargin),
            profileImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: ProfileConstraints.defaultMargin),
            profileImage.widthAnchor.constraint(equalToConstant: ProfileConstraints.imageWidth),
            profileImage.heightAnchor.constraint(equalToConstant: ProfileConstraints.imageHeight),
            
            fullNameLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: ProfileConstraints.defaultMargin),
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: ProfileConstraints.headerMargin),
            fullNameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),

            statusLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 16),
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 30),
            statusLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),

            statusTextField.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 16),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 4),
            statusTextField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            setStatusButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            setStatusButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16),
            setStatusButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor,constant: 0),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUser(user : User) {
        profileImage.image = user.avatar
        statusLabel.text = user.status
        fullNameLabel.text = user.fullName
    }
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 65
        imageView.clipsToBounds = true
        
        imageView.image = UIImage(named: "Ava")
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Check, mate, rock'n'roll!"
        label.font =  UIFont.boldSystemFont(ofSize: 18)
        label.toAutoLayout()
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.font =  UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.toAutoLayout()
        return label
    }()
    
    private let statusTextField: UITextFieldWithPadding = {
        var textField = UITextFieldWithPadding()
        
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        
        textField.addTarget(self, action: #selector(statusTextChanged(_ :)), for: .editingChanged)
        textField.toAutoLayout()
        return textField
    }()
    
    private let setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Set status", for: .normal)
        button.backgroundColor = UIColorUtils.CreateFromRGB(red: 0, green: 146, blue: 249)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        button.toAutoLayout()
        return button
    }()
    
    private var statusText: String?
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text
        print("Status text is \(statusText ?? "")")
    }
    
    @objc func buttonPressed() {
        statusLabel.text = statusText
    }
}
