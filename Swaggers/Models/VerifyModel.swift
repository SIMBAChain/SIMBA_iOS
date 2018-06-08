//
//  VerifyModel.swift
//  SIMBA_iOS
//
//  Created by Tyler Allen Puckett on 5/8/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Foundation

open class Verify: JSONEncodable {
    
    public var accountId : String?
    public var verification : String?

    public init() {}
    
    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String: Any?] ()
        nillableDictionary["accountId"] = self.accountId
        nillableDictionary["verification"] = self.verification
        
        let dictionary: [String: Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
