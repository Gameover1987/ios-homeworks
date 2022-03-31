
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let habitsViewController = HabitsViewController()
        let infoViewController = InfoViewController()
        
        let habitsNavigationController = UINavigationController(rootViewController: habitsViewController)
        let infoNavigationController = UINavigationController(rootViewController: infoViewController)
        
        let itemHabitsView = UITabBarItem()
        itemHabitsView.image = UIImage(systemName: "equal")
        itemHabitsView.title = "Привычки"
        
        let itemInfoView = UITabBarItem()
        itemInfoView.image = UIImage(systemName: "info.circle.fill")
        itemInfoView.title = "Информация"
        
        habitsNavigationController.tabBarItem = itemHabitsView
        infoNavigationController.tabBarItem = itemInfoView
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [habitsNavigationController, infoNavigationController]
        tabBarController.selectedViewController = habitsNavigationController
        
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.unselectedItemTintColor = .gray
        tabBarController.tabBar.backgroundColor = UIColorUtils.FromRGB(red: 242, green: 242, blue: 247)
        tabBarController.tabBar.layer.borderWidth = 1
        tabBarController.tabBar.layer.borderColor = UIColorUtils.FromRGB(red: 189, green: 189, blue: 194).cgColor
        
        window = UIWindow()
        window?.rootViewController = tabBarController
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
        
        return true
    }

}

