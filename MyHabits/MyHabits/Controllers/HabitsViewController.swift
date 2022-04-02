
import UIKit

final class HabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Сегодня"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.rightBarButtonItem = addHabitButton
        view.addSubview(scrollView)
        scrollView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.identifier)
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.identifier)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            collectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        createObserversProgress()
        createObserversCellHabit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView.reloadData()
    }
    
    private weak var progressCell: ProgressCollectionViewCell?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        collectionView.toAutoLayout()
        return collectionView
    }()
    
    private lazy var addHabitButton: UIBarButtonItem = {
        let largeFont = UIFont.systemFont(ofSize: 23)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "plus", withConfiguration: configuration)
        let item = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(showAddHabitWindow))
        item.tintColor = UIColor(named: "purple")
        return item
    }()
    
    private func createObserversProgress() {
        let progressNotification = Notification.Name(rawValue: GlobalConstants.progressCellNotificationKey)
        NotificationCenter.default.addObserver(self, selector: #selector(updateProgressCell), name: progressNotification, object: nil)
    }
    
    private func createObserversCellHabit() {
        let nameReloadCellsNotification = Notification.Name(rawValue: GlobalConstants.cellsReloadedNotificationKey)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadedCollectionView), name: nameReloadCellsNotification, object: nil)
    }
    
    @objc private func showAddHabitWindow() {
        let navigationController = UINavigationController()
        let addingHabitViewController = AddHabitViewController(habit: nil, typeHabit: .add)
        addingHabitViewController.title = "Создать"
        navigationController.setViewControllers([addingHabitViewController], animated: false)
        present(navigationController, animated: true)
    }
    
    @objc private func updateProgressCell() {
        progressCell!.updateProgress()
    }
    
    @objc private func reloadedCollectionView() {
        self.collectionView.reloadData()
    }
}

// MARK: - CollectionView -> DataSource

extension HabitsViewController: UICollectionViewDataSource {
    
    /// Количество секций
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    /// Количество ячеек в секциях
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard section == 0 else { return HabitsStore.instance.habits.count }
        return 1
    }
    
    /// Заполнение ячеек данными
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell: ProgressCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.identifier, for: indexPath) as? ProgressCollectionViewCell else { fatalError() }
            progressCell = cell
            return cell
            
        default:
            guard let cell: HabitCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.identifier, for: indexPath) as? HabitCollectionViewCell else { fatalError() }
            let store = HabitsStore.instance.habits[indexPath.row]
            cell.indexElement = indexPath.row
            cell.update(title: store.name,
                        subtitle: store.dateDescription,
                        counter: store.trackDates.count,
                        isChecked: store.isAlreadyTakenToday,
                        color: store.color)
            return cell
        }
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    /// Определение размеров ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: view.frame.width - 32, height: 60)
        default:
            return CGSize(width: view.frame.width - 32, height: 130)
        }
    }
    
    /// Расстоновка отсутпов между ячейками.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
    /// Обработка нажатий на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 1 else { return }
        let detailsController = HabitDetailsViewController(habit: HabitsStore.instance.habits[indexPath.row])
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
}
