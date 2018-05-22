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
    @IBOutlet  var scroller: UIScrollView!
    @IBOutlet var account: UITextField!
    
    var accountSelected: String! = ""
    var accountName: String! = ""
    

    
    //MARK: check internet
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
   
    //MARK: Checking Orientation
    
    override func viewDidAppear(_ animated: Bool) {
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
        account.text = accountName
        if UIDevice.current.orientation.isPortrait
        {
            portraitMode()
        }
        else
        {
            landscapeMode()
            
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if UIDevice.current.orientation.isLandscape {
            print("PostLandScape")
            landscapeMode()
            
        } else {
            print("PostPortrait")
            
            portraitMode()
        }
    }
    
    func portraitMode()
    {
         if self.view.frame.width < 736
        {
            if self.view.frame.width > 568
            {
                scroller.contentSize = CGSize(width: 0, height: 0 )
            }
            else
            {
                scroller.contentSize = CGSize(width:0 , height: 0 )
            }
        }
         else
         {
            scroller.contentSize = CGSize(width: 0, height: 0 )
        }
    }
    func landscapeMode()
    {
        //568,736,832
        if self.view.frame.width < 736
        {
            if self.view.frame.width > 568
            {
                scroller.contentSize = CGSize(width: 200, height: 470)
            }
            else
            {
                scroller.contentSize = CGSize(width: 200, height: 520)
            }
        }
        else
        {
            scroller.contentSize = CGSize(width: 200, height: 500)
        }
    }
    
    //MARK: IBActions

    @IBAction func resignFirstResponders()
    {
        location.resignFirstResponder()
        name.resignFirstResponder()
        desc.resignFirstResponder()
        status.resignFirstResponder()
        comments.resignFirstResponder()
    }
    
    //Post
    @IBAction func postPressed()
    {
        let postAlert = UIAlertController(title: "Post", message: "By clicking Post, I hereby declare that the above statement is true to the best of my knowledge and belief.", preferredStyle: .alert)
        
        postAlert.addAction(UIAlertAction(title: "Post", style: .default, handler: { action in
            print("post it")
            self.postData()
        }))
        postAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(postAlert, animated: true)
    }
    
    @IBAction func cancelViewController()
    {
        dismiss(animated: true)
    }
    
    //MARK: Post Data
    
    func postData()
    {
        let SIMBAPostData = SIMBADataPost()
      
        let assets : [String : Any] = SIMBAPostData.asset as Any as! [String : Any]
    //    let items  : [String : Any] = SIMBAPostData.items as Any as! [String : Any]
        
    SIMBAPostData.timestamp = "PlaceHolderTime 5/22/18"
      SIMBAPostData.location = location.text
      SIMBAPostData.personName = name.text
   //   SIMBAPostData.asset["attributes"] = SIMBAPostData.attributes
   //  SIMBAPostData.asset["artifacts"] = SIMBAPostData.artifacts
       SIMBAPostData.desc = String(desc.text)
       SIMBAPostData.status  = status.text
        SIMBAPostData.comments = String(comments.text)
    //    SIMBAPostData.items["attributes"] = SIMBAPostData.itemAttributes
        //assets["items"] = items
        print("start posting")
        
        SIMBAPostData.accountId = accountSelected!
        SIMBAPostData.asset = assets
        print(assets)
        PostTranscationAPI.postSIMBAData(payload: SIMBAPostData, completion: {_ in })
    
    }
}
