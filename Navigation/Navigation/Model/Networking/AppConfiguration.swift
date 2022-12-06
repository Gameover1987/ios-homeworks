
import Foundation

enum AppConfiguration : String {
    case people = "https://swapi.dev/api/people/8"
    case starships = "https://swapi.dev/api/starships/3"
    case planets = "https://swapi.dev/api/planets/5"
}

extension AppConfiguration {
    func toUrl() -> URL {
        return URL(string: self.rawValue)!
    }

}
