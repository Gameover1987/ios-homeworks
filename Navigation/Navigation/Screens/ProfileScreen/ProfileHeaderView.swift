import Foundation
import UIKit
import SnapKit

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
        
        profileImage.snp.makeConstraints { make -> Void in
            make.left.equalTo(safeAreaLayoutGuide).offset(ProfileConstraints.defaultMargin)
            make.top.equalTo(safeAreaLayoutGuide).offset(ProfileConstraints.defaultMargin)
            make.width.equalTo(ProfileConstraints.imageWidth)
            make.height.equalTo(ProfileConstraints.imageHeight)
        }

        fullNameLabel.snp.makeConstraints{ make -> Void in
            make.left.equalTo(profileImage.snp.right).offset(ProfileConstraints.defaultMargin)
            make.top.equalTo(safeAreaLayoutGuide).offset(ProfileConstraints.headerMargin)
            make.right.equalTo(safeAreaLayoutGuide.snp.right)
        }

        statusLabel.snp.makeConstraints { make -> Void in
            make.left.equalTo(profileImage.snp.right).offset(ProfileConstraints.defaultMargin)
            make.top.equalTo(fullNameLabel.snp.bottom).offset(30)
            make.right.equalTo(safeAreaLayoutGuide)
        }

        statusTextField.snp.makeConstraints{ make -> Void in
            make.left.equalTo(profileImage.snp.right).offset(ProfileConstraints.defaultMargin)
            make.top.equalTo(statusLabel.snp.bottom).offset(4)
            make.right.equalTo(safeAreaLayoutGuide).offset(ProfileConstraints.defaultMargin * -1)
            make.height.equalTo(40)
        }

        setStatusButton.snp.makeConstraints{make -> Void in
            make.left.equalTo(safeAreaLayoutGuide).offset(ProfileConstraints.defaultMargin)
            make.top.equalTo(profileImage.snp.bottom).offset(ProfileConstraints.defaultMargin)
            make.right.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateProfileImage(image: UIImage) {
        profileImage.image = image
    }
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 65
        imageView.clipsToBounds = true
        
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
        button.setTitle(ProfileScreenLocalizer.statusButton.rawValue.localize(from: .profileDictionary), for: .normal)
        button.backgroundColor = UIColorUtils.CreateFromRGB(red: 0, green: 146, blue: 249)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchDown)
        
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
