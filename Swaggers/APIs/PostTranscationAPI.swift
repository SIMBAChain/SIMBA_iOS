//
//  PostTranscation.swift
//  SIMBA_iOS
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
    
    //get data
    open class func getSIMBAData(completion: @escaping ((_ data: [SIMBADataPost]?,_ error: Error?) -> Void)) {
        getSIMBADataWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }
    
    open class func getSIMBADataWithRequestBuilder() -> RequestBuilder<[SIMBADataPost]> {
         let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let auditID = appDelegate?.auditNo
        let path = "/audit/\(String(describing: auditID!))"
        let URLString = SwaggerClientAPI.basePath + path
        print(URLString)
        print("got it!")
        let nillableParameters: [String:Any?] = [:]
        
        let parameters = APIHelper.rejectNil(nillableParameters)
        
        let convertedParameters = APIHelper.convertBoolToString(parameters)
        
        let requestBuilder: RequestBuilder<[SIMBADataPost]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
        
        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: true)
    }
    
   //post data
    open class func postSIMBAData(payload: SIMBADataPost, completion: @escaping ((_ statusCode: Int?) -> Void)) -> Int {
        var code : Int! = 404
        postSIMBADataWithRequestBuilder(payload: payload).execute { (response, error) -> Void in
            //completion(error)
            completion(response?.statusCode)
             code = response?.statusCode
        }
            return code
    }
    
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
