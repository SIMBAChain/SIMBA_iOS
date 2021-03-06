//
//  PostViewController.swift
//  SIMBA_iOS
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
    @IBOutlet var postIndicator: UIActivityIndicatorView!
    
    var accountSelected: String! = ""
    var accountName: String! = ""
    let daysInWeek = ["","Sun","Mon","Tues","Wed","Thurs","Fri","Sat"]
    let monthsInYear = ["","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    var timeStamp = "Nan"
    var SIMBACode: Int!
    //MARK: Checking Orientation
    
    override func viewDidAppear(_ animated: Bool) {
        location.text = ""
        name.text = ""
        desc.text = ""
        status.text = ""
        comments.text = ""
        account.text = ""
     
        self.postIndicator.stopAnimating()
        
        super.viewDidAppear(animated)
        
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
           self.postIndicator.startAnimating()
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
      
        //let assets : [String : Any] = SIMBAPostData.asset as Any as! [String : Any]
        //let items  : [String : Any] = SIMBAPostData.items as Any as! [String : Any]
        //date and time
        let dayOfWeek = NSCalendar.current.component(.weekday, from: Date())
        let month = NSCalendar.current.component(.month, from: Date())
        let day = NSCalendar.current.component(.day, from: Date())
        let year = NSCalendar.current.component(.year, from: Date())
        let hour = NSCalendar.current.component(.hour, from: Date())
        let minute = NSCalendar.current.component(.minute, from: Date())
        let second = NSCalendar.current.component(.second, from: Date())
        let time = " " + String(hour) + ":" + String(minute) + ":" + String(second)
        let aDate = " " + String(monthsInYear[month]) + " " + String(day) + " " + String(year)
        let aTimeZone = TimeZone.current.secondsFromGMT()
        var timeZoneStr = "nil"
        if abs(aTimeZone) - aTimeZone == 0
        {
            timeZoneStr = " GMT+0" + String(aTimeZone/36)
        }
        else
        {
            timeZoneStr = " GMT-0" + String(abs(aTimeZone)/36)
        }
        timeStamp = String(daysInWeek[dayOfWeek]) + aDate + time + timeZoneStr
        SIMBAPostData.timestamp = timeStamp
        SIMBAPostData.location = location.text!
        SIMBAPostData.personName = name.text!
   //   SIMBAPostData.asset["attributes"] = SIMBAPostData.attributes
   //   SIMBAPostData.asset["artifacts"] = SIMBAPostData.artifacts
        SIMBAPostData.desc = desc.text!
        SIMBAPostData.status  = status.text!
        SIMBAPostData.comments = comments.text!
    //  SIMBAPostData.items["attributes"] = SIMBAPostData.itemAttributes
        //assets["items"] = items

        SIMBAPostData.accountId = accountSelected!
        //SIMBAPostData.asset = assets
      //  PostTranscationAPI.postSIMBAData(payload: SIMBAPostData, completion: {_ in})
        PostTranscationAPI.postSIMBAData(payload: SIMBAPostData) { (statusCode) in
            print(statusCode as Any)
            if statusCode == 200
            {
                self.postIndicator.stopAnimating()
            let responseAlert = UIAlertController(title: "It has been posted!", message: "", preferredStyle: .alert)
            
            responseAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.viewDidAppear(false)
            }))
            self.present(responseAlert, animated: true)
            }
            else
            {
                self.postIndicator.stopAnimating()
            let responseAlert = UIAlertController(title: "Post Failed", message: "check connection and try again.", preferredStyle: .alert)
            responseAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(responseAlert, animated: true)
        }
        }
        
    }
}
