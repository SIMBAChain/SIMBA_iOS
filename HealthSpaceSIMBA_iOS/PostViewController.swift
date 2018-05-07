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
   
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if UIDevice.current.orientation.isLandscape {
            print("PostLandScape")
        landscapeMode()
          
        } else {
            print("PostPortrait")
       
            portraitMode()
        }
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
        if UIDevice.current.orientation.isPortrait
        {
            portraitMode()
        }
        else
        {
            landscapeMode()
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
    @IBAction func resignFirstResponders()
    {
        location.resignFirstResponder()
        name.resignFirstResponder()
        desc.resignFirstResponder()
        status.resignFirstResponder()
        comments.resignFirstResponder()
    }
    @IBAction func post()
    {
        let postAlert = UIAlertController(title: "Post", message: "By clicking Post, I hereby declare that the above statement is true to the best of my knowledge and belief.", preferredStyle: .alert)
        
        postAlert.addAction(UIAlertAction(title: "Post", style: .default, handler: { action in
            print("post it")
        }))
        postAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(postAlert, animated: true)
    }
    @IBAction func cancelViewController()
    {
    dismiss(animated: true)
    }
}
