
import Foundation
import UIKit

public class ProfileHeaderView : UIView {
    
    // Картинка для профиля
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        let imageWidth = 150
        let imageHeight = 150
        imageView.frame = CGRect(x: 16, y: 16, width: imageWidth, height: imageHeight)
        
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        
        imageView.image = UIImage(named: "Ava")
        return imageView
    }()
    
    public func arrange() {
        backgroundColor = UIColorUtils.CreateFromRGB(red: 209, green: 209, blue: 214)
        
        let borderColor = UIColor(red: 146/255, green: 146/255, blue: 150/255, alpha: 255)
        
        // Add borders
        self.addBorder(toSide: ViewSide.Top, withColor: borderColor, andThickness: 1)
        self.addBorder(toSide: ViewSide.Bottom, withColor: borderColor, andThickness: 1)
        
        // Add image
        addSubview(profileImage)
    }
}
