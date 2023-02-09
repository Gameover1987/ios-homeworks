
import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var rootCoordinator: LoginCoordinator?
    
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        self.window = window
        
        FirebaseApp.configure()
        
        LocalNotificationsService.shared.registerForLatestUpdatesIfPossible()
        
        rootCoordinator = LoginCoordinator(window: window)
        rootCoordinator?.start()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        Authorizer.shared.signOut()
    }
}
