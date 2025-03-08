//
//  StationViewController.swift
//  Transportyni App
//
//  Created by HAMZAMONDHER on 5/12/2022.
//  Copyright © 2022 Balaji. All rights reserved.
//
/*
import UIKit
import Alamofire
class StationViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
   var apiResult = [Station]()
    @IBOutlet weak var StationtableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        APIHandler.sharedInstance.fetchinAPIData{ apiData in
            self.apiResult = apiData
            DispatchQueue.main.async {
                self.StationtableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var table: UITableView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension StationViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiResult.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1") else {return UITableViewCell()}
        cell1.textLabel?.text = apiResult[indexPath.row].Région
        guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2") else {return UITableViewCell()}
        cell2.textLabel?.text = apiResult[indexPath.row].NomStation
        return cell2;cell1
    }
    
    }
*/
