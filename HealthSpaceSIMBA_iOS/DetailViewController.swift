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
    @IBOutlet  var auditNo: UITextField!
    @IBOutlet  var posterID: UITextField!
    @IBOutlet  var IPFS: UITextField!
    @IBOutlet  var timeStamp: UITextField!
    @IBOutlet  var location: UITextField!
    @IBOutlet  var name: UITextField!
    @IBOutlet  var desc: UITextView!
    @IBOutlet  var status: UITextField!
    @IBOutlet  var comments: UITextView!
    @IBOutlet  var verStatus: UITextField!
    @IBOutlet  var firstAudit: UITextField!
    @IBOutlet  var secondAudit: UITextField!
    @IBOutlet  var correctButton: UIButton!
    @IBOutlet  var incorrectButton: UIButton!
    @IBOutlet  var scroller: UIScrollView!
    
    var auditNumber: Int32! = 0
    var SIMBADataArray = [SIMBAData]()
    
    func configureView()
    {
        // Update the user interface for the detail item.
        if let detail = detailItem
        {
            auditNumber = Int32(detail.description)!
        }
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        print(self.view.frame.width)
        print(self.view.frame.height)
        if UIDevice.current.orientation.isPortrait
        {
            portraitMode()
        }
        else
        {
            landscapeMode()
        }
        
        DefaultAPI.getSIMBAData { (SIMBAData, error) in
            if let SIMBAData = SIMBAData{
                print("\n\n\n")
                print(SIMBAData.first!.encodeToJSON())
                print("\n\n\n")
            }
            
            self.SIMBADataArray = SIMBAData!
            print("Array num = \(self.SIMBADataArray.count)")
            self.getData()
          
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        print(auditNumber!)
        
    }
    func portraitMode()
    {
        if self.view.frame.height < 736
        {
            if self.view.frame.height > 568
            {
                scroller.contentSize = CGSize(width: self.view.frame.width, height: 1000 )
            }
            else
            {
                scroller.contentSize = CGSize(width: self.view.frame.width, height: 1100 )
            }
        }
        else
        {
            scroller.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+300)
        }
    }
    func landscapeMode()
    {
        //568,736,832
        if self.view.frame.width < 736
        {
            if self.view.frame.width > 568
            {
                scroller.contentSize = CGSize(width: 1000, height: self.view.frame.width )
            }
            else
            {
                scroller.contentSize = CGSize(width: 1100, height: self.view.frame.width )
            }
        }
        else
        {
            scroller.contentSize = CGSize(width: self.view.frame.height, height: self.view.frame.width+300)
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isPortrait
        {
            print("scrollportrait")
           portraitMode()
        }
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
        let hashIndex : Int = Int(auditNumber) - 1
        auditNo.text   = "\(String(describing: SIMBADataArray[hashIndex].hashId!))"
        posterID.text  = "\(String(describing: SIMBADataArray[hashIndex].accountId!))"
        IPFS.text      = "\(String(describing: SIMBADataArray[hashIndex].hash))"
        timeStamp.text = "\(String(describing: SIMBADataArray[hashIndex].timestamp!))"
        location.text  = "\(String(describing: SIMBADataArray[hashIndex].location!))"
        name.text      = "\(String(describing: SIMBADataArray[hashIndex].personName!))"
        verStatus.text =  "\(String(describing: SIMBADataArray[hashIndex].verified!))"
        
        if "\(String(describing: SIMBADataArray[hashIndex].verified!))" == "true"
        {
            incorrectButton.isHidden = true
            correctButton.isHidden = true
        }
        else
        {
            incorrectButton.isHidden = false
            correctButton.isHidden = false
        }
        //name.text      = "\(assets["personName"]!))"
    }
}
    

