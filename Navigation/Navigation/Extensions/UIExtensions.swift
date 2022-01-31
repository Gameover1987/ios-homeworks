import UIKit
import Foundation

// This syntax reflects changes made to the Swift language as of Aug. '16
extension UIView {
    
    // Example use: myView.addBorder(toSide: .Left, withColor: UIColor.redColor().CGColor, andThickness: 1.0)
    
    enum ViewSide {
        case Left, Top, Right, Bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: UIColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color.cgColor
        
        switch side {
        case .Left: border.frame = CGRect(x: bounds.minX, y: bounds.minY, width: thickness, height: bounds.height); break
        case .Top: border.frame = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: thickness); break
        case .Right: border.frame = CGRect(x: bounds.maxX, y: bounds.minY, width: thickness, height: bounds.height); break
        case .Bottom: border.frame = CGRect(x: bounds.minX, y: bounds.maxY, width: bounds.width, height: thickness); break
        }
        
        layer.addSublayer(border)
    }
    
    func addSubviews(views: UIView...){
        for view in views {
            addSubview(view)
        }
    }
}

public class UIColorUtils {
    public static func CreateFromRGB(red: uint, green: uint, blue: uint) -> UIColor {
        return UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 255)
    }
}
