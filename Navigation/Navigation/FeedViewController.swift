//
//  FeedViewController.swift
//  Navigation
//
//  Created by Вячеслав on 03.12.2021.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let button = UIButton(type: .custom) as UIButton
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle("Show post", for: .normal)
        button.frame = CGRect(x: 100, y: 420, width: 200, height: 50)
        button.addTarget(self, action: #selector(openPostButtonAction), for: .touchDown)
        view.addSubview(button)
    }
    
    @objc func openPostButtonAction(sender: UIButton!) {
        let postViewController = PostViewController()
        postViewController.title = "Post"
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
}
