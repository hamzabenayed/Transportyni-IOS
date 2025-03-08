//
//  NewViewController.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 25/11/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//

import UIKit
import SideMenu
class NewViewController: UIViewController {
    var menu :SideMenuNavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()

        menu = SideMenuNavigationController(rootViewController: UIViewController())

    }
    @IBAction func didTapMenu(){
        present(menu!,animated: true)
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
