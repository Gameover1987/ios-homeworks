
import Foundation
import UIKit

public final class Post {
    public var author: String = ""
    public var description: String = ""
    public var image: UIImage
    public var likes: Int = 0
    public var views: Int = 0
    
    public init(author: String, description: String, image: UIImage, likes: Int, views: Int) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
    }
}
