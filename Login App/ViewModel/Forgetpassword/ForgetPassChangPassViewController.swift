//
//  ForgetPassChangPassViewController.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 28/11/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//

import UIKit
import Alamofire
class ForgetPassChangPassViewController: UIViewController {
    var validation = Validation()
    @IBOutlet weak var UiNewPassword: UITextField!
    @IBAction func uiBackTOLOGIN(_ sender: Any) {
        self.performSegue(withIdentifier: "newpasstologin", sender: self)

    }
    
    
    @IBOutlet weak var UirepeatPass: UITextField!
    
    @IBAction func ConfirmNewpassButton(_ sender: Any) {
        
  
        guard let serverUrl = URL(string: Static.URL+"/user/updatepass/"+UserDefaults.standard.string(forKey: "id")!) else { return }
        
        guard  let password = UiNewPassword.text else { return}
        
        let isValidatePass = self.validation.validatePassword(password: password)
        if (isValidatePass == false) {
            
            var alert11=UIAlertController(title:"Alert ",message:"Veuillez verfier votre Mot de passe",preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default,handler: {(action) -> Void in print("ok Button Tapped")})
            alert11.addAction(ok)
            self.present(alert11,animated: true,completion:nil)
            print("Incorrect Password")
            return
        }
        
        if(password != UirepeatPass.text){
            
            var alert11=UIAlertController(title:"Alert ",message:"les deux Mot de passes non identiques",preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default,handler: {(action) -> Void in print("ok Button Tapped")})
            alert11.addAction(ok)
            self.present(alert11,animated: true,completion:nil)
            
           
            
        } else {
            
            // print("login with success")
            AF.request(serverUrl,
                       method: .post,
                       parameters: [ "password" : password ],encoding: URLEncoding.default).validate()
                .responseJSON{ (response) in
                    print(response)
                   
                  
                }
            var alert11=UIAlertController(title:"Alert ",message:"Mot de passe Modifié avec succeé",preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default,handler: {(action) -> Void in print("ok Button Tapped")})
            alert11.addAction(ok)
            self.present(alert11,animated: true,completion:nil)
        }
        self.performSegue(withIdentifier: "newpasstologin", sender: self)

        
    }
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
