
import Foundation

public protocol FeedProtocol {
    func check(word: String) -> Bool
}

public class FeedModel : FeedProtocol {
    private var secretWord: String
    
    private init(secretWord: String) {
        self.secretWord = secretWord
    }
    
    public static let shared: FeedModel = .init(secretWord: "Preved")
    
    public func check(word: String) -> Bool {
        return secretWord == word
    }
}
