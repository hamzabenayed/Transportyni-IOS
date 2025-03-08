//
//  ProfiluserViewController.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 28/11/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKCoreKit
import FBAEMKit
import FBSDKCoreKit_Basics
import FBSDKLoginKit
import FBSDKShareKit
import GoogleSignIn
import AuthenticationServices

class ProfiluserViewController: UIViewController, LoginButtonDelegate {

    @IBOutlet weak var UImobile: UILabel!
    
    @IBOutlet weak var UIadresse: UILabel!
    @IBOutlet weak var UIprenom: UILabel!
    
    @IBOutlet weak var UInom: UILabel!
 
    
    @IBAction func Updateto(_ sender: Any) {
        self.performSegue(withIdentifier: "ToUpdateProfile", sender: self)
    }
  
    @IBAction func Logout(_ sender: Any) {
        //let loginManager = LoginManager()
        //loginManager.logOut()
        UserDefaults.standard.removeObject(forKey: "lastName")
        UserDefaults.standard.removeObject(forKey: "firstName")
        UserDefaults.standard.removeObject(forKey: "mobile")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "IsUserLoggedIn")
     
        UserDefaults.standard.synchronize()
        self.performSegue(withIdentifier: "deconnexiontologin", sender: self)
    }
    
    
    override func viewDidLoad() {
        let defaults = UserDefaults.standard
        if(UserDefaults.standard.string(forKey: "firstName") != nil &&   UserDefaults.standard.string(forKey: "lastName") != nil       ) {
          //  UIadresse.text = UserDefaults.standard.string(forKey: "email")!
            UIprenom.text = UserDefaults.standard.string(forKey: "firstName")!
            UInom.text = UserDefaults.standard.string(forKey: "lastName")!
           // UImobile.text = UserDefaults.standard.string(forKey: "mobile")!
            
        }
        else {
          //  UIadresse.text = "mondher.1857@gmail.com"
            UIprenom.text = "Mondher"
            UInom.text = "Ben haj Ammar"
            
        //    UImobile.text = "989635778"
            
        }

       
        
        if AccessToken.current != nil {
            // Already logged-in
            // Redirect to Home View Controller
          //  self.performSegue(withIdentifier: "login", sender: self)
            
            
           let profilepicture = FBProfilePictureView()
        
            profilepicture.frame = CGRect(x: 135, y: 120, width: 120, height: 120)
            profilepicture.profileID = AccessToken.current!.userID
            view.addSubview(profilepicture)
            let loginButton = FBLoginButton()
            loginButton.backgroundColor = .darkGray
            loginButton.center = view.center
            loginButton.frame = CGRect(x: 100, y: 680, width: 200, height: 40)
            loginButton.delegate = self
            loginButton.permissions = [    "email","public_profile"]
            view.addSubview(loginButton)
           
            
        }
        
            
            

        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }
    

    
     func loginButton(_ loginButton: FBSDKLoginKit.FBLoginButton, didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?, error: Error?) {
         let token  = result?.token?.tokenString
         let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                  parameters: ["fields":"email, name"],
                                                  tokenString: token,
                                                  version: nil,
                                                  httpMethod: .get)
         
         
         if error != nil {
              print(error)
              return
         } else {
             
             DispatchQueue.main.async {
                 let storyboard = UIStoryboard(name: "Main", bundle: nil)
                 let tabbarVC = storyboard.instantiateViewController(withIdentifier: "tabbar")
                 self.present(tabbarVC, animated: false, completion: nil)
             }
            
           
             
         }
         
         
     }
     
     
     func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
          self.performSegue(withIdentifier: "deconnexiontologin", sender: self)
     }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  
}
