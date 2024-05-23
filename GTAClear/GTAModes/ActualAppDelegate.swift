

import UIKit
import Adjust
import SwiftyDropbox
import Pushwoosh
import AVFoundation

@main
class ActualAppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Start monitoring network status
        ActualNetworkStatusMonitor3862.shared.gta_startMonitoring()
        return true
    }

}

// MARK: - Pushwoosh Integration
extension ActualAppDelegate : PWMessagingDelegate {
    
    // Устанавливаем принудительно только портретный режим экрана
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return .portrait
        }
}

