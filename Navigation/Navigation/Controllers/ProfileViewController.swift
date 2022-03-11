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
        
        tableContents.register(PublicationTableViewCell.self, forCellReuseIdentifier: cellReuseId)
        tableContents.separatorStyle = .singleLine
        tableContents.dataSource = self
        tableContents.delegate = self
        
        NSLayoutConstraint.activate([
            tableContents.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableContents.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableContents.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableContents.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private var tableHeader: ProfileHeaderView = {
        let profileHeaderView = ProfileHeaderView()
        profileHeaderView.backgroundColor = .systemGray
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return profileHeaderView
    }()
    
    private var tableContents: UITableView = {
        let table = UITableView.init(frame:  CGRect.zero, style: .grouped)
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private var cellReuseId: String = "publicationCell"
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Table cells count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publications.count
    }
    
    // Fill data cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PublicationTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as? PublicationTableViewCell else { fatalError() }
        let data = publications[indexPath.row]
        cell.update(name: data.author, image: data.image, description: data.description, countLikes: data.likes, countViews: data.views)
        return cell
    }
    
    // Add table header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableHeader
    }
    
    
    // Setup header height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 220
    }
}
