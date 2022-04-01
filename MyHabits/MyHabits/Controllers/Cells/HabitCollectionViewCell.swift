
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
        contentView.addSubview(titleHabits)
        contentView.addSubview(subtitleHabits)
        contentView.addSubview(counterHabits)
        contentView.addSubview(statusHabitsButton)
        
        NSLayoutConstraint.activate([
            titleHabits.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.topForTitle),
            titleHabits.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leading),
            titleHabits.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.tralling),
            
            subtitleHabits.topAnchor.constraint(equalTo: titleHabits.bottomAnchor, constant: LayoutConstants.topForSubtitle),
            subtitleHabits.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leading),
            subtitleHabits.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.tralling),
            
            counterHabits.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.topForCounter),
            counterHabits.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leading),
            counterHabits.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: LayoutConstants.bottom),
            
            statusHabitsButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.topForStatus),
            statusHabitsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trallingForStatus),
            statusHabitsButton.widthAnchor.constraint(equalToConstant: LayoutConstants.weightStatus),
            statusHabitsButton.heightAnchor.constraint(equalToConstant: LayoutConstants.heightStatus)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var indexElement: Int?
    
    private var titleHabits: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 2
        label.toAutoLayout()
        return label
    }()
    
    private var subtitleHabits: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.toAutoLayout()
        return label
    }()
    
    private var counterHabits: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        label.toAutoLayout()
        return label
    }()
    
    private var statusHabitsButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(changeStatusHabit), for: .touchUpInside)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.toAutoLayout()
        return button
    }()
    
    func update(title: String, subtitle: String, counter: Int, statusImage: Bool, color: UIColor) {
        titleHabits.text = title
        titleHabits.textColor = color
        subtitleHabits.text = subtitle
        counterHabits.text = "Счётчик: \(counter)"
        statusHabitsButton.tintColor = color
        statusImage ? statusHabitsButton.setImage(UIImage(systemName: "checkmark.circle.fill")!, for: .normal) : statusHabitsButton.setImage(UIImage(systemName: "circle")!, for: .normal)
    }
    
    /// Обработка, нажатия на кнопку выполенения.
    @objc private func changeStatusHabit() {
        let data = HabitsStore.instance.habits[indexElement!]
        guard !data.isTodayAdded else { return }
        statusHabitsButton.setImage(UIImage(systemName: "checkmark.circle.fill")!, for: .normal)
        HabitsStore.instance.track(HabitsStore.instance.habits[indexElement!])
        let nameNotification = Notification.Name(rawValue: GlobalConstants.progressCellNotificationKey)
        NotificationCenter.default.post(name: nameNotification, object: nil)
        self.counterHabits.text = "Счётчик: \(HabitsStore.instance.habits[indexElement!].trackDates.count)"
    }
}

extension HabitCollectionViewCell: ReusableCellProtocol {
    static var identifier: String { String(describing: self) }
}
