
import UIKit

final class FeedViewController: UIViewController {

    private let viewModel: FeedViewModel
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.background
        
        let button = UIButton(type: .custom) as UIButton
        button.layer.borderWidth = 1
        button.backgroundColor = UIColor.init(named: "vkColor")
        button.layer.cornerRadius = 10
        button.setTitle(FeedScreenLocalizer.showPostButton.rawValue.localize(from: .feedDictionary), for: .normal)
        button.frame = CGRect(x: 100, y: 420, width: 200, height: 50)
        button.addTarget(self, action: #selector(openPostButtonAction), for: .touchDown)
        view.addSubview(button)
    }
    
    @objc func openPostButtonAction(sender: UIButton!) {
        viewModel.goToPostAction?()
    }
}
