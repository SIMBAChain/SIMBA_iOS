//
//  DefaultAPI.swift
//  HealthSpaceSIMBA_iOS
//
//  Created by Joel Neidig on 4/19/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Alamofire
import UIKit

open class DefaultAPI: APIBase {

    /**
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getSIMBAData(completion: @escaping ((_ data: [SIMBAData]?,_ error: Error?) -> Void)) {
            getSIMBADataWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    open class func getSIMBADataWithRequestBuilder() -> RequestBuilder<[SIMBAData]> {
        let path = "/audit"
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
    open class func postSIMBAData(payload: SIMBAData, completion: @escaping ((_ error: Error?) -> Void)) {
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
    open class func postSIMBADataWithRequestBuilder(payload: SIMBAData) -> RequestBuilder<Void> {
        let path = "/dwarf"//change to audit when ready to test POSTs
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = payload.encodeToJSON() as? [String:AnyObject]
        
        let convertedParameters = APIHelper.convertBoolToString(parameters)
        
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
        
        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }
    
}
