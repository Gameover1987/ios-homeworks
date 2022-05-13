
import Foundation
import UIKit

public extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ views: UIView...){
        for view in views {
            addSubview(view)
        }
    }
}
