//
//  VerificationAPI.swift
//  HealthSpaceSIMBA_iOS
//
//  Created by Tyler Allen Puckett on 5/7/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Alamofire
import UIKit

open class VerificationAPI: APIBase {
    
    open class func getSIMBAVerifiactionData(completion: @escaping ((_ data: [SIMBAVerificationData]?,_ error: Error?) -> Void)) {
        getSIMBAVerifiactionDataWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }
    
    open class func getSIMBAVerifiactionDataWithRequestBuilder() -> RequestBuilder<[SIMBAVerificationData]> {
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let auditNum = appDelegate!.auditNo
        let path = "/audit/\(auditNum)/verifications"
        print(path)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:Any?] = [:]
        
        let parameters = APIHelper.rejectNil(nillableParameters)
        
        let convertedParameters = APIHelper.convertBoolToString(parameters)
        
        let requestBuilder: RequestBuilder<[SIMBAVerificationData]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
        
        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: true)
    }
}
