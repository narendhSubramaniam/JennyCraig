//
//  AppDelegate.swift
//  JC-Debug
//
//  Created by Narendh Subramanian on 10/12/21.
//

import UIKit
import Amplify
import AWSCognitoIdentityProvider

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var signInViewController: JCSignInViewController!
    var navigationControllerRoot: UINavigationController?
    var navigationControllerLogin: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setAWS()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func setAWS() {
        
        AWSDDLog.sharedInstance.logLevel = .all

        // setup service configuration
        let serviceConfiguration = AWSServiceConfiguration(region: AWSRegionType.USWest2, credentialsProvider: nil)

        // create pool configuration
        let poolConfiguration = AWSCognitoIdentityUserPoolConfiguration(
            clientId: JCConfigEndPoints.shared.appMode.cognitoIdentityUserPoolAppClientId()!,
            clientSecret: JCConfigEndPoints.shared.appMode.cognitoIdentityUserPoolAppSecret()!,
            poolId: JCConfigEndPoints.shared.appMode.cognitoIdentityUserPoolID()!
        )

        // initialize user pool client
        AWSCognitoIdentityUserPool.register(with: serviceConfiguration, userPoolConfiguration: poolConfiguration, forKey: Identifiers.AWSCognitoUserPoolsSignInProviderKey)

        // fetch the user pool client we initialized in above step
        let pool = AWSCognitoIdentityUserPool(forKey: Identifiers.AWSCognitoUserPoolsSignInProviderKey)
        UNUserNotificationCenter.current().delegate = self
        pool?.delegate = self
    }
    
    
}




extension AppDelegate: AWSCognitoIdentityInteractiveAuthenticationDelegate {
    // present Login VC
    func startPasswordAuthentication() -> AWSCognitoIdentityPasswordAuthentication {
        //if user updates their username from settings
        if JCManager.shared.isUsernameUpdated {
//            if let updateVC = UIApplication.topViewController() as? UpdateEmailPasswordViewController {
//                if let tabBar = updateVC.navigationController?.viewControllers.first as? JCCustomTabBarViewController {
//                    JCManager.shared.isUsernameUpdated = false
//                    if JCManager.shared.resetCodeDoesNotMatched {
//                        JCManager.shared.resetCodeDoesNotMatched = false
//                        return updateVC
//                    } else {
//                        updateVC.navigationController?.popViewController {
//                            UIViewController.displaySpinner()
//                        }
//
//                        if let moreNav = tabBar.selectedViewController as? UINavigationController {
//                            return (moreNav.viewControllers.first as? MoreViewController)!
//                        }
//                    }
//                }
//            }
        }

        if let signInVC = UIApplication.topViewController() as? JCSignInViewController {
            jcPrint("topController:JCSignInViewController")
            return signInVC
        }

        if let goalVC = UIApplication.topViewController() as? JCAccountInfoController {
            jcPrint("topController:JCAccountInfoController")
            return goalVC
        }

        if let confirmEmailVC = UIApplication.topViewController() as? JCConfirmEmailController {
            jcPrint("topController:JCConfirmEmailController")
            return confirmEmailVC
        }

        if let createProfileVC = UIApplication.topViewController() as? JCCreateProfileController {
            jcPrint("topController:JCCreateProfileController")
            return createProfileVC
        }

        DispatchQueue.main.async {
            UIViewController.removeSpinner()
        }

        self.navigationControllerRoot = UIStoryboard.mainNavigationViewController()
        DispatchQueue.main.async {
            self.window?.rootViewController = self.navigationControllerRoot
        }

        let signVC = self.navigationControllerRoot?.viewControllers[0] as? JCLoginSignUpContainerController
        DispatchQueue.main.async {
            signVC?.loadViewIfNeeded()
           
        }

        return signVC!
    }
}
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter( _ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
