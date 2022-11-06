//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Вячеслав on 04.04.2022.
//

import UIKit
import iOSIntPackage

final class PhotosViewController: UIViewController {

    private let imgFacade = ImagePublisherFacade()
    
    private var downloadedImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = UIColor.systemBlue
        navigationController?.navigationBar.isHidden = false
        
        title = "Photos"
        view.backgroundColor = .systemGray
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        collectionView.toAutoLayout()
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        imgFacade.subscribe(self)
        imgFacade.addImagesWithTimer(time: TimeInterval(0.2), repeat: PhotoStorage.instance.photos.count)
    }
    
    deinit {
        imgFacade.removeSubscription(for: self)
        imgFacade.rechargeImageLibrary()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private let collectionView: UICollectionView = {
        var viewLayout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
}

extension PhotosViewController: UICollectionViewDataSource {
    
    // Сколько ячеек, будет в одной секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return downloadedImages.count
    }
    
    // Заполнение ячеек данными.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: PhotoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else { fatalError() }
        let photo = PhotoStorage.instance.photos[indexPath.row]
        cell.update(photo)
        return cell
    }
}

// MARK: - Delegate

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    // Определение размера ячеек.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: view.frame.width, spacing: 8.0)
        return CGSize(width: width, height: width)
    }

    // Подсчет ширины ячеек.
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 3
        let totalSpasing: CGFloat = 3 * spacing + (itemsInRow - 2) * spacing
        let finalWidth = (width - totalSpasing) / itemsInRow
        return floor(finalWidth)
    }

    // Расстановка отсутпов между ячейками.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension PhotosViewController : ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        self.downloadedImages.removeAll()
        
        images.forEach {
            downloadedImages.append($0)
        }
        
        self.collectionView.reloadData()
    }
    
}
