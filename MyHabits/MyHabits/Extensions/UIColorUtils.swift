
import UIKit
import Foundation

public class UIColorUtils {
    public static func FromRGB(red: uint, green: uint, blue: uint) -> UIColor {
        return UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 255)
    }
}
