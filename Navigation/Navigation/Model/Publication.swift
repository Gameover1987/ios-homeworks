
import Foundation
import UIKit

public class Publication {
    var author: String = ""
    var description: String = ""
    var image: UIImage
    var likes: Int = 0
    var views: Int = 0
    
    init(author: String, description: String, image: UIImage, likes: Int, views: Int) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
    }
}

let publications: [Publication] = [
    Publication(author: "Михаил Таль", description: "Белыми играть на ничью - это преступление против шахмат!", image: UIImage(), likes: 400, views: 555),
    Publication(author: "Тигран Петросян", description: "Если ваш противник решил против вас играть Голландскую защиту, не мешайте ему!", image: UIImage(), likes: 400, views: 444),
    Publication(author: "Robert James Fisher", description: "Как я играю против варианта Дракона? Делаю длинную рокировку, вскрываю вертикаль h и ставлю мат!", image: UIImage(), likes: 300, views: 333)
]
