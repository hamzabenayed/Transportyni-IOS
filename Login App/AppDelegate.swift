
// AppDelegate.swift
import UIKit
import FBSDKCoreKit
import FBAEMKit
import FBSDKCoreKit_Basics
import FBSDKLoginKit
import FBSDKShareKit
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices

@UIApplicationMain
	class AppDelegate: UIResponder, UIApplicationDelegate {
        
        
        
        
func application(
    

    
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
    
    
    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
        if error != nil || user == nil {
          // Show the app's signed-out state.
        } else {
          // Show the app's signed-in state.
        }
      }
       
    ApplicationDelegate.shared.application(
        application,
        didFinishLaunchingWithOptions: launchOptions
    )
   
    return true
    
}
        
        
     
        
      //768967657081-en9t53f27bbtvgl0hsnk2vna8172hi9o.apps.googleusercontent.com
func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
) -> Bool {
    
    ApplicationDelegate.shared.application(
        app,
        open: url,
        sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
        annotation: options[UIApplication.OpenURLOptionsKey.annotation]
    )
}
    
    func application(app: UIApplication,open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      var handled: Bool

      handled = GIDSignIn.sharedInstance.handle(url)
      if handled {
        return true
      }

      // Handle other custom URL types.

      // If not handled by this app, return false.
      return false
    }
        
        
        
        
        
        
}
