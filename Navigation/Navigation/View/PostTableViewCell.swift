
import UIKit
import iOSIntPackage

class PostTableViewCell: UITableViewCell {

    private let _imageProcessor = ImageProcessor()
    
    private lazy var authorPostLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postCountLikes: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postCountViews: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(authorPostLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(postDescriptionLabel)
        contentView.addSubview(postCountLikes)
        contentView.addSubview(postCountViews)
        arrange()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(name: String, image: UIImage, description: String, countLikes: Int, countViews: Int) {
        authorPostLabel.text = name
        
        _imageProcessor.processImage(sourceImage: image, filter: ColorFilter.bloom(intensity: 0.5), completion: { processedImage -> Void in
            postImageView.image = processedImage
        })
        postDescriptionLabel.text = description
        postCountLikes.text = "Likes: \(countLikes)"
        postCountViews.text = "Views: \(countViews)"
    }
    
    private func arrange() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width + 186),
            authorPostLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            authorPostLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            authorPostLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            
            postImageView.topAnchor.constraint(equalTo: authorPostLabel.bottomAnchor, constant: 12.0),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            postImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            postDescriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16.0),
            postDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            
            postCountLikes.topAnchor.constraint(equalTo: postDescriptionLabel.bottomAnchor, constant: 16.0),
            postCountLikes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            
            postCountViews.topAnchor.constraint(equalTo: postDescriptionLabel.bottomAnchor, constant: 16.0),
            postCountViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
        ])
    }

}
