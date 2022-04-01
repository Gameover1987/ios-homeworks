
import UIKit

private enum Margins {
    static let topForTitle = 10.0
    static let topForProgress = 40.0
    static let bottomForProgress = -15.0
    static let heightProgress = 8.0
    static let tralling = -10.0
    static let leading = 10.0
}

final class ProgressCollectionViewCell: UICollectionViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        contentView.addSubview(titleLabel)
        contentView.addSubview(progressLabel)
        contentView.addSubview(progressBar)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margins.topForTitle),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.leading),
            progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margins.topForTitle),
            progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Margins.tralling),
            progressBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margins.topForProgress),
            progressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.leading),
            progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Margins.tralling),
            progressBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Margins.bottomForProgress),
            progressBar.heightAnchor.constraint(equalToConstant: Margins.heightProgress),
        ])
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Всё получится!"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        label.toAutoLayout()
        return label
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.text = String(Int(self.progressBar.progress * 100)) + "%"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var progressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.layer.cornerRadius = 5
        progressView.clipsToBounds = true
        progressView.setProgress(HabitsStore.instance.todayProgress, animated: false)
        progressView.trackTintColor = UIColor(red: 0.847, green: 0.847, blue: 0.847, alpha: 1)
        progressView.progressTintColor = UIColor(named: "purpleColorApp")
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    public func updateProgress() {
        progressBar.setProgress(HabitsStore.instance.todayProgress, animated: true)
        progressLabel.text = String(Int(self.progressBar.progress * 100)) + "%"
    }
}

extension ProgressCollectionViewCell: ReusableCellProtocol {
    static var identifier: String { String(describing: self) }
}
