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
        
        let profileHeaderView = ProfileHeaderView()
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(profileHeaderView)
        
        NSLayoutConstraint.activate([
            profileHeaderView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
        ])
        
        profileHeaderView.arrange()
    }
}
