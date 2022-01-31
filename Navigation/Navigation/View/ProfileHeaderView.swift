import Foundation
import UIKit

public class ProfileConstrains {
    public static let imageWidth = 150
    public static let imageHeight = 150
    public static let defaultMargin = 16
    public static let headerMargin = 27
}

public class ProfileHeaderView : UIView {
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        
        imageView.image = UIImage(named: "Ava")
        return imageView
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Check, mate, rock'n'roll"
        label.font =  UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.font =  UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
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
        return button
    }()
    
    public func arrange() {
        backgroundColor = UIColorUtils.CreateFromRGB(red: 209, green: 209, blue: 214)
        
        // Avatar
        addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImage.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            profileImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImage.widthAnchor.constraint(equalToConstant: 130),
            profileImage.heightAnchor.constraint(equalToConstant: 130)
        ])
        profileImage.layer.cornerRadius = 65
        profileImage.clipsToBounds = true

        // Fullname
        addSubview(fullNameLabel)
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fullNameLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 16),
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            fullNameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
        ])

        // Status
        addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 16),
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 30),
            statusLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
        ])

        // Textfield
        addSubview(statusTextField)
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusTextField.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 16),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 4),
            statusTextField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Set status button
        addSubview(setStatusButton)
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setStatusButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            setStatusButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16),
            setStatusButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor,constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private var statusText: String?
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text
        print("Status text is \(statusText ?? "")")
    }
    
    @objc func buttonPressed() {
        statusLabel.text = statusText
    }
}
