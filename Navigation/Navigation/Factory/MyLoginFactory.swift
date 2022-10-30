

import Foundation

public final class MyLoginFactory {
    public func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
