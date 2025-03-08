//
//  UISignUpViewController.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 23/11/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//

import UIKit
import Alamofire
class UISignUpViewController: UIViewController{

    
    @IBOutlet weak var uiFirstname: UITextField!
    @IBOutlet weak var uiLastname: UITextField!
    @IBOutlet weak var uiMobile: UITextField!
    @IBOutlet weak var uiAdresse: UITextField!
    @IBOutlet weak var uiPassword: UITextField!
    @IBOutlet weak var uiEmail: UITextField!
    var validation = Validation()

    
    
    @IBAction func Tologin(_ sender: Any) {
        
        self.performSegue(withIdentifier: "Signuptologin", sender: self)
    }
    
    
    @IBAction func UISignupButton(_ sender: Any) {
            let serverUrl = URL(string: Static.URL+"/user/register")
           
            guard  let firstname = uiFirstname.text else { return}
            guard  let lastname = uiLastname.text else { return}
            guard  let mobile = uiMobile.text else { return}
            guard  let adresse = uiAdresse.text else { return}
            guard  let password = uiPassword.text else { return}
            guard  let email = uiEmail.text else { return}
        
        //Validation des champs ///
            let isValidateEmail = self.validation.validateEmailId(emailID: email)
            if (isValidateEmail == false){
                var alert11=UIAlertController(title:"Alert ",message:"Veuillez verfier votre Adresse email",preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default,handler: {(action) -> Void in print("ok Button Tapped")})
                alert11.addAction(ok)
                self.present(alert11,animated: true,completion:nil)
                print("Incorrect Email")

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
            let isValidateadresse = self.validation.validateAnyOtherTextField(otherField: adresse)
            if (isValidateadresse == false) {
                var alert11=UIAlertController(title:"Alert ",message:"Veuillez verfier votre Adresse",preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default,handler: {(action) -> Void in print("ok Button Tapped")})
                alert11.addAction(ok)
                self.present(alert11,animated: true,completion:nil)
                print("Incorrect Adresse")
                return
            }
            
            let isValidatePhone = self.validation.validaPhoneNumber(phoneNumber: mobile)
            if (isValidatePhone == false) {
                var alert11=UIAlertController(title:"Alert ",message:"Veuillez verfier votre numéro de téléphone",preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default,handler: {(action) -> Void in print("ok Button Tapped")})
                alert11.addAction(ok)
                self.present(alert11,animated: true,completion:nil)
                print("Incorrect Phone")
                return
            }
            let isValidatelastName = self.validation.validateName(name: lastname)
            if (isValidatelastName == false) {
                var alert11=UIAlertController(title:"Alert ",message:"Veuillez verfier votre prénom",preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default,handler: {(action) -> Void in print("ok Button Tapped")})
                alert11.addAction(ok)
                self.present(alert11,animated: true,completion:nil)
                print("Incorrect lastName")
                return
            }
            let isValidatefirstName = self.validation.validateName(name: firstname)
            if (isValidatefirstName == false) {
                var alert11=UIAlertController(title:"Alert ",message:"Veuillez verfier votre nom",preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default,handler: {(action) -> Void in print("ok Button Tapped")})
                alert11.addAction(ok)
                self.present(alert11,animated: true,completion:nil)
                print("Incorrect firstName")
                return
            }
        
    
       
        if (isValidatelastName == true || isValidateEmail == true || isValidatePass == true || isValidatePhone == true ||  isValidateadresse == true || isValidatefirstName==true) {
           print("All fields are correct")
        } else {
            print ("wrong fields try again")
        }
           // print("SignUp with success")
        AF.request(serverUrl!,
                       method: .post,
                       parameters: [ "firstName" : firstname , "lastName" : lastname,"email" : email,"password" : password,"mobile" : mobile,"Adresse" : adresse],encoding: URLEncoding.default).validate()
                .responseJSON{ (response) in
                    print(response)
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let MapView = storyboard.instantiateViewController(withIdentifier: "confirmationcode")
                    
                    self.performSegue(withIdentifier: "SignUPtoconfirmaioncode", sender: self)
                    
                }
        
       
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       

    }    }
    

   


