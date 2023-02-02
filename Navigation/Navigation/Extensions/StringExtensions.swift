
import Foundation

extension String? {
    func isNullOrWhiteSpace() -> Bool {
        if self == nil {
            return true
        }
        
        return self == ""
    }
}

extension String {
    func localize(from dictionaryName: LocalizableScreens) -> String {
        let localizedString = NSLocalizedString(self, tableName: dictionaryName.rawValue, bundle: Bundle.main, value: "", comment: "")
        return localizedString
    }
    
    func localize(from dictionaryName: LocalizableScreens, value: Int) -> String {
        let tableName = dictionaryName.rawValue
        let key = self
        let format = NSLocalizedString(key, tableName: tableName, bundle: Bundle.main, value: "", comment: "")
        let localized = String(format: format, value)
        return localized
    }
}
