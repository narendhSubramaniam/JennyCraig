//  StoryboardExtension.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 7/9/18.
//  Copyright © 2018 JennyCraig. All rights reserved.

import Foundation
import UIKit

extension UIStoryboard {

    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }

    class func loginSignStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }

    class func dashboardStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Dashboard", bundle: Bundle.main)
    }

    class func progressStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Progress", bundle: Bundle.main)
    }

    class func foodListStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "FoodList", bundle: Bundle.main)
    }

    class func moreStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "More", bundle: Bundle.main)
    }

    class func mainNavigationViewController() -> UINavigationController? {
        return loginSignStoryboard().instantiateViewController(withIdentifier: "JCMainNavigationController") as? UINavigationController
    }

    class func progressNavigation() -> UINavigationController? {
        return progressStoryboard().instantiateViewController(withIdentifier: "progressNavigation") as? UINavigationController
    }


    class func moreNavigation() -> UINavigationController? {
        return moreStoryboard().instantiateViewController(withIdentifier: "moreNavigation") as? UINavigationController
    }


    class func profileCreator() -> JCCreateProfileController? {
        return loginSignStoryboard().instantiateViewController(withIdentifier: "JCCreateProfileController") as? JCCreateProfileController
    }

    class func forgotPasswordVC() -> JCForgotPasswordController? {
        return loginSignStoryboard().instantiateViewController(withIdentifier: "JCForgotPasswordController") as? JCForgotPasswordController
    }
    class func loginSignUpVC() -> JCLoginSignUpContainerController? {
        return loginSignStoryboard().instantiateViewController(withIdentifier: "JCLoginSignUpContainerController") as? JCLoginSignUpContainerController
    }
    class func emailAlreadyExistVC() -> JCEmailAlreadyExistVC? {
          return loginSignStoryboard().instantiateViewController(withIdentifier: "JCEmailAlreadyExistVC") as? JCEmailAlreadyExistVC
      }

    
    class func resetPasswordVC() -> JCPasswordResetController? {
        return loginSignStoryboard().instantiateViewController(withIdentifier: "JCPasswordResetController") as? JCPasswordResetController
    }

    class func accountInfoController() -> JCAccountInfoController? {
        return loginSignStoryboard().instantiateViewController(withIdentifier: "JCAccountInfoController") as? JCAccountInfoController
    }

    class func confirmEmailController() -> JCConfirmEmailController? {
        return loginSignStoryboard().instantiateViewController(withIdentifier: "JCConfirmEmailController") as? JCConfirmEmailController
    }

    class func privacyPolicyViewController() -> JCTermsConditionsViewController? {
        return loginSignStoryboard().instantiateViewController(withIdentifier: "JCTermsConditionsViewController") as? JCTermsConditionsViewController
    }

    class func noInternetViewController() -> NoInternetViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "NoInternetViewController") as? NoInternetViewController
    }

    class func notCompatibleViewController() -> NotCompatibleViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "NotCompatibleViewController") as? NotCompatibleViewController
    }
    class func signInViewController() -> JCSignInViewController? {
        return loginSignStoryboard().instantiateViewController(withIdentifier: "JCSignInViewController") as? JCSignInViewController
    }
}
