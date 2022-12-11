
import Foundation

struct Planet : Decodable {
    var name: String
    var rotationPeriod: String
    
    enum CodingKeys: String, CodingKey {
            case name
            case rotationPeriod = "rotation_period"
        }
}
