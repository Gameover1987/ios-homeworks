
import Foundation
import UserNotifications

final class LocalNotificationsService {
    
    private let updatesNotificationId = "updates"
    
    static let shared = LocalNotificationsService()
    
    private let center = UNUserNotificationCenter.current()
    
    private init () {
        
    }
    
    func registerForLatestUpdatesIfPossible() {

        center.requestAuthorization (options: [.alert, .sound, .badge]) { success, error in
            if let error = error {
                print(error)
                return
            }
            
            if success {
                print("Notifications enabled by user")
                
                self.sendUpdatesNotification()
            } else {
                print("Notifications disabled by user")
            }
        }
    }
    
    private func sendUpdatesNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Новая версия приложения"
        content.body = "Айда обновляться, по красоте все будет!"
        content.categoryIdentifier = "achtung!"
        
        var dateComponents = DateComponents()
        dateComponents.hour = 2
        dateComponents.minute = 2
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: updatesNotificationId, content: content, trigger: trigger)
        
        center.add(request)
    }
}
