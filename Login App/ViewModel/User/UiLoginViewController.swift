//
//  UiLoginViewController.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 23/11/2022.
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
import LocalAuthentication
import AuthenticationServices

class UiLoginViewController: UIViewController, LoginButtonDelegate {
    var Static = Staticcs()
    let signInCofig = GIDConfiguration.init(clientID: "768967657081-en9t53f27bbtvgl0hsnk2vna8172hi9o.apps.googleusercontent.com")
    var context = LAContext()
    @IBOutlet weak var UIemail: UITextField!
    
    @IBOutlet weak var loginProviderStackView: UIStackView!
    
    @IBOutlet weak var UIPassword: UITextField!
    var validation = Validation()
    @IBOutlet weak var EmailLabel: UILabel!
 
    
    @IBOutlet weak var Passlabel: UILabel!
 
    
    
    @IBAction func ForgetPassword(_ sender: Any) {
        self.performSegue(withIdentifier: "logintoemailpass", sender: self)
    }
    
    var iconClick = true
    @IBAction func iconAction(_ sender: Any) {
        if iconClick {
            UIPassword.isSecureTextEntry = false
            
        }else{
            UIPassword.isSecureTextEntry = true
        }
        iconClick = !iconClick
        
    }
    @IBAction func FnLogin(_ sender: Any) {
        let serverUrl = URL(string: Static.URL+"/user/login")
        
        let defaults = UserDefaults.standard
        
        guard   let email = UIemail.text else { return}
        guard   let password = UIPassword.text else { return}
        let isValidateEmail = self.validation.validateEmailId(emailID: email)
        if (isValidateEmail == false){
            var alert11=UIAlertController(title:"Alert ",message:"Veuillez verfier votre Adresse email",preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default,handler: {(action) -> Void in print("ok Button Tapped")})
            alert11.addAction(ok)
            self.present(alert11,animated: true,completion:nil)
            print("Incorrect Email")
            return
        }
        let isValidatePass = self.validation.validatePassword(password: password)
        if (isValidatePass == false) {
            var alert11=UIAlertController(title:"Alert ",message:"Veuillez verfier votre Mot de passe",preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default,handler: {(action) -> Void in print("ok Button Tapped")})
            alert11.addAction(ok)
            self.present(alert11,animated: true,completion:nil)
            print("Incorrect Password")
            return
        }
        
        if ( isValidateEmail == true || isValidatePass == true ) {
            print("All fields are correct")
        } else {
            print ("wrong fields try again")
        }
        
        // print("login with success")
        AF.request(serverUrl!,
                   method: .post,
                   parameters: [ "email" : email, "password" :password ],encoding: URLEncoding.default).validate(statusCode: 200..<300)
            .validate().responseDecodable(of: User.self) {
                (response) in
                //Error handling
                switch response.result {
                case .success(let res):
                    
                    print("Login successful")
                    // print(res.firstName)
                    let defaults = UserDefaults.standard
                    defaults.set((res._id)!, forKey: "id")
                    defaults.set((res.lastName)!, forKey: "lastName")
                    defaults.set((res.firstName)!, forKey: "firstName")
                    defaults.set((res.mobile)!, forKey: "mobile")
                    defaults.set((res.Adresse)!, forKey: "adresse")
                    defaults.set((res.email)!, forKey: "email")
                    defaults.set((res.verified), forKey: "verified")
                    defaults.set((true), forKey: "IsUserLoggedIn")
                    defaults.synchronize()
                    
                    if ((UserDefaults.standard.string(forKey: "verified") != nil) == true ) {
                        self.performSegue(withIdentifier: "LogintoMapView", sender: self)
                        print("True")
                    }
                    else {
                        print("flase")
                        self.performSegue(withIdentifier: "LoginToConfirmCode", sender: self)
                    }
                    
                    
                    
                case let .failure(error):
                    
                    var alert11=UIAlertController(title:"Alert ",message:"email ou password est Incorrect",preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default,handler: {(action) -> Void in print("ok Button Tapped")})
                    alert11.addAction(ok)
                    self.present(alert11,animated: true,completion:nil)
                    print("false")
                    
                    print("false")
                    
                    
                }
                print(response)
                
            }
        
        
        
    }
    
    
    
    
    @IBAction func FaceID(_ sender: Any) {
        context = LAContext()

        context.localizedCancelTitle = "Enter Username/Password"

        // First check if we have the needed hardware support.
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            print(error?.localizedDescription ?? "Can't evaluate policy")

            // Fall back to a asking for username and password.
            // ...
            return
        }
        Task {
            do {
                
                let defaults = UserDefaults.standard
                defaults.set("mondher.1858@gmail.com", forKey: "email")
                try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Log in to your account")
               
                defaults.set((true), forKey: "IsUserLoggedIn")
                self.performSegue(withIdentifier: "LogintoMapView", sender: self)

            } catch let error {
                print(error.localizedDescription)

                // Fall back to a asking for username and password.
                // ...
            }
        }

      
    }
    
    @IBAction func uiSignUpButton(_ sender: Any) {
        
        
        
        self.performSegue(withIdentifier: "logintosignup", sender: self)
    }
    
    
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     self.UIemail.text = UserDefaults.standard.string(forKey: "email")
     
     if segue.identifier=="LoginToConfirmCode"{
     let destinationcontroller = segue.destination as! UpdateProfileViewController
     destinationcontroller.uiEmail = UIemail
     }
     }*/
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupProviderLoginView()
        
        
        
        if AccessToken.current != nil {
            // Already logged-in
            // Redirect to Home View Controller
            self.performSegue(withIdentifier: "logintosignup", sender: self)
        }
        
        
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        loginButton.frame = CGRect(x: 80, y: 430, width: 230, height: 40)
        loginButton.delegate = self
        loginButton.permissions = [	"email","public_profile"]
        view.addSubview(loginButton)
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func loginButton(_ loginButton: FBSDKLoginKit.FBLoginButton, didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?, error: Error?) {
       
        let token  = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields":"email, name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        request.start { (connection, result, error) in
        
            if let res = result {
                if let response = res as? [String: Any] {
                    let username = response["name"]
                    let email = (response["email"])!
                    
                    if error != nil {
                        print(error)
                        return
                    } else {
                     
                        let defaults = UserDefaults.standard
                        //let email = result!.value(forKey: "email")
                     
                    defaults.set(email, forKey: "email")
                        DispatchQueue.main.async {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let tabbarVC = storyboard.instantiateViewController(withIdentifier: "tabbar")
                            self.present(tabbarVC, animated: false, completion: nil)
                        }
                        
                        
                    }
                    
                }
                    }
            
        }
        
    
        
        
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        
    }
    ////////////////////////////
    /////////////////////////////
   


    @IBAction func GoogleLoginButton(_ sender: Any) {
       
        
        
    }
 
    
    
    @IBAction func GooglelogIn(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInCofig, presenting: self) { user, error in



            guard error == nil else { return
              }
            guard let user = user else {return
                
            }
            let emailAddress = user.profile?.email
            let defaults = UserDefaults.standard
        
            defaults.set(emailAddress, forKey: "email")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabbarVC = storyboard.instantiateViewController(withIdentifier: "tabbar")
          
            defaults.set((true), forKey: "IsUserLoggedIn")
            self.present(tabbarVC, animated: false, completion: nil)
            
            // If sign in succeeded, display the app's main content View.
          }
        
        
   
        
    }
    
    /////////////////////////////////////////// appleid
    
    //apple authentification
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performExistingAccountSetupFlows()
    }
    
    /// - Tag: add_appleid_button
    func setupProviderLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.loginProviderStackView.addArrangedSubview(authorizationButton)
    }
    
    // - Tag: perform_appleid_password_request
    /// Prompts the user if an existing iCloud Keychain credential or Apple ID credential is found.
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension UiLoginViewController: ASAuthorizationControllerDelegate {
    /// - Tag: did_complete_authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
            self.saveUserInKeychain(userIdentifier)
            
            // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
            self.showResultViewController()
        
        case let passwordCredential as ASPasswordCredential:
        
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                self.showPasswordCredentialAlert(username: username, password: password)
            }
            
        default:
            break
        }
    }
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "com.example.apple-samplecode.juice", account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
    
    private func showResultViewController() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbarVC = storyboard.instantiateViewController(withIdentifier: "MapView")
        self.present(tabbarVC, animated: false, completion: nil)
        
    }
    
    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Keychain Credential Received",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// - Tag: did_complete_error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
   
}

extension UiLoginViewController: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension UIViewController {
    
    func showLoginViewController() {
        func showLoginViewController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let loginViewController = storyboard.instantiateViewController(withIdentifier: "Login") as? UiLoginViewController {
                loginViewController.modalPresentationStyle = .formSheet
                loginViewController.isModalInPresentation = true
                self.present(loginViewController, animated: true, completion: nil)
            }
        }
    }
    
  
    //appleconnection
   
 
        
        
    
   
    
}
extension String {
    /// - Tag: provide_presentation_anchor
    func localized() -> String {
        return NSLocalizedString(self,
        tableName: "Localizable",
        bundle: .main,
        value: self,
        comment: self)
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


