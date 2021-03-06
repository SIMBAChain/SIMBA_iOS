//
//  VerificationAPI.swift
//  SIMBA_iOS
//
//  Created by Tyler Allen Puckett on 5/7/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Alamofire
import UIKit

open class VerificationAPI: APIBase {
    //get data
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
    
   //post data
    open class func postVerificationSIMBAData(payload: Verify, completion: @escaping ((_ error: Error?) -> Void)) {
        postSIMBAVerificationDataWithRequestBuilder(payload: payload).execute { (response, error) -> Void in
            completion(error);
        }
    }
    
 
    open class func postSIMBAVerificationDataWithRequestBuilder(payload: Verify) -> RequestBuilder<Void> {
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let auditNum = appDelegate!.auditNo
        let path = "/audit/\(auditNum)/verify"
        print(path)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = payload.encodeToJSON() as? [String:AnyObject]
        
        let convertedParameters = APIHelper.convertBoolToString(parameters)
        print(convertedParameters!)
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
        print(requestBuilder)
        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }
}
