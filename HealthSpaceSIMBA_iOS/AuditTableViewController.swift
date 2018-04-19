//
//  AuditTableViewController.swift
//  HealthSpaceSIMBA_iOS
//
//  Created by Joel Neidig on 4/19/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import UIKit

class AuditTableViewController: UITableViewController {
    
    var SIMBADataArray = [SIMBAData]()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //DefaultAPI.getDwarves calls the DefaultAPI.swift and runs the getDwarves function which executes the getDwarvesWithRequestBuilder function which accesses the basePath for the GET command.
        DefaultAPI.getSIMBAData { (SIMBAData, error) in
            if let SIMBAData = SIMBAData{
                print("\n\n\n")
                print(SIMBAData.first!.encodeToJSON())
                print("\n\n\n")
            }
            
            self.SIMBADataArray = SIMBAData!
            self.tableView.reloadData()
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SIMBADataArray.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentSIMBAData = SIMBADataArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SIMBADataCell") as! SIMBADataCell
        cell.auditNoLabel.text  = " Audit No. \(String(describing: currentSIMBAData.hashId!))"
        cell.posterIDLabel.text = "Poster No. \(currentSIMBAData.accountId!)"
        //cell.nameLabel.text = "name: \(currentDwarf.hash ?? "")"
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
}

class SIMBADataCell: UITableViewCell {
    
    @IBOutlet weak var auditNoLabel: UILabel!
    @IBOutlet weak var posterIDLabel: UILabel!
}

