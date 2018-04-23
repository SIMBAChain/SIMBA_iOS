//
//  PostViewController.swift
//  HealthSpaceSIMBA_iOS
//
//  Created by Steven Peregrine on 4/23/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Foundation
import UIKit
class PostViewController: UIViewController
{
    @IBOutlet var location: UITextField!
    @IBOutlet var name: UITextField!
    @IBOutlet var desc: UITextView!
    @IBOutlet var status: UITextField!
    @IBOutlet var comments: UITextView!
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
