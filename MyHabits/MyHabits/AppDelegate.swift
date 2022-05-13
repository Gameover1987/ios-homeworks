
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
        
        /// Возврат navigationController к реализации до iOS 13
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "white")
        habitsNavigationController.navigationBar.scrollEdgeAppearance = appearance
        infoNavigationController.navigationBar.scrollEdgeAppearance = appearance
        
        habitsNavigationController.tabBarItem = itemHabitsView
        infoNavigationController.tabBarItem = itemInfoView
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .red
        tabBarController.viewControllers = [habitsNavigationController, infoNavigationController]
        tabBarController.selectedViewController = habitsNavigationController
        
        tabBarController.tabBar.unselectedItemTintColor = .gray
        tabBarController.tabBar.tintColor = UIColor(named: "purple")
        tabBarController.tabBar.backgroundColor = UIColor(named: "white")
        tabBarController.tabBar.layer.borderWidth = 1
        tabBarController.tabBar.layer.borderColor = UIColorUtils.FromRGB(red: 189, green: 189, blue: 194).cgColor
        
        window = UIWindow()
        window?.rootViewController = tabBarController
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
        
        return true
    }

}

