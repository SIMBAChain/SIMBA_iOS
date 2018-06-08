//
//  VerificationModel.swift
//  SIMBA_iOS
//
//  Created by Tyler Allen Puckett on 5/7/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Foundation

open class SIMBAVerificationData: JSONEncodable {
    
    public var id : Int32?
    public var txnId : String?
    public var auditId : Int32?
    public var auditor : String?
    public var verification : Int?
    public var createdAt : String?
    public var updatedAt : String?
    
    public init() {}
    
    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String: Any?] ()
        nillableDictionary["id"] = self.id
        nillableDictionary["txnId"] = self.txnId
        nillableDictionary["auditId"] = self.auditId
        nillableDictionary["auditor"] = self.auditor
        nillableDictionary["verification"] = self.verification
        nillableDictionary["createdAt"] = self.createdAt
        nillableDictionary["updatedAt"] = self.updatedAt
        
        let dictionary: [String: Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
