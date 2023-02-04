
import UIKit

class PostViewController: UIViewController {

    private let viewModel : PostViewModel
    
    init (viewModel: PostViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.background
        
        let infoBarButtonItem = UIBarButtonItem(title: PostScreenLocalizer.info.rawValue.localize(from: .postDictionary), style: .done, target: self, action: #selector(showInfo))
        
        let aaa = PostScreenLocalizer.info.rawValue.localize(from: .postDictionary)
        
        self.navigationItem.rightBarButtonItem = infoBarButtonItem
    }
    
    @objc func showInfo() {
       viewModel.goToInfoAction?(self)
    }
}
