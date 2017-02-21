//
//  ACRAModel.swift
//  ACRA-iOS
//
//  Created by Team Amazon on 2/20/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation
import Alamofire


let baseURL = "https://3nmf3zcafd.execute-api.us-east-1.amazonaws.com/prod/"

class APIModel: NSObject {
    
    
    static let sharedInstance = APIModel()
    var sessionManager = Alamofire.SessionManager.default
    
    override init() {
        
        super.init()
    }
    
    
    func getData (escape:String, completionHandler: @escaping(Bool) -> () ) {
        
        var urlRequest = URLRequest(url: URL(string: "\(baseURL)product_search?search_string=\(escape)")!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        sessionManager.request(urlRequest).responseJSON { response in
            guard response.result.isSuccess else {
                // we failed for some reason
                print("Error \(response.result.error)")
                completionHandler(false)
                return
            }
            
            if let result = response.result.value {
                if let json = result as? NSDictionary {
                    print(json)
                }
            }
        }
    }
}
