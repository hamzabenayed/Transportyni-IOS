//
//  ForgetPassCodeViewController.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 28/11/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//

import UIKit
import Alamofire

class ForgetPassCodeViewController: UIViewController {

    @IBOutlet weak var UiConfirmatiocode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Confirmcodebutton(_ sender: Any) {
        
   
        let serverUrl = URL(string: Static.URL+"/user/verify")
        
        guard  let textcode = UiConfirmatiocode.text else { return}
        
        
        
        // print("login with success")
        AF.request(serverUrl!,
                   method: .post,
                   parameters: [ "activationCode" : textcode ],encoding: URLEncoding.default).validate(statusCode: 200..<300)
            .validate().responseDecodable(of: User.self) {
                (response) in
                //Error handling
                switch response.result {
                case .success(let res):
                    
                    print("true")
                    self.performSegue(withIdentifier: "ConfirmPasstonewpass", sender: self)

                    
                    
                    
                case let .failure(error):
                    var alert11=UIAlertController(title:"Alert ",message:"Confirmation Code Incorrect",preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default,handler: {(action) -> Void in print("ok Button Tapped")})
                    alert11.addAction(ok)
                    self.present(alert11,animated: true,completion:nil)
                    print("false")
                    
                    
                }
                print(response)
                
                
                
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

}
