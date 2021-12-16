//
//  InfoViewController.swift
//  Navigation
//
//  Created by Вячеслав on 03.12.2021.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.title = "Information"
        
        let buttonAlert = UIButton(type: .custom) as UIButton
        buttonAlert.backgroundColor = .systemGray
        buttonAlert.layer.cornerRadius = 10
        buttonAlert.layer.borderWidth = 1
        buttonAlert.layer.borderColor = UIColor.white.cgColor
        buttonAlert.setTitle("Show alert", for: .normal)
        buttonAlert.frame = CGRect(x: 100, y: 420, width: 200, height: 50)
        buttonAlert.addTarget(self, action: #selector(alertAction), for: .touchDown)
        view.addSubview(buttonAlert)
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
