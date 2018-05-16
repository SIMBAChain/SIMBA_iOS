//
//  PostModel.swift
//  HealthSpaceSIMBA_iOS
//
//  Created by Tyler Allen Puckett on 5/11/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Foundation

open class SIMBAPostData: JSONEncodable {
    
    var accountId : String?
    var assets  = [String : Any?] ()
    var timestamp : String?
    var location : String?
    var personName : String?
    var items = [String : Any?] ()
    var desc : String?
    var status : String?
    var comments : String?
    

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        
        items[""] = self.desc
        items[""] = self.status
        items[""] = self.comments
            
        assets[""] = self.timestamp
        assets[""] = self.location
        assets[""] = self.personName
        assets[""] = self.items
 
        var nillableDictionary = [String : Any?] ()
        nillableDictionary[""] = self.accountId
        nillableDictionary[""] = self.assets
        
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
