//
//  PostViewController.swift
//  Navigation
//
//  Created by Вячеслав on 03.12.2021.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let infoBarButtonItem = UIBarButtonItem(title: "Information", style: .done, target: self, action: #selector(ahowInfoViewController))
        
        self.navigationItem.rightBarButtonItem = infoBarButtonItem
    }
    
    @objc func ahowInfoViewController() {
        let infoViewController = InfoViewController()
        let infoNavigationController = UINavigationController(rootViewController: infoViewController)
        present(infoNavigationController, animated: true, completion: nil)
    }
}
