
import UIKit

final class AddHabitViewController : UIViewController {
    
    private enum Margins {
        static let leading = 15.0
        static let tralling = -15.0
        static let topForTitle = 15.0
        static let topForTitleName = 21.0
        static let topActionItem = 7.0
        static let topDatePicker = 15.0
        static let heightTextFiled = 22.0
        static let widthAndHeightColorButton = 50.0
    }
    
    init(habit: Habit?, typeHabit: GlobalConstants.ViewMode) {
        self.habit = habit
        self.typeHabit = typeHabit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.tintColor = UIColor(named: "purple")
        self.navigationItem.leftBarButtonItem = cancelHabitButton
        self.navigationItem.rightBarButtonItem = saveHabitButton
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(habitNameCaption,
                                habitColorCaption,
                                habitTimeCaption,
                                habitNameTextField,
                                habitColorButton,
                                timeDescriptionLabel,
                                habbitDatePicker)
        
        if (typeHabit == .edit) {
            contentView.addSubview(deleteButton)
            deleteButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -18).isActive = true
            deleteButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            habitNameCaption.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: Margins.topForTitleName),
            habitNameCaption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.leading),
            
            habitColorCaption.topAnchor.constraint(equalTo: habitNameTextField.bottomAnchor, constant: Margins.topForTitle),
            habitColorCaption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.leading),
            
            habitTimeCaption.topAnchor.constraint(equalTo: habitColorButton.bottomAnchor, constant: Margins.topForTitle),
            habitTimeCaption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.leading),
            
            habitNameTextField.topAnchor.constraint(equalTo: habitNameCaption.bottomAnchor, constant: Margins.topActionItem),
            habitNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.leading),
            habitNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Margins.tralling),
            habitNameTextField.heightAnchor.constraint(equalToConstant: Margins.heightTextFiled),
            
            habitColorButton.topAnchor.constraint(equalTo: habitColorCaption.bottomAnchor, constant: Margins.topActionItem),
            habitColorButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.leading),
            habitColorButton.widthAnchor.constraint(equalToConstant: Margins.widthAndHeightColorButton),
            habitColorButton.heightAnchor.constraint(equalToConstant: Margins.widthAndHeightColorButton),
            
            timeDescriptionLabel.topAnchor.constraint(equalTo: habitTimeCaption.bottomAnchor, constant: Margins.topActionItem),
            timeDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.leading),
            
            habbitDatePicker.topAnchor.constraint(equalTo: timeDescriptionLabel.bottomAnchor, constant: Margins.topActionItem),
            habbitDatePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            habbitDatePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        validate()
    }
    
    private var habit: Habit?
    private var typeHabit: GlobalConstants.ViewMode
    
    private lazy var cancelHabitButton: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(returnToThePreviousScreen))
        return item
    }()
    
    private lazy var saveHabitButton: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(keepinTheHabit))
        return item
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    private var contentView: UIView = {
        let contentView = UIView()
        contentView.toAutoLayout()
        return contentView
    }()
    
    private let habitNameCaption: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.font = .boldSystemFont(ofSize: 13)
        label.toAutoLayout()
        return label
    }()
    
    private let habitColorCaption: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.font = .boldSystemFont(ofSize: 13)
        label.toAutoLayout()
        return label
    }()
    
    private let habitTimeCaption: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.font = .boldSystemFont(ofSize: 13)
        label.toAutoLayout()
        return label
    }()
    
    private lazy var habitNameTextField: UITextField = {
        let titleHabit = UITextField()
        
        titleHabit.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 22))
        titleHabit.font = .boldSystemFont(ofSize: 17)
        titleHabit.textColor = UIColor.init(named: "blue")
        titleHabit.attributedPlaceholder = NSAttributedString.init(string: "Бегать по утрам, спать 8 часов и все такое")
        titleHabit.toAutoLayout()
        titleHabit.addTarget(self, action: #selector(habitTitleChanged(_ :)), for: .editingChanged)
        if self.typeHabit == .edit {
            titleHabit.text = self.habit?.name
        } else {
            titleHabit.text = ""
        }
        
        return titleHabit
    }()
    
    private lazy var habitColorButton: UIButton = {
        let button = UIButton()
        let store = HabitsStore.instance
        button.layer.cornerRadius = Margins.widthAndHeightColorButton / 2
        button.toAutoLayout()
        button.addTarget(self, action: #selector(presentColorPicker), for: .touchUpInside)
        button.backgroundColor = typeHabit == .edit ? self.habit?.color : self.habit?.color ?? .orange
        return button
    }()
    
    private lazy var timeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.attributedText = settingTimeString()
        label.toAutoLayout()
        return label
    }()
    
    private lazy var habbitDatePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(editDatePicker), for: .valueChanged)
        datePicker.toAutoLayout()
        
        guard typeHabit == .edit else { return datePicker }
        datePicker.date = self.habit!.date
        return datePicker
    }()
    
    private let deleteButton: UIButton = {
        var button = UIButton()
        button.titleLabel?.textColor = UIColor(red: 1, green: 0.231, blue: 0.188, alpha: 1)
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(deleteHabbit), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    private func settingTimeString() -> NSMutableAttributedString {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ru_RU")
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.black]
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.blue]
        let attributedString1 = NSMutableAttributedString(string:"Каждый день в ", attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string: formatter.string(from: habbitDatePicker.date), attributes:attrs2)
        attributedString1.append(attributedString2)
        return attributedString1
    }
    
    private func validate() {
        self.navigationItem.rightBarButtonItem?.isEnabled = habitNameTextField.hasText
    }
    
    @objc private func returnToThePreviousScreen() {
        self.dismiss(animated: true)
    }
    
    @objc func habitTitleChanged(_ textField: UITextField) {
        validate()
    }
    
    /// Нажатие кнопки "Сохранить"
    @objc private func keepinTheHabit() {
        guard !habitNameTextField.text!.isEmpty else { return }
        if typeHabit == .edit {
            // Изменение привычки
            let indexItem = HabitsStore.instance.habits.firstIndex(of: self.habit!)
            let data = HabitsStore.instance.habits[indexItem!]
            HabitsStore.instance.habits[indexItem!] = .init(name: habitNameTextField.text!, date: habbitDatePicker.date, color: habitColorButton.backgroundColor!)
            if data.isAlreadyTakenToday {
                HabitsStore.instance.track(HabitsStore.instance.habits[indexItem!])
            }
            let notificationForScreenDetail = Notification.Name(rawValue: GlobalConstants.hideScreenDetailNotificationKey)
            NotificationCenter.default.post(name: notificationForScreenDetail, object: nil)
        } else {
            // Сохранение привычки
            let newHabit = Habit(name: habitNameTextField.text!, date: habbitDatePicker.date, color: habitColorButton.backgroundColor!)
            let store = HabitsStore.instance
            store.habits.append(newHabit)
            let nameNotification = Notification.Name(rawValue: GlobalConstants.progressCellNotificationKey)
            NotificationCenter.default.post(name: nameNotification, object: nil)
            
        }
        let nameReloadCellsNotification = Notification.Name(rawValue: GlobalConstants.cellsReloadedNotificationKey)
        NotificationCenter.default.post(name: nameReloadCellsNotification, object: nil)
        self.dismiss(animated: true)
    }
    
    /// Нажатие кнопки изменение цвета
    @objc private func presentColorPicker() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.selectedColor = self.habitColorButton.backgroundColor!
        colorPicker.delegate = self
        self.present(colorPicker, animated: true, completion: nil)
    }
    
    /// Изменение времени в DatePicker
    @objc private func editDatePicker() {
        timeDescriptionLabel.attributedText = settingTimeString()
    }
    
    /// Нажатие кнопки "Удалить привычку"
    @objc private func deleteHabbit() {
        let buttonClickOK = { (_: UIAlertAction) -> Void in
            let indexItem = HabitsStore.instance.habits.firstIndex(of: self.habit!)
            HabitsStore.instance.habits.remove(at: indexItem!)
            
            // Нотификация для обновления progressView
            let nameNotification = Notification.Name(rawValue: GlobalConstants.progressCellNotificationKey)
            NotificationCenter.default.post(name: nameNotification, object: nil)
            
            // Нотификация для закрытия экрана detail.
            let notificationForScreenDetail = Notification.Name(rawValue: GlobalConstants.hideScreenDetailNotificationKey)
            NotificationCenter.default.post(name: notificationForScreenDetail, object: nil)
            self.dismiss(animated: true)
        }
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы действительно хотите удалить привычку\n'\(self.habit!.name)'?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Удалить", style: .default, handler: buttonClickOK))
        self.present(alert, animated: true, completion: nil)
    }
}


extension AddHabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.habitColorButton.backgroundColor = viewController.selectedColor
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.habitColorButton.backgroundColor = viewController.selectedColor
    }
}
