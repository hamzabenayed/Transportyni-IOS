//
//  UpdateProfileViewController.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 25/11/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//

import UIKit
import Alamofire

class UpdateProfileViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    var validation = Validation()
    @IBOutlet weak var uiPrenom: UITextField!
    @IBOutlet weak var uiNom: UITextField!
  
    @IBOutlet weak var uiImageProfile: UIImageView!
    
    @IBOutlet weak var Backtosettings: UIButton!
    
    @IBOutlet weak var uiEmail: UITextField!
    @IBOutlet weak var uiMobile: UITextField!
    var resultArray: Array<Dictionary<String, AnyObject>> = []

    override func viewDidLoad() {
        let defaults = UserDefaults.standard
        uiPrenom.text = UserDefaults.standard.string(forKey: "firstName")
        uiNom.text = UserDefaults.standard.string(forKey: "lastName")
        uiEmail.text = UserDefaults.standard.string(forKey: "email")
        uiMobile.text = UserDefaults.standard.string(forKey: "mobile")
          
                super.viewDidLoad()
        
        
    
         //uiImageProfile.contentMode = UIView.ContentMode.scaleAspectFit
                
//        uiImageProfile.imageFromServerURL(urlString: UserDefaults.standard.string(forKey: "profilePicture")!)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func UpdatePofile(_ sender: Any) {
        
        
        let serverUrl = URL(string: Static.URL+"/user/")
       
    
    //Validation des champs ///
        let isValidateEmail = self.validation.validateEmailId(emailID: uiEmail.text!)
        if (isValidateEmail == false){
            var alert11=UIAlertController(title:"Alert ",message:"Veuillez verfier votre Adresse email",preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default,handler: {(action) -> Void in print("ok Button Tapped")})
            alert11.addAction(ok)
            self.present(alert11,animated: true,completion:nil)
            print("Incorrect Email")

        }
       
    
        
        let isValidatePhone = self.validation.validaPhoneNumber(phoneNumber: uiMobile.text!)
        if (isValidatePhone == false) {
            var alert11=UIAlertController(title:"Alert ",message:"Veuillez verfier votre numéro de téléphone",preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default,handler: {(action) -> Void in print("ok Button Tapped")})
            alert11.addAction(ok)
            self.present(alert11,animated: true,completion:nil)
            print("Incorrect Phone")
            return
        }
        let isValidatelastName = self.validation.validateName(name:  uiPrenom.text!)
        if (isValidatelastName == false) {
            var alert11=UIAlertController(title:"Alert ",message:"Veuillez verfier votre prénom",preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default,handler: {(action) -> Void in print("ok Button Tapped")})
            alert11.addAction(ok)
            self.present(alert11,animated: true,completion:nil)
            print("Incorrect lastName")
            return
        }
        let isValidatefirstName = self.validation.validateName(name:  uiNom.text! )
        if (isValidatefirstName == false) {
            var alert11=UIAlertController(title:"Alert ",message:"Veuillez verfier votre nom",preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default,handler: {(action) -> Void in print("ok Button Tapped")})
            alert11.addAction(ok)
            self.present(alert11,animated: true,completion:nil)
            print("Incorrect firstName")
            return
        }
    

   
    if (isValidatelastName == true || isValidateEmail == true  || isValidatePhone == true || isValidatefirstName==true) {
       print("All fields are correct")
    } else {
        print ("wrong fields try again")
    }
       // print("SignUp with success")
        AF.request(serverUrl!,
                   method: .patch,
                   parameters: [ "firstName" : (uiPrenom.text)! , "lastName" : (uiNom.text)!,"email" :  UserDefaults.standard.string(forKey: "email")!,"mobile" : (uiMobile.text)!],encoding: URLEncoding.default).validate()
            .responseJSON{ (response) in
                print(response)
                
             
                
            }
        var alert11=UIAlertController(title:"Alert ",message:"votre Profile a été Modifié avec succès",preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default,handler: {(action) -> Void in print("ok Button Tapped")})
        alert11.addAction(ok)
        self.present(alert11,animated: true,completion:nil)
                      
    
    }
    @IBAction func uiSelectimage(_ sender: Any) {
        
        let picker = UIImagePickerController()
               picker.allowsEditing = true
               picker.delegate = self
               present(picker, animated: true)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.editedImage] as? UIImage else {
                return
            }
        uiImageProfile.image = image
            
            dismiss(animated: true)
        }
    func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }
    
    func propmt(title:String, message:String){
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let action = UIAlertAction(title: "OK", style: .destructive , handler: nil)
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
       }
    func setUser(){
        //userID = resultArray[0]["_id"] as! String
    
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
