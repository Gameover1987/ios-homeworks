
import Foundation
import StorageService
import UIKit

public class DataService {
    public let publications: [Post] = [
        Post(author: "Михаил Таль", description: "Белыми играть на ничью - это преступление против шахмат!", image: UIImage(named: "Tal")!, likes: 1, views: 1),
        Post(author: "Тигран Петросян", description: "Если ваш противник решил против вас играть Голландскую защиту, не мешайте ему!", image: UIImage(named: "Petrosyan")!, likes: 2, views: 2),
        Post(author: "Роберт Джеймсович Фишер", description: "Как я играю против варианта Дракона? Делаю длинную рокировку, вскрываю вертикаль h и ставлю мат!", image: UIImage(named: "Fisher")!, likes: 5, views: 5)
    ]
    
    public static let shared: DataService = .init()
}
