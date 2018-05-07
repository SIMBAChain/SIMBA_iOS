//
//  Model.swift
//  HealthSpaceSIMBA_iOS
//
//  Created by Joel Neidig on 4/19/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Foundation

open class SIMBAData: JSONEncodable {
    public var hashId : Int32?
    public var accountId: String?
    public var hash: String?
    public var assets : [String : AnyObject]?
    public var items : [String : AnyObject]?
    public var timestamp: String?
    public var location: String?
    public var personName: String?
    public var attributesAssets: [String] = [] // array of strings
    public var artifacts: [String] = [] //array of strings
    public var description: String?
    public var status: String?
    public var comments: String?
    public var verified: String?

    //public var attributesItems: [String] = [] //array of strings
    
    
    public init() {}
    
    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String : Any?] ()
        nillableDictionary["hashId"] = self.hashId
        nillableDictionary["accountId"] = self.accountId
        nillableDictionary["hash"] = self.hash
        nillableDictionary["asset"] = self.assets
        nillableDictionary["items"] = self.items
        nillableDictionary["timestamp"] = self.timestamp
        nillableDictionary["location"] = self.location
        nillableDictionary["personName"] = self.personName
        nillableDictionary["description"] = self.description
        nillableDictionary["status"] = self.status
        nillableDictionary["comments"] = self.comments
        nillableDictionary["verified"] = self.verified
        
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
