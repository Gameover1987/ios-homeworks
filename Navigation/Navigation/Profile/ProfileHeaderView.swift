import Foundation
import UIKit

public class ProfileConstrains {
    public static let imageWidth = 150
    public static let imageHeight = 150
    public static let defaultMargin = 16
    public static let headerMargin = 27
}

public class UITextFieldWithPadding : UITextField {
    var textPadding = UIEdgeInsets(
        top: 0,
        left: 3,
        bottom: 0,
        right: 3
    )
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}

public class ProfileHeaderView : UIView {
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: ProfileConstrains.defaultMargin,
                                 y: ProfileConstrains.defaultMargin,
                                 width: ProfileConstrains.imageWidth,
                                 height: ProfileConstrains.imageHeight)
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        
        imageView.image = UIImage(named: "Ava")
        return imageView
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.font =  UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    public func arrange() {
        backgroundColor = UIColorUtils.CreateFromRGB(red: 209, green: 209, blue: 214)
        
        let borderColor = UIColorUtils.CreateFromRGB(red: 146, green: 146, blue: 158)
        
        // Add borders
        self.addBorder(toSide: ViewSide.Top, withColor: borderColor, andThickness: 1)
        self.addBorder(toSide: ViewSide.Bottom, withColor: borderColor, andThickness: 1)
        
        // Add image
        addSubview(profileImage)
        
        // Add Profile header
        let headerLabel = UILabel()
        headerLabel.text = "Check, mate, rock'n'roll"
        headerLabel.font =  UIFont.boldSystemFont(ofSize: 18)
        headerLabel.frame = CGRect(x: ProfileConstrains.defaultMargin + ProfileConstrains.imageWidth + ProfileConstrains.defaultMargin,
                                   y: ProfileConstrains.headerMargin,
                                   width: Int(bounds.width),
                                   height: 30)
        addSubview(headerLabel)
        
        // Add Profile subheader
        statusLabel.frame =  CGRect(x: ProfileConstrains.defaultMargin + ProfileConstrains.imageWidth + ProfileConstrains.defaultMargin,
                                    y: ProfileConstrains.headerMargin + Int(Double(ProfileConstrains.imageHeight) * 0.5),
                                    width: Int(bounds.width),
                                    height: 30)
        addSubview(statusLabel)
        
        // Add textfield
        let textEdit = UITextFieldWithPadding()
        textEdit.font = UIFont.systemFont(ofSize: 15)
        textEdit.layer.borderWidth = 1
        textEdit.layer.cornerRadius = 12
        textEdit.layer.borderColor = UIColor.black.cgColor
        textEdit.backgroundColor = .white
        
        let textEditFrame = CGRect(x: ProfileConstrains.defaultMargin + ProfileConstrains.imageWidth + ProfileConstrains.defaultMargin,
                                   y: Int(statusLabel.frame.maxY),
                                   width: Int(bounds.width) - (ProfileConstrains.defaultMargin + ProfileConstrains.imageWidth + ProfileConstrains.defaultMargin) - ProfileConstrains.defaultMargin,
                                   height: 40)
        textEdit.addTarget(self, action: #selector(statusTextChanged(_ :)), for: .editingChanged)
        
        print(textEditFrame)
        textEdit.frame = textEditFrame
        
        addSubview(textEdit)
        
        // Add button
        let setStatusButton = UIButton()
        setStatusButton.setTitle("Set status", for: .normal)
        setStatusButton.backgroundColor = UIColorUtils.CreateFromRGB(red: 0, green: 146, blue: 249)
        setStatusButton.layer.cornerRadius = 4
        setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setStatusButton.layer.shadowRadius = 4
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.layer.shadowOpacity = 0.7
        
        let setStatusButtonFrame = CGRect(x: ProfileConstrains.defaultMargin,
                                          y: Int(textEdit.frame.maxY) + ProfileConstrains.defaultMargin,
                                          width: Int(bounds.width) - ProfileConstrains.defaultMargin * 2,
                                          height: 50)
        setStatusButton.frame = setStatusButtonFrame
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        addSubview(setStatusButton)
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
