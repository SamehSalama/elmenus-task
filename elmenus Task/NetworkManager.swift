//
//  NetworkManager.swift
//  elmenus Task
//
//  Created by Sameh Salama on 10/5/17.
//  Copyright © 2017 Sameh Salama. All rights reserved.
//

import Foundation
import Alamofire

/// NetworkManager is a class responsible for all server communications
class NetworkManager {

    private let baseUrl                                     :String = "http://elmenus.getsandbox.com"

    private var afManager                                   :SessionManager!

    //MARK: - List of APIs
    private let menuAPI                                    :String = "/menu"


    //MARK: - Network Handler
    var requestCompletionHandler: (Any?) -> (Void)
    var errorHandler:(_ value: Any?, _ statusCode: Int) -> Void
    
    
    init() {
        self.afManager = Alamofire.SessionManager()
        
        requestCompletionHandler = ({(nil) -> Void in
            //print("Default CompletionHandler.")
        })
        
        errorHandler = ({(nil)-> Void in
            //print("Default ErrorHandler.")
        })
    }
    

    //MARK: - Request Function
    func jsonRequest(_ request: DataRequest) -> Void {
        
        request.responseJSON { response in
            
            print("\n*****\nrequest url: \(String(describing: response.request?.url))\n*****")
            print("\n*****request JSON response: \n\(String(describing: response.result.value))\n*****")
            if response.result.isFailure {
                self.errorHandler(["error" : "Connection to server failed."], 500)
                return
            }
            
            let statusCode = response.response?.statusCode
            let value = response.result.value 

            switch(statusCode!) {
            case 200:
                self.requestCompletionHandler(value)
                break
            default:
                self.errorHandler(value, statusCode!)
                break
            }
        }
    }
    
    // MARK: - Network API Functions
    func getMenu() {
        let request = afManager.request(baseUrl + menuAPI, headers:["Content-Type":"application/json"])
            .validate(statusCode: 200..<501)
        jsonRequest(request)
    }



}
