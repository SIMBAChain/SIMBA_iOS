//
//  ViewController.swift
//  HealthSpaceSIMBA_iOS
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
    var accountPickerData = ["","Account1","Account2","Account3","Account4","Account5","Account6","Account7","Account8","Account9","Account10"]
    
    /*var SIMBADataArray = [SIMBAData]()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //DefaultAPI.getDwarves calls the DefaultAPI.swift and runs the getDwarves function which executes the getDwarvesWithRequestBuilder function which accesses the basePath for the GET command.
        DefaultAPI.getSIMBAData { (SIMBAData, error) in
            if let SIMBAData = SIMBAData{
                print("\n\n\n")
                print(SIMBAData.last!.encodeToJSON())
                print("\n\n\n")
            }
            self.SIMBADataArray = SIMBAData!
        }
    }*/
    //check internet
     override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        checkInternetConnection()
    }
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

//picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return accountPickerData.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return accountPickerData[row]
    }
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        accountTextField.text = accountPickerData[row]
    }
    @IBAction func selectaccount() {
        checkInternetConnection()
        if !isConnectedToInternet()
        {print("not connected to internet")
            return}
      hideAccountPicker()
    }
    @IBAction func showAccountPicker(){
        checkInternetConnection()
        if !isConnectedToInternet()
        {print("not connected to internet")
            return}
     accountPicker.isHidden = false
     selectButton.isHidden = false
    }
    @IBAction func hideAccountPicker(){
        accountPicker.isHidden = true
        selectButton.isHidden = true
    }
    //resign responders
    @IBAction func resignResponders()
    {
        accountTextField.resignFirstResponder()
        
        }
}

