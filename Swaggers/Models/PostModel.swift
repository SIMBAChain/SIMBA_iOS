//
//  PostModel.swift
//  HealthSpaceSIMBA_iOS
//
//  Created by Tyler Allen Puckett on 5/11/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Foundation

open class SIMBADataPost: JSONEncodable {
    
    var accountId : String!
    var asset  = [String : Any?] ()
    var timestamp : String!
    var location : String!
    var personName : String!
    var items = [String : Any?] ()
    var desc : String!
    var status : String!
    var comments : String!
    var attributes = ["light","blue"]
    var artifacts = ["photo/ref/57","photo/ref/77"]
    var itemAttributes = ["annual"]
    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
         print(items["timestamp"] as Any)
    
            
        asset["timestamp"] = self.timestamp
        asset["location"] = self.location
        asset["personName"] = self.personName
        asset["attributes"] = self.attributes
        asset["artifacts"] = self.artifacts
        //    items["description"] = self.desc
        //    items["status"] = self.status
         //   items["comments"] = self.comments
        //    items["attributes"] = self.itemAttributes
        asset["items"] = ["description" : self.desc, "status" : self.status, "comments" : self.comments, "attributes" : self.itemAttributes]
        //hard coded post
       /* asset = ["timestamp" : "2018-03-09T04:22:11.725Z",
                 "location" : "314 Kepler Drive, Strickland, TX",
                 "personName" : "Miles Oscar",
                 "attributes" : [ "light",
                                  "blue"],
                 "artifacts": [
                    "photo/ref/57",
                    "photo/ref/77"
                                ],
                 "items" : [
                    "description": "Safety inspection",
                    "status": "Passed",
                    "comments": "Railings were checked.",
                    "attributes": [
                        "annual"
                    ]
                  ]
                ] */
        //end post
     
        
        print(items["timestamp"] as Any)
 print("post model")
        var nillableDictionary = [String : Any?] ()
        print(self.accountId as Any)
        print(self.asset)
        nillableDictionary["accountId"] = self.accountId
        nillableDictionary["asset"] = self.asset
        
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
