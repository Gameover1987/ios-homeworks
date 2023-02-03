
import SnapKit
import CoreData

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
        title = FavoritesScreenLocalizer.title.rawValue.localize(from: .favoritesDictionary)
        
        view.backgroundColor = .white
        
        viewModel.insertRowsAction = { [weak self] indexPath in
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        viewModel.deleteRowsAction = {  [weak self] indexPath in
            self?.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        viewModel.moveRowAction = { [weak self] indexPath, newIndexPath in
            self?.tableView.moveRow(at: indexPath, to: newIndexPath)
        }
        viewModel.updateRowsAction = { [weak self] indexPath in
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
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
        searchController.searchBar.placeholder = FavoritesScreenLocalizer.searchBar.rawValue.localize(from: .favoritesDictionary)
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
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "Del") { [weak self] ( action, view, completionHandler) in
            guard let self = self else {return}
            let publication = self.viewModel.getPublication(at: indexPath)
            self.viewModel.removePublication(publication: publication)
            tableView.reloadData()
        }
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return configuration
    }
}

extension FavoritesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.publicationsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let publication = self.viewModel.getPublication(at: indexPath)
        
        guard let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: ProfileViewController.publicationCellId, for: indexPath) as? PostTableViewCell else { fatalError() }
        cell.update(name: publication.author!,
                    image: UIImage(data: publication.imageData ?? Data()) ?? UIImage(systemName: "exclamationmark.icloud")!,
                    description: publication.text!,
                    countLikes: 0,
                    countViews: 0)
        cell.hideFeedbackPanel()
        
        return cell
    }
}

extension FavoritesViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        viewModel.applyFilter(filter: searchController.searchBar.text ?? "")
        
        tableView.reloadData()
    }
}
