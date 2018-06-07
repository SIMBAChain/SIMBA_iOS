//
//  AuditTableViewController.swift
//  HealthSpaceSIMBA_iOS
//
//  Created by Joel Neidig on 4/19/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import UIKit
import Alamofire
class AuditTableViewController: UITableViewController {
    
    var SIMBADataArray = [SIMBAData]()
    var hashLastTen = [SIMBAData]().suffix(10)
    
    var accountSelected: String! = ""
    var accountName: String! = ""
    
   
    //check internet
    func checkInternetConnection()
    {
        if isConnectedToInternet()
        {
            print("connected to internet")
        }
        else
        {
            let alert = UIAlertController(title: "ERROR:", message: "Check internet connection.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.dismiss(animated: true)
            }))
            
            self.present(alert, animated: true)
            
        }
    }
    func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    override func viewDidAppear(_ animated: Bool) {
         print("view did appear")
        super.viewDidAppear(animated)
         checkInternetConnection()
        if !isConnectedToInternet()
        {print("not connected to internet")
            return}
        if accountName == ""
        {
            let accountAlert = UIAlertController(title: "ERROR:", message: "Please Select an Account", preferredStyle: .alert)
            
            accountAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.dismiss(animated: true)
            }))
            
            self.present(accountAlert, animated: true)
        }
        print("========Account========" + accountSelected)
        
        DefaultAPI.getSIMBAData { (SIMBAData, error) in
            if let SIMBAData = SIMBAData{
                print(SIMBAData.first!.encodeToJSON())
            }
            
            self.SIMBADataArray = SIMBAData!
            self.hashLastTen = SIMBAData!.suffix(10)
            self.tableView.reloadData()
        }
    }

    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        checkInternetConnection()
        if !isConnectedToInternet()
        {print("not connected to internet")
            return}
        
        if segue.destination is DetailViewController
        {
            let vc = segue.destination as? DetailViewController
            vc?.accountSelected = accountSelected
            vc?.accountName = accountName
        }
        
        let ten = SIMBADataArray.count - 10
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = hashLastTen[indexPath.row + ten].hashId!
                
                let controller = segue.destination as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
//---------------------
//-----TABLEVIEW
//---------------------
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hashLastTen.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ten = SIMBADataArray.count - 10
        let currentSIMBAData = hashLastTen[indexPath.row + ten]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SIMBADataCell") as! SIMBADataCell
        cell.auditNoLabel.text  = " Audit No. \(String(describing: currentSIMBAData.hashId!))"
        cell.posterIDLabel.text = "Poster No. \(currentSIMBAData.accountId!)"
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    @IBAction func cancelViewController()
    {
        dismiss(animated: true)
    }
}

class SIMBADataCell: UITableViewCell {
    
    @IBOutlet weak var auditNoLabel: UILabel!
    @IBOutlet weak var posterIDLabel: UILabel!
}

