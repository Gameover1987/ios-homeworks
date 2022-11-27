import Foundation

extension String {
    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

final class PasswordHelper {
    
    private var digits:      String { return "0123456789" }
    private var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    private var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    private var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    private var letters:     String { return lowercase + uppercase }
    
    var alphabet:   String { return digits + letters + punctuation }
    
    private init() {
        
    }
    
    public static let shared: PasswordHelper = .init()
    
    func generatePassoword(passwordLength: Int) -> String {
        let alphabet = self.alphabet
      
        let randomPassword = String((0..<passwordLength).compactMap{ _ in  alphabet.randomElement() })
        return randomPassword
    }
    
    func bruteForce(passwordToUnlock: String) -> String {
        let allowedCharacters: [String] = PasswordHelper.shared.alphabet.map { String($0) }
        var password: String = ""
        while password != passwordToUnlock {
            password = PasswordHelper.shared.generateBruteForce(password, fromArray: allowedCharacters)
        }
        return password
    }
    
    private func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string
        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        } else {
            str.replace(at: str.count - 1, with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))
            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }
        return str
    }
    
    private func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }
    
    private func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index]) : Character("")
    }
}
