
import Foundation

final class NetworkManager {
    static func request(
        forConfiguration: AppConfiguration,
        requestHandler: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        let url = forConfiguration.toUrl()
        let task = URLSession.shared.dataTask(with: url, completionHandler: requestHandler)
        task.resume()
    }
}
