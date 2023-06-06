import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private let dependencies = DependencyContainer(cache: CacheProxy(serviceName: "main"))
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let navigator = NavigatorImpl(dependencies: dependencies, navigationController: navigationController)
        
        appCoordinator = AppCoordinator(
            window: window!,
            dependencies: dependencies,
            navigationController: navigationController,
            navigator: navigator)
        appCoordinator?.start()

        return true
    }
}

