
import UIKit

class ProfileViewController: UIViewController {

    private let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEBUG
            view.backgroundColor = .white
        #else
            view.backgroundColor = .red
        #endif
        
        view.addSubview(tableContents)
        tableContents.register(PhotosTableViewCell.self, forCellReuseIdentifier: ProfileViewController.photosCellId)
        tableContents.register(PostTableViewCell.self, forCellReuseIdentifier: ProfileViewController.publicationCellId)
        tableContents.separatorStyle = .singleLine
        tableContents.dataSource = self
        tableContents.delegate = self
        
        NSLayoutConstraint.activate([
            tableContents.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableContents.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableContents.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableContents.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private var tableHeader: ProfileHeaderView = {
        let profileHeaderView = ProfileHeaderView()
        profileHeaderView.backgroundColor = .systemGray
        profileHeaderView.toAutoLayout()
        return profileHeaderView
    }()
    
    private var tableContents: UITableView = {
        let table = UITableView.init(frame:  CGRect.zero, style: .grouped)
     
        table.toAutoLayout()
        
        return table
    }()
    
    private static var publicationCellId: String = "publicationCell"
    private static var photosCellId: String = "photosCell"
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Данный метод, должен понимать, сколько всего ячеек будет.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0 else { return 3 }
        return 1
    }
    
    // Данный метод, отвечает за заполненение ячеек данными.
    /* https://medium.com/swift-gurus/generic-tableview-cells-and-sections-69c8ae241636 */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell: PhotosTableViewCell = tableView.dequeueReusableCell(withIdentifier: ProfileViewController.photosCellId, for: indexPath) as? PhotosTableViewCell else { fatalError() }
            return cell
        default:
            guard let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: ProfileViewController.publicationCellId, for: indexPath) as? PostTableViewCell else { fatalError() }
            let data = DataService.shared.publications[indexPath.row]
            
            cell.update(name: data.author, image: data.image, description: data.description, countLikes: data.likes, countViews: data.views)
            return cell
        }
    }
    
    // Добавляем profileView в качестве header'a.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        return tableHeader
    }
    
    // Добавляем размер header'у.
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else { return 0 }
        return 220
    }
    
    // Действие по нажатию на ячейку.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 && indexPath.row == 0 else { return }
        let vc = PhotosViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
