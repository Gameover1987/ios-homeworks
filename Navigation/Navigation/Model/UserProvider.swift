import Foundation
import RealmSwift

final class UserProvider : UserProviderProtocol {
    
    public static let shared = UserProvider()
    
    private init () {
        let config = Realm.Configuration(schemaVersion: 1)
        Realm.Configuration.defaultConfiguration = config
    }
    
    func getStoredUser() -> User? {
        do {
            let realm = try Realm()
            return realm.objects(User.self).first
        }
        catch {
            print(error)
            return nil
        }
    }
    
    func storeUser(user: User) {
        do {
            let config = Realm.Configuration(encryptionKey: getEncryptionKey())
            let realm = try Realm(configuration: config)
            if realm.objects(User.self).contains(where: {storedUser in
                return storedUser.login == user.login &&
                       storedUser.password == user.password
            }) {
                return
            }
                
            try realm.write {
                realm.add(user)
            }
        }
        catch {
            print(error)
        }
    }
    
    // Данный код взят из официальной документации
    // https://www.mongodb.com/docs/realm/sdk/swift/realm-files/encrypt-a-realm/
    func getEncryptionKey() -> Data {
    
        // Идентификатор для нашего объекта keychain должен быть уникальным
        let keychainIdentifier = "io.Realm.EncryptionExampleKey"
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        // Проверяем наличие существующего ключа
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]
        
        // Тут описание бага оптимизации Swift, я честно говоря не много понял, но раз в документации говорят что надо - значит надо ))
        // See also: http://stackoverflow.com/questions/24145838/querying-ios-keychain-using-swift/27721328#27721328
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            // swiftlint:disable:next force_cast
            return dataTypeRef as! Data
        }
        
        // Если ключа нет то генерируем его
        var key = Data(count: 64)
        key.withUnsafeMutableBytes({ (pointer: UnsafeMutableRawBufferPointer) in
            let result = SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
            assert(result == 0, "Failed to get random bytes")
        })
        
        // Сохраняем его в keychain
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: key as AnyObject
        ]
        
        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
        
        return key
    }
}
