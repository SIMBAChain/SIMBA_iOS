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
    var SIMBAVerificationDataArray = [SIMBAVerificationData]()

    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate

    func configureView()
    {
        
        // Update the user interface for the detail item.
        if let detail = detailItem
        {
            auditNumber = Int32(detail.description)!
            appDelegate?.saveAuditNumber(auditNum: auditNumber)
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
            //print("Array num = \(self.SIMBADataArray.count)")
            self.getData()
            
        }
        VerificationAPI.getSIMBAVerifiactionData { (SIMBAVerificationData, error) in
            if let SIMBAVerificationData = SIMBAVerificationData{
                if SIMBAVerificationData.isEmpty{
                    print("nil")
                }
                else{
                    print("\n\n\n")
                    print(SIMBAVerificationData.first!.encodeToJSON())
                    print("\n\n\n")
                }
            }
            
            self.SIMBAVerificationDataArray = SIMBAVerificationData!
            //print("Array num = \(self.SIMBADataArray.count)")
            self.getVerificationData()
            
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        print(auditNumber!)
        
    }
    
    //MARK: Check Orientation
    func portraitMode()
    {
        print("auditportrait")
        if self.view.frame.height < 736
        {
            if self.view.frame.height > 568
            {
                print("7 format")
                scroller.contentSize = CGSize(width: self.view.frame.width, height: 1100 )
            }
            else
            {
                print("5s format")
                scroller.contentSize = CGSize(width: self.view.frame.width, height: 1100 )
            }
        }
        else
        {
            print("8+ and X")
            scroller.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+300)
        }
    }
    func landscapeMode()
    {
        print("auditlandscape")
        //568,736,832
        if self.view.frame.width < 736
        {
            if self.view.frame.width > 568
            {
                 print("7 format")
                scroller.contentSize = CGSize(width: self.view.frame.height, height: 1100 )
            }
            else
            {
                 print("5s format")
                scroller.contentSize = CGSize(width: self.view.frame.height, height: 1100 )
            }
        }
        else
        {
            print("8+ and X")
            scroller.contentSize = CGSize(width: self.view.frame.height, height: self.view.frame.width+300)
        }
    }
 
    var detailItem: Int32?
    {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    //MARK: Grab & Display Data
    func getData()
    {
        let hashIndex : Int = Int(auditNumber) - 1
        var assets : [String : Any] = SIMBADataArray[hashIndex].assets!
        let items = assets["items"] as? [[String:Any]]
        
        //print(SIMBADataArray[hashIndex].verifications!)
        
        auditNo.text    = "\(String(describing: SIMBADataArray[hashIndex].hashId!))"
        posterID.text   = "\(String(describing: SIMBADataArray[hashIndex].accountId!))"
        IPFS.text       = "\(String(describing: SIMBADataArray[hashIndex].hash!))"
        timeStamp.text  = "\(String(describing: SIMBADataArray[hashIndex].timestamp!))"
        location.text   = "\(String(describing: SIMBADataArray[hashIndex].location!))"
        name.text       = "\(String(describing: SIMBADataArray[hashIndex].personName!))"
        desc.text       = "\(String(describing: items![0]["description"]!))"
        status.text     = "\(String(describing: items![0]["status"]!))"
        comments.text   = "\(String(describing: items![0]["comments"]!))"
        verStatus.text  = "\(String(describing: SIMBADataArray[hashIndex].verified!))"
        
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
    }
    
    func getVerificationData()
    {
        if SIMBAVerificationDataArray.count == 2
        {
            if (SIMBAVerificationDataArray[0].verification == 0)
            {
                firstAudit.text = "false"
            }
            else
            {
                firstAudit.text = "true"
                
            }
            if (SIMBAVerificationDataArray[1].verification == 0)
            {
                secondAudit.text = "false"
            }
            else
            {
                secondAudit.text = "true"
                
            }
        }
        else if SIMBAVerificationDataArray.count == 1
        {
            if (SIMBAVerificationDataArray[0].verification == 0)
            {
                firstAudit.text = "false"
            }
            else
            {
                firstAudit.text = "true"
                
            }
        }
        else
        {
            
        }
    }
    
    //MARK: POST Verification
    
    func postVerify(verifyBtn : String, accountId : String)
    {
        print("PostVerify: \(verifyBtn) \(accountId)")
        let verify = Verify()
        verify.accountId = accountId
        verify.verification = verifyBtn
        
        VerificationAPI.postVerificationSIMBAData(payload: verify, completion: {_ in })
    }
    
    //MARK: Buttons
    @IBAction func btnPressed(_ sender: UIButton)
    {
        print("pressed: \(sender.currentTitle!)")
        if sender.currentTitle! == "Correct"
        {
            postVerify(verifyBtn: "true", accountId: "0xb1db8a003114ee270207e8812a009f108b41f625")
        }
        if sender.currentTitle! == "Incorrect"
        {
            postVerify(verifyBtn: "false", accountId: "0xb1db8a003114ee270207e8812a009f108b41f625")
        }
    }
}
    

