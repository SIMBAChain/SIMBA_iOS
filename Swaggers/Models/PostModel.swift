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
    var timestamp : String!
    var location : String!
    var personName : String!
    var itemsArray : Array<Any>!
    var items = [[String : Any?]] ()
    var desc : String!
    var status : String!
    var comments : String!
    var attributes = ["light","blue"]
    var artifacts = ["photo/ref/57","photo/ref/77"]
    var itemAttributes = ["annual"]
    var asset : [String : Any?] = ["timestamp" :"", "location" :"", "personName" :""]
    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> Any {            
        asset["timestamp"] = self.timestamp
        asset["location"] = self.location
        asset["personName"] = self.personName
        items.append(["description" :desc!, "status" :status, "comments" :comments])
        asset["items"] = items
     
        var nillableDictionary = [String : Any?] ()
        nillableDictionary["accountId"] = self.accountId
        nillableDictionary["asset"] = self.asset
        
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
