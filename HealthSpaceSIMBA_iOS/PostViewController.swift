//
//  PostViewController.swift
//  HealthSpaceSIMBA_iOS
//
//  Created by Steven Peregrine on 4/23/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class PostViewController: UIViewController
{
    @IBOutlet var location: UITextField!
    @IBOutlet var name: UITextField!
    @IBOutlet var desc: UITextView!
    @IBOutlet var status: UITextField!
    @IBOutlet var comments: UITextView!
    
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
        super.viewDidAppear(animated)
        checkInternetConnection()
        if !isConnectedToInternet()
        {print("not connected to internet")
            return}
    }
    @IBAction func resignFirstResponders()
    {
        location.resignFirstResponder()
        name.resignFirstResponder()
        desc.resignFirstResponder()
        status.resignFirstResponder()
        comments.resignFirstResponder()
    }
    @IBAction func cancelViewController()
    {
    dismiss(animated: true)
    }
}
