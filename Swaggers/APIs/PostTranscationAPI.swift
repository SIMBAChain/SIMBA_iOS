//
//  PostTranscation.swift
//  HealthSpaceSIMBA_iOS
//
//  Created by Tyler Allen Puckett on 5/11/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Alamofire
import UIKit

open class PostTranscationAPI: APIBase {

    /*
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getSIMBAData(completion: @escaping ((_ data: [SIMBAData]?,_ error: Error?) -> Void)) {
        getSIMBADataWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }
    
    open class func getSIMBADataWithRequestBuilder() -> RequestBuilder<[SIMBAData]> {
         let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let auditID = appDelegate?.auditNo
        let path = "/audit/{\(String(describing: auditID))}"
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:Any?] = [:]
        
        let parameters = APIHelper.rejectNil(nillableParameters)
        
        let convertedParameters = APIHelper.convertBoolToString(parameters)
        
        let requestBuilder: RequestBuilder<[SIMBAData]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
        
        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: true)
    }
    
    /**
     Post a transaction
     
     - parameter payload: (body) A single JSON object containing the dwarf definition
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func postSIMBAData(payload: SIMBADataPost, completion: @escaping ((_ error: Error?) -> Void)) {
        postSIMBADataWithRequestBuilder(payload: payload).execute { (response, error) -> Void in
            completion(error);
        }
    }
    
    /**
     Post a new Dwarf
     - POST /dwarf
     - endpoint for posting a newly created dwarf to the server
     
     - parameter payload: (body) A single JSON object containing the dwarf definition
     
     - returns: RequestBuilder<Void>
     */
    open class func postSIMBADataWithRequestBuilder(payload: SIMBADataPost) -> RequestBuilder<Void> {
        let path = "/audit" //change to audit when ready to test POSTs
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = payload.encodeToJSON() as? [String:AnyObject]
        
        let convertedParameters = APIHelper.convertBoolToString(parameters)
        
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
        
        print("post API")
        print(parameters as Any)
        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }
    
}
