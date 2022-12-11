
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var rootCoordinator: LoginCoordinator?
    var config: AppConfiguration = AppConfiguration.planets
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        self.window = window
        config = AppConfiguration.firstPlanet
        rootCoordinator = LoginCoordinator(window: window)
        rootCoordinator?.start()
        
        return true
    }
}
