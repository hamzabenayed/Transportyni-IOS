//
//  ForgetPassEmailViewController.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 28/11/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//

import UIKit
import Alamofire

class ForgetPassEmailViewController: UIViewController {
    
    @IBOutlet weak var UiemailForgetpass: UITextField!
    var validation = Validation()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func EmailConfirm(_ sender: Any) {
        
        
       
        let serverUrl = URL(string: Static.URL+"/user/reset")
        
        guard  let email = UiemailForgetpass.text else { return}
        
        let isValidateEmail = self.validation.validateEmailId(emailID: email)
       if (isValidateEmail == false){
           var alert11=UIAlertController(title:"Alert ",message:"Veuillez verfier votre Adresse email",preferredStyle: .alert)
           let ok = UIAlertAction(title: "OK", style: .default,handler: {(action) -> Void in print("ok Button Tapped")})
           alert11.addAction(ok)
           self.present(alert11,animated: true,completion:nil)
          print("Incorrect Email")
          return
       }
        
        // print("login with success")
        AF.request(serverUrl!,
                   method: .post,
                   parameters: [ "email" : email ],encoding: URLEncoding.default).validate(statusCode: 200..<300)
            .validate().responseDecodable(of: User.self) {
                (response) in
                //Error handling
                switch response.result {
                case .success(let res):
                    print("True")
                  
                    self.performSegue(withIdentifier: "emailpasstoconfirmation", sender: self)
                    
                    
                    
                case let .failure(error):
                 
                    print("false")
                    
                    
                }
                print(response)
                
                
            }
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


