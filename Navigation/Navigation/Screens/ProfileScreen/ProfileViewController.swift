
import UIKit

class ProfileViewController: UIViewController {

    private let viewModel: ProfileViewModel
    private let imageProvider: UserImageProviderProtocol
    
    init(viewModel: ProfileViewModel, imageProvider: UserImageProviderProtocol) {
        self.viewModel = viewModel
        self.imageProvider = imageProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        gestureRecognizer.numberOfTapsRequired = 2
        tableContents.addGestureRecognizer(gestureRecognizer)
        
#if DEBUG
        view.backgroundColor = .white
#else
        view.backgroundColor = .red
#endif
        
        title = "Profile"
        
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
        
        DispatchQueue.global().async {
            sleep(2)
            
            let result = self.imageProvider.getUserImageBy(name: "Ava")
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.tableHeader.updateProfileImage(image: image)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.handleImageDownloadError(error: error)
                }
            }
        }
    }
    
    @objc
    private func handleDoubleTap(tapGestureRecognizer: UITapGestureRecognizer) {
        let point = tapGestureRecognizer.location(in: tableContents)
        guard let indexPath = tableContents.indexPathForRow(at: point) else {return}
        
        let post = DataService.shared.publications[indexPath.row]
        
        CoreDataFavoritePublicationsStorage.shared.addToFavorites(post: post)
    }
    
    private func handleImageDownloadError(error: ImageDownloadError) {
        switch error {
        case .imageNotFound:
            showAlert(title: "App error", message: "Profile image not found!")
        }
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
    
     static var publicationCellId: String = "publicationCell"
     static var photosCellId: String = "photosCell"
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
