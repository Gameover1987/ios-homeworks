
import UIKit

private enum LayoutConstants {
    static let bottom = -20.0
    static let leading = 20.0
    static let tralling = -75.0
    static let topForTitle = 20.0
    static let topForSubtitle = 4.0
    static let topForCounter = 92.0
    static let topForStatus = 46.0
    static let trallingForStatus = -25.9
    static let weightStatus = 38.0
    static let heightStatus = 38.0
}

final class HabitCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        contentView.addSubviews(titleLabel, subtitleLabel, counterLabel, statusButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.topForTitle),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leading),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.tralling),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutConstants.topForSubtitle),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leading),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.tralling),
            
            counterLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.topForCounter),
            counterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leading),
            counterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: LayoutConstants.bottom),
            
            statusButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.topForStatus),
            statusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trallingForStatus),
            statusButton.widthAnchor.constraint(equalToConstant: LayoutConstants.weightStatus),
            statusButton.heightAnchor.constraint(equalToConstant: LayoutConstants.heightStatus)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var indexElement: Int?
    
    private var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 2
        label.toAutoLayout()
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.toAutoLayout()
        return label
    }()
    
    private var counterLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        label.toAutoLayout()
        return label
    }()
    
    private var statusButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(changeStatusHabit), for: .touchUpInside)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.toAutoLayout()
        return button
    }()
    
    func update(title: String, subtitle: String, counter: Int, isChecked: Bool, color: UIColor) {
        titleLabel.text = title
        titleLabel.textColor = color
        subtitleLabel.text = subtitle
        counterLabel.text = "Счётчик: \(counter)"
        statusButton.tintColor = color
        
        isChecked ? statusButton.setImage(UIImage(systemName: "checkmark.circle.fill")!, for: .normal) :
                    statusButton.setImage(UIImage(systemName: "circle")!, for: .normal)
    }
    
    @objc private func changeStatusHabit() {
        let data = HabitsStore.instance.habits[indexElement!]
        guard !data.isAlreadyTakenToday else { return }
        statusButton.setImage(UIImage(systemName: "checkmark.circle.fill")!, for: .normal)
        HabitsStore.instance.track(HabitsStore.instance.habits[indexElement!])
        let nameNotification = Notification.Name(rawValue: GlobalConstants.progressCellNotificationKey)
        NotificationCenter.default.post(name: nameNotification, object: nil)
        self.counterLabel.text = "Счётчик: \(HabitsStore.instance.habits[indexElement!].trackDates.count)"
    }
}

extension HabitCollectionViewCell: ReusableCellProtocol {
    static var identifier: String { String(describing: self) }
}
