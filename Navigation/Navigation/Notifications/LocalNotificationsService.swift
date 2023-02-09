
import Foundation
import UserNotifications

final class LocalNotificationsService : NSObject {
    
    enum UpdateType : String {
        case light = "Light"
        case hard = "Hard"
    }
    
    private let notificationsCategory = "achtung!"
    
    private let updatesNotificationId = "updates"
    
    static let shared = LocalNotificationsService()
    
    private let center = UNUserNotificationCenter.current()
    
    private override init () {
        super.init()
    }
    
    func registerForLatestUpdatesIfPossible() {

        center.requestAuthorization (options: [.alert, .sound, .badge]) { success, error in
            if let error = error {
                print(error)
                return
            }
            
            if success {
                print("Notifications enabled by user")
                
                self.center.delegate = self
                self.registerCategories()
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
        content.categoryIdentifier = notificationsCategory
        
        var dateComponents = DateComponents()
        dateComponents.hour = 2
        dateComponents.minute = 20
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: updatesNotificationId, content: content, trigger: trigger)
        
        center.add(request)
    }
    
    private func registerCategories() {
        let center = UNUserNotificationCenter.current()
        
        let action1 = UNNotificationAction(identifier: UpdateType.light.rawValue, title: "Обновить только данные")
        let action2 = UNNotificationAction(identifier: UpdateType.hard.rawValue, title: "Обновить приложение целиком")
        
        let category = UNNotificationCategory(identifier: notificationsCategory, actions: [action1, action2], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
}

extension LocalNotificationsService : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UpdateType.light.rawValue:
            print("Будут обновлены данные приложения")
        case UpdateType.hard.rawValue:
            print("Приложение будет обновлено целиком")
        default:
            print("Неизвестный тип действия по уведомлению!")
        }
        
        completionHandler()
    }
}
