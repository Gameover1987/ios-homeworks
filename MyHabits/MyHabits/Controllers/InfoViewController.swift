
import UIKit

final class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Информация"
        view.addSubview(scrollView)
        scrollView.addSubview(informationTextView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            informationTextView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            informationTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            informationTextView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            informationTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            informationTextView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            informationTextView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    private var informationTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.showsVerticalScrollIndicator = false
        textView.attributedText = getFormattedInforamtionText()
        textView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        textView.toAutoLayout()
        return textView
    }()
    
    
    private static func getFormattedInforamtionText() -> NSAttributedString {
        let string = informationText as NSString
        let attributedString = NSMutableAttributedString(string: string as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0)])
        let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0)]
        attributedString.addAttributes(boldFontAttribute, range: string.range(of: "Привычка за 21 день"))
        return attributedString
    }
    
    private static let informationText = "Привычка за 21 день\n\nПрохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:\n\n1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.\n\n2. Выдержать 2 дня в прежнем состоянии самоконтроля.\n\n3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.\n\n4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.\n\n5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.\n\n6. На 90-й день соблюдения техники все лишнее из «‎прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознаёт себя полностью обновившимся.\n\nИсточник: psychbook.ru‎"
}
