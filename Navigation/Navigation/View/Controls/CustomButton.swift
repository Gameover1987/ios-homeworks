
import Foundation
import UIKit

public class CustomButton : UIButton {
    
    var touchButtonAction: (() -> Void)? = nil
    
    init(title: String){
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        
        addTarget(self, action: #selector(buttonTouch), for: .touchDown)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTouch() {
        touchButtonAction?()
    }
}
