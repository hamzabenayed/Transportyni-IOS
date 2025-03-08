//
//  ViewController.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 21/11/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    truct MapViewRepresentable: UIViewControllerRepresentable {

        func makeUIViewController(context: UIViewControllerRepresentableContext<MapViewRepresentable>) -> UIViewController {
            let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
            let Controller = sb.instantiateViewController(identifier: "MapView")
            return Controller
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<MapViewRepresentable>) {
            
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
