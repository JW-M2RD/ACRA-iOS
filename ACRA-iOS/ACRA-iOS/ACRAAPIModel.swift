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
    
    
    func getReviews (escape:String, completionHandler: @escaping(Bool) -> () ) {
        
        var urlRequest = URLRequest(url: URL(string: "\(baseURL)asin_search?asin=\(escape)")!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
    
        
        
        sessionManager.request(urlRequest).responseJSON { response in
            guard response.result.isSuccess else {
                // we failed for some reason
                print("Error \(response.result.error)")
                completionHandler(false)
                return
            }
            
            //clear review obj
            
            if let result = response.result.value {
                if let json = result as? NSDictionary {
                    
                    Reviews.sharedReviews.clearReviews()
                    
                    //Get num Reivews 
                    let numReviews = json["Count"] as! Int
                    Reviews.sharedReviews.numReviews = numReviews
                    
                    
                    if let reviews = json["Items"] as? [NSDictionary] {
                        for review in reviews{
                            let uid = review["uid"] as! String
                            let asin = review["asin"] as! String
                            let relevant = review["relevant"] as! Bool
                            let reviewerName = review["reviewerName"] as! String
                            let reviewerTime = review["reviewerTime"] as! String
                            let reviewText = review["reviewText"] as! String
                            let reviewerID = review["reviewerID"] as! String
                            let overall = review["overall"] as! Int
                            let unixReviewTime = review["unixReviewTime"] as! Int
                            let summary = review["summary"] as! String
                            
                            let newReview = Review()
                            newReview.asin = asin
                            newReview.uid = uid
                            newReview.relevant = relevant
                            newReview.reviewerName = reviewerName
                            newReview.reviewerTime = reviewerTime
                            newReview.reviewText = reviewText
                            newReview.reviewerID = reviewerID
                            newReview.overall = overall
                            newReview.unixReviewTime = unixReviewTime
                            newReview.summary = summary
                            
                            Reviews.sharedReviews.addReview(review: newReview)
                            
                        
                        }
                        
                    }
                    else {
                        completionHandler(false)
                    }
                    
                    
                    
//                    print(json)
                }
                completionHandler(true)
            }
        }
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
            
            //Old Products
            Products.sharedProducts.clearProducts()
            
//            Database.sharedProducts.clearProducts()
            
            if let result = response.result.value {
                if let json = result as? NSDictionary {
                    if let hits = json["hits"] as? NSDictionary{
                        if let productList = hits["hit"] as? [NSDictionary]{
                            for fields in productList {
                                
                                if let obj = fields["fields"] as? NSDictionary {
                                let product = Product()
                                    
                                let ratingg = obj["rating"] as! [String]
                                let rating = Double(ratingg[0] )
                                
                                let asinn = obj["asin"] as! [String]
                                let asin = asinn[0]
                                    
                                let image_urll = obj["image"] as! [String]
                                let image_url = image_urll[0]
                                    
                                let price_stringg = obj["formatted_price"] as! [String]
                                let price_string = price_stringg[0]
                                    
                                let price_intt = obj["numeric_price"] as! [String]
                                let price_int = Int(price_intt[0] )
                                    
                                let titlee = obj["title"] as! [String]
                                let title = titlee[0]
                            
                                product.asin = asin
                                product.rating = rating
                                product.image_url=image_url
                                product.price_string=price_string
                                product.price_int=price_int
                                product.title=title
                                    
                                Products.sharedProducts.addProduct(product: product)
                                
                                //Can reuse products method
//                                Database.sharedProducts.addProduct(product: product)
                                    
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
