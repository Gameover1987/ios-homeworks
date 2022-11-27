
import Foundation

final class PasswordHelper {
    private let upperCaseLetters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" ]
    private let digits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" ]
    private let symbols = [".", ",", ";", ":", "!", "?", "#", "$", "%", "^", "&", "*", "(", ")", "-", "+", "*", "=" ]
    
    private init() {
        
    }
    
    public static let shared: PasswordHelper = .init()
    
    public func generatePassowrd() -> String {
        let alphabet = getAlphabet()
        let passwordLength = Int.random(in: 10...20)
      
        let randomPassword = String((0..<passwordLength).compactMap{ _ in alphabet.randomElement() }.joined())
        return randomPassword
    }
    
    public func bruteForce(password: String) -> String {
        var result = String()
        let alphabet = getAlphabet()
        for position in (0...password.count-1) {
            for alphabetItem in alphabet {
                let character = password[position]
                if (character == alphabetItem) {
                    result += alphabetItem
                    break
                }
            }
        }
        
        return result
    }
    
    private func getAlphabet() -> [String] {
        let lowerCaseLetters = upperCaseLetters.map{ letter in
            letter.lowercased()
        }
        
        return upperCaseLetters + lowerCaseLetters + digits + symbols
    }
}

extension StringProtocol {
    subscript(offset: Int) -> String {
        let start = startIndex
        let count = self.count
        return String(self[index(startIndex, offsetBy: offset)])
    }
}
