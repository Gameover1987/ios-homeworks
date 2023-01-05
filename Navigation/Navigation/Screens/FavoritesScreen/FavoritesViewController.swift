
import UIKit
import SnapKit

final class FavoritesViewController : UIViewController {
    private let viewModel: FavoritesViewModel
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        title = "Favorites"
        
        view.backgroundColor = .white
        
        navigationItem.searchController = searchController
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: ProfileViewController.publicationCellId)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search by author..."
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
}

extension FavoritesViewController : UITableViewDelegate {

}

extension FavoritesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.publications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let publication = viewModel.publications[indexPath.row]
        
        guard let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: ProfileViewController.publicationCellId, for: indexPath) as? PostTableViewCell else { fatalError() }
        cell.update(name: publication.author!,
                    image: UIImage(data: publication.imageData ?? Data()) ?? UIImage(systemName: "exclamationmark.icloud")!,
                    description: publication.text!,
                    countLikes: 0,
                    countViews: 0)
        
        return cell
    }
}

extension FavoritesViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        viewModel.searchString = searchController.searchBar.text ?? ""
        
        tableView.reloadData()
    }
}
