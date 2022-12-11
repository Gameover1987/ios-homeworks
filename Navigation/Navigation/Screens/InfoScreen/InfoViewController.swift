
import UIKit

class InfoViewController: UIViewController {
  
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.layer.cornerRadius = 10
        label.layer.borderColor = UIColor.init(named: "vkColor")!.cgColor
        label.layer.borderWidth = 2
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    private lazy var rotationPeriodLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.layer.cornerRadius = 10
        label.layer.borderColor = UIColor.init(named: "vkColor")!.cgColor
        label.layer.borderWidth = 2
        label.toAutoLayout()
        return label
    }()
    
    private lazy var buttonAlert: UIButton = {
        let button = UIButton(type: .custom) as UIButton
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle("Show alert", for: .normal)
        button.addTarget(self, action: #selector(alertAction), for: .touchDown)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.title = "Information"
        
        view.addSubview(titleLabel)
        view.addSubview(rotationPeriodLabel)
        view.addSubview(buttonAlert)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        rotationPeriodLabel.snp.makeConstraints {make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        buttonAlert.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.centerY.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Task 1
        NetworkManager.request(forConfiguration: .todos) { [weak self] data, response, error in
            guard let data = data else {return}
            
            do {
                let serializedDictionary = try JSONSerialization.jsonObject(with: data, options: [])
                if let dictionary = serializedDictionary as? [[String: Any]], let title = dictionary.randomElement()!["title"] as? String {
                    DispatchQueue.main.async {
                        self?.titleLabel.text = " " + title
                    }
                }
            } catch let error {
                print("⚠️ Error:", String(describing: error))
            }
        }
    }
    
    @objc func alertAction(sender: UIButton) {
        let buttonOK = { (_: UIAlertAction) -> Void in print("OK button pressed") }
        let buttonCancel = { (_: UIAlertAction) -> Void in print("Cancel button pressed") }
        
        let alert = UIAlertController(title: "Alert", message: "Do you want something?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: buttonOK))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: buttonCancel))
        self.present(alert, animated: true, completion: nil)
    }
}
