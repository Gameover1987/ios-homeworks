import Foundation
import UIKit

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
