//
//  ViewController.swift
//  HealthSpaceSIMBA_iOS
//
//  Created by Joel Neidig on 4/9/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var SIMBADataArray = [SIMBAData]()
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
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

