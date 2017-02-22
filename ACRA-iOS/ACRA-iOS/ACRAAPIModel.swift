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
    
    
    func getProducts (escape:String, completionHandler: @escaping(Bool) -> () ) {
        
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
            
            Products.sharedProducts.clearProducts()
            
            if let result = response.result.value {
                if let json = result as? NSDictionary {
                    if let hits = json["hits"] as? NSDictionary{
                        if let productList = hits["hit"] as? [NSDictionary]{
                            for fields in productList {
                                
                                if let obj = fields["fields"] as? NSDictionary {
                                let product = Product()
                                    
                                let ratingg = obj["rating"] as! [String]
                                let rating = Double(ratingg[0] as! String)
                                
                                let asinn = obj["asin"] as! [String]
                                let asin = asinn[0]
                                    
                                let image_urll = obj["image"] as! [String]
                                let image_url = image_urll[0]
                                    
                                let price_stringg = obj["formatted_price"] as! [String]
                                let price_string = price_stringg[0]
                                    
                                let price_intt = obj["numeric_price"] as! [String]
                                let price_int = Int(price_intt[0] as! String)
                                    
                                let titlee = obj["title"] as! [String]
                                let title = titlee[0]
                            
                                product.asin = asin
                                product.rating = rating
                                product.image_url=image_url
                                product.price_string=price_string
                                product.price_int=price_int
                                product.title=title
                                    
                                Products.sharedProducts.addProduct(product: product)
                                    
                                }
                            
                            }
                        }
                    }
                }
            completionHandler(true)
            }
        }
    }
}
