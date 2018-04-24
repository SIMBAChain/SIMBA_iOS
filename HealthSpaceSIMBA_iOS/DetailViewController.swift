//
//  DetailView.swift
//  HealthSpaceSIMBA_iOS
//
//  Created by Steven Peregrine on 4/23/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Foundation
import UIKit
class DetailViewController: UIViewController
{
    @IBOutlet  var IPFS: UITextField!
    @IBOutlet  var TimeStamp: UITextField!
    @IBOutlet  var Location: UITextField!
    @IBOutlet  var Name: UITextField!
    @IBOutlet  var Desc: UITextView!
    @IBOutlet  var Status: UITextField!
    @IBOutlet  var Comments: UITextView!
    @IBOutlet  var VerStatus: UITextField!
    @IBOutlet  var FirstAudit: UITextField!
    @IBOutlet  var SecondAudit: UITextField!
    @IBOutlet  var CorrectButton: UIButton!
    @IBOutlet  var IncorrectButton: UIButton!
    
    var auditNumber: Int32! = 0
    
    func configureView()
    {
        // Update the user interface for the detail item.
        if let detail = detailItem
        {
            auditNumber = Int32(detail.description)!
            
            print(auditNumber!)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    var detailItem: Int32?
    {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    func getData()
    {
        
    }
}
    
}
