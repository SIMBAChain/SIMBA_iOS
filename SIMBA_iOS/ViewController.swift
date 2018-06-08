//
//  ViewController.swift
//  SIMBA_iOS
//
//  Created by Joel Neidig on 4/9/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet var accountPicker: UIPickerView!
    @IBOutlet var selectButton: UIButton!
    @IBOutlet var postButton: UIButton!
    @IBOutlet var auditButton: UIButton!
    
   //input data into arrays for picking accounts
    var accountPickerData = ["Account1: ******f625","Account2: ******1457","Account3: ******2370","Account4: ******4205","Account5: ******6e37","Account6: ******7180","Account7: ******c453","Account8: ******dd25","Account9: ******08bc","Account10: ******5b05"]
    var accountID = ["0xb1db8a003114ee270207e8812a009f108b41f625","0x9ccd1bb0d58a9ce5db012ff74967edb371a91457","0x0a69fcf74245459a1883485a4e4f23bb3b552370","0x442fd3df4845b53afa13eae0051429b912bb4205","0x818ce4fb076ef541457f22b955af6bfa046c6e37","0x2ba1d9aba1f0b1b12ad1b48a9c7cf327f1d17180","0xad267928e21fe2bdd09417b20b6b8b0fa767c453","0x4324ca587090d5d77942531cc18adde45836dd25","0x647102ec4e63f571971e75ba4c5493a636af08bc","0xd8e00bdfc99738a223db7821281d52de59c25b05"]
    var activeID: String!

    //adapt gui for landscape and portrait
    
    


  
     override func viewDidAppear(_ animated: Bool)
    {
        checkInternetConnection()
    }
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
                self.checkInternetConnection()
            }))
            
            self.present(alert, animated: true)
            print("not connected to internet")
        }
    }
    func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.accountPicker.dataSource = self
        self.accountPicker.delegate = self
        hideAccountPicker()
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
//picker----------------------------
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return accountPickerData.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        activeID = accountID[row]
        print(accountPickerData[row] + ":" + activeID)
        return accountPickerData[row]
        
    }
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        accountTextField.text = accountPickerData[row]
    }
    
    //triggered when select account button is pressed
    @IBAction func selectaccount() {
        checkInternetConnection()
        if !isConnectedToInternet()
        {print("not connected to internet")
            return}
        if accountTextField.text == ""
        {
            accountTextField.text = accountPickerData[0]
            activeID = accountID[0]
        }
       //alerts user to their new user id
        let accountAlert = UIAlertController(title: "Your current Ethereum testing ID:", message: activeID, preferredStyle: .alert)
        
        accountAlert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        self.present(accountAlert, animated: true)
      hideAccountPicker()
    }
 
    @IBAction func showAccountPicker(){
        checkInternetConnection()
        if !isConnectedToInternet()
        {
            print("not connected to internet")
            return
        }
     accountPicker.isHidden = false
     selectButton.isHidden = false
        postButton.isEnabled = false
        auditButton.isEnabled = false
    }
    @IBAction func hideAccountPicker(){
        accountPicker.isHidden = true
        selectButton.isHidden = true
        postButton.isEnabled = true
        auditButton.isEnabled = true
    }
    //pass account info to the post view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is PostViewController
        {
            let vc = segue.destination as? PostViewController
            vc?.accountSelected = activeID
            vc?.accountName = accountTextField.text
        }
        if segue.destination is UINavigationController
        {
            print("goto audit")
            let navVC = segue.destination as? UINavigationController
            let tableVC = navVC?.viewControllers.first as! AuditTableViewController
            tableVC.accountSelected = activeID
            tableVC.accountName = accountTextField.text
        }
        
    }
    //resign responders
    @IBAction func resignResponders()
    {
        accountTextField.resignFirstResponder()
    }
}

