//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Вячеслав on 03.12.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    override func viewWillLayoutSubviews() {
        
        let safeAreaRect = view.safeAreaLayoutGuide.layoutFrame
        let profileHeaderView = ProfileHeaderView()
        profileHeaderView.frame = CGRect(x: safeAreaRect.minX, y: safeAreaRect.minY, width: safeAreaRect.width, height: safeAreaRect.height)
        profileHeaderView.arrange()
     
        self.view.addSubview(profileHeaderView)
        
    }
}
