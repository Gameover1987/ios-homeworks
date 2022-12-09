
import Foundation

final class NetworkManager {
    static func request(forConfiguration: AppConfiguration) {
        let url = forConfiguration.toUrl()
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            print("Data: \(data)")
            
            if let response = response as? HTTPURLResponse {
                print("Response all header fields: \(response.allHeaderFields)")
                print("Response status code: \(response.statusCode)")
            }
            
            // При отсутствии доступа в интернет появляется
            // 'The Internet connection appears to be offline.'
            print("Error: \(error)")
        }
        task.resume()
    }
}
