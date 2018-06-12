//
//  DefaultAPI.swift
//  SIMBA_iOS
//
//  Created by Joel Neidig on 4/19/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Alamofire
import UIKit

open class DefaultAPI: APIBase {

    /*
     - parameter completion: completion handler to receive the data and the error objects
     */
    //get data
    open class func getSIMBAData(completion: @escaping ((_ data: [SIMBAData]?,_ statusCode: Int?) -> Void)) {
            getSIMBADataWithRequestBuilder().execute { (response, error) -> Void in
           // completion(response?.body, error);
                completion(response?.body, response?.statusCode)
             //  let statusCodeSTR = String(response!.statusCode)
               // print("GET DATA API CODE: " + statusCodeSTR)
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
    
//post data
    open class func postSIMBAData(payload: SIMBAData, completion: @escaping ((_ error: Error?) -> Void)) {
        postSIMBADataWithRequestBuilder(payload: payload).execute { (response, error) -> Void in
            completion(error);
        }
    }
    
  
    open class func postSIMBADataWithRequestBuilder(payload: SIMBAData) -> RequestBuilder<Void> {
        let path = "/audit"//change to audit when ready to test POSTs
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = payload.encodeToJSON() as? [String:AnyObject]
        
        let convertedParameters = APIHelper.convertBoolToString(parameters)
        
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
        
        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }
    
}
