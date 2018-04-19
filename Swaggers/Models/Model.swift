//
//  Model.swift
//  HealthSpaceSIMBA_iOS
//
//  Created by Joel Neidig on 4/19/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Foundation


/** a short sturdy creature fond of drink and industry! */
/*open class Dwarf: JSONEncodable {
 public var name: String?
 public var age: String?
 public var id: String?
 
 public init() {}
 
 // MARK: JSONEncodable
 func encodeToJSON() -> Any {
 var nillableDictionary = [String:Any?]()
 nillableDictionary["name"] = self.name
 nillableDictionary["age"] = self.age
 nillableDictionary["id"] = self.id
 let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
 return dictionary
 }
 }*/

open class SIMBAData: JSONEncodable {
    public var hashId : Int32?
    public var accountId: String?
    public var assets : [String : Any]?
    public var timestamp: String?
    /* public var location: String?
     public var personName: String?
     public var attributesAssets: [String] = [] // array of strings
     public var artifacts: [String] = [] //array of strings
     public var description: String?
     public var status: String?
     public var comments: String?
     public var attributesItems: [String] = [] //array of strings*/
    
    
    public init() {}
    
    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String : Any?] ()
        nillableDictionary["hashId"] = self.hashId
        nillableDictionary["accountId"] = self.accountId
        nillableDictionary["asset"] = self.assets
        nillableDictionary["timestamp"] = self.timestamp
        
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
