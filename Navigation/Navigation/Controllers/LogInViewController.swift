
import Foundation
import UIKit

class LogInViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true
        
        let loginView = LoginView()
        loginView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginView)
   
        loginView.arrange(parentView: view)
    }
}
