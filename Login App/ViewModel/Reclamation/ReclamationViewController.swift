//
//  ReclamationViewController.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 5/12/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//

import UIKit
import Alamofire

class ReclamationViewController: UIViewController {
    
    @IBOutlet weak var UiDescription: UITextView!
    var validation = Validation()
    
    @IBAction func AjoutRecButton(_ sender: Any) {
        
        
        let serverUrl = URL(string: Static.URL+"/user/createReclamation")
      //Validation des champs ///
        
      
          
       
          
      

   
         // print("SignUp with success")
        AF.request(serverUrl!,
                     method: .post,
                     parameters: [ "Description" : (UiDescription.text)! ,"Email" :  UserDefaults.standard.string(forKey: "email")!],encoding: URLEncoding.default).validate()
              .responseJSON{ (response) in
                  print(response)
                  
               
                  
              }
        self.send()
        var alert11=UIAlertController(title:NSLocalizedString("Alert ", comment: ""),message:"votre Reclamation est envoyé avec succès",preferredStyle: .alert)
          let ok = UIAlertAction(title: "OK", style: .default,handler: {(action) -> Void in print("ok Button Tapped")})
          alert11.addAction(ok)
          self.present(alert11,animated: true,completion:nil)
                        
      
      }
        
        
    func send(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) {(_,_) in
            
            }
        let content = UNMutableNotificationContent()
        content.title = "Notification de Reclamation"
        content.body = "Votre Reclamation a été prise en considération  "
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let req = UNNotificationRequest(identifier: "req", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(req , withCompletionHandler: nil)
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
