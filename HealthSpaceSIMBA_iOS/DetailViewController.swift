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
    //Outlets
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
    @IBOutlet  var accountField : UITextField!
    @IBOutlet  var magTextField: UITextField!
    
    //variables
    var accountSelected : String!
    var accountName : String!
    var posterIDStr : String!
    var auditor1    : String!
    var verButtonStatus : Bool!
    var auditNumber: Int32! = 0
    let mainVC = ViewController()
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
    
            
        self.correctButton.isEnabled = true
        self.incorrectButton.isEnabled = true
        accountField.text = accountName
        print("========Account Selected|" + accountSelected + "|========")
       // print(self.view.frame.width)
        //print(self.view.frame.height)
        if UIDevice.current.orientation.isPortrait
        {
            portraitMode()
        }
        else
        {
            landscapeMode()
        }
        
        /*DefaultAPI.getSIMBAData { (SIMBAData, error) in
            if let SIMBAData = SIMBAData{
                print("\n\n\n")
                print(SIMBAData.first!.encodeToJSON())
                print("\n\n\n")
            }
            
            self.SIMBADataArray = SIMBAData!
 */
        PostTranscationAPI.getSIMBAData { (SIMBAData, error) in
            if let SIMBAData = SIMBAData{
                print("\n\n\n SIMBA DATA !!!!!!!!")
                print(SIMBAData.first!.encodeToJSON())
                print("\n\n\n")
            }
            else{
                self.dismiss(animated: true)
                return
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
        correctButton.setTitleColor(UIColor.gray, for: .disabled)
        incorrectButton.setTitleColor(UIColor.gray, for: .disabled)
    }
    
    //MARK: Check Orientation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if UIDevice.current.orientation.isLandscape {
            print("DetailLandscape")
            landscapeMode()
            
        } else {
            print("DetailPortrait")
            
            portraitMode()
        }
    }
    func portraitMode()
    {
        scroller.contentSize = CGSize(width: 0, height: 0 )
    }
    func landscapeMode()
    {
        //568,736,832
        if self.view.frame.width < 736
        {
            if self.view.frame.width > 568
            {
                scroller.contentSize = CGSize(width: 200, height: 1050)
            }
            else
            {
                scroller.contentSize = CGSize(width: 200, height: 1100)
            }
        }
        else
        {
            scroller.contentSize = CGSize(width: 200, height: 1010)
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
        
        posterIDStr = "\(String(describing: SIMBADataArray[hashIndex].accountId!))"

                
        if firstAudit.text == "" || secondAudit.text == ""
        {
            incorrectButton.isHidden = false
            correctButton.isHidden = false
           
        }
        else
        {
            incorrectButton.isHidden = true
            correctButton.isHidden = true
            
        }
    }
    @IBAction func magnify(_ sender: UITextField)
    {
        print("ENHANCE!!!")
        magTextField.text = sender.text
        sender.resignFirstResponder()
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
            auditor1 = SIMBAVerificationDataArray[0].auditor
            print("HERE!!!! \(auditor1!)")
            
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
    
    //Check to see if user is allowed to audit
 
    
    //MARK: Buttons
    @IBAction func btnPressed(_ sender: UIButton)
    {
        print("account selected: " + accountSelected + "\n posterid:        " + posterIDStr )
        print("pressed: \(sender.currentTitle!)\n\n")
        if accountSelected == posterIDStr
        {
            print("Same Poster & auditor")
            sameAccountAlert(str: "poster")
        }
        if SIMBAVerificationDataArray.count == 1
        {
            if auditor1 == accountSelected
            {
                print("Same auditor as first auditor")
                sameAccountAlert(str: "auditor1")
            }
            else
            {
                print("Different")
                postVerification(btnSelected: sender.currentTitle!)
            }
        }
    }
    
    func postVerification(btnSelected: String)
    {
        print("\n\(btnSelected)")
        if btnSelected == "Correct"
        {
            postVerify(verifyBtn: "true", accountId: accountSelected!)
        }
        if btnSelected == "Incorrect"
        {
            postVerify(verifyBtn: "false", accountId: accountSelected!)
        }
    }
    
    func sameAccountAlert(str: String)
    {
        if str == "poster"
        {
            //Add alert here for same Poster & auditor
            let accountAlert = UIAlertController(title: "Cannot verify ones own post", message: "Select a different account to continue.", preferredStyle: .alert)
            
            accountAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.correctButton.isEnabled = false
                self.incorrectButton.isEnabled = false
            }))
            
            self.present(accountAlert, animated: true)
        }
        if str == "auditor1"
        {
            //Add alert here for same auditor as first auditor
            let accountAlert = UIAlertController(title: "Cannot verify a post twice", message: "Select a different account to continue.", preferredStyle: .alert)
            
            accountAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.correctButton.isEnabled = false
                self.incorrectButton.isEnabled = false
            }))
            
            self.present(accountAlert, animated: true)
        }
    }
}
    

