//
//  ACRADatabase.swift
//  ACRA-iOS
//
//  Created by Mr.RD on 3/1/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation

class Database: NSObject {
    
    var products: [Product] = []
    var reviews: [Review] = []
    
    static let sharedProducts = Products()
    static let sharedReviews = Reviews()
    
    override init () {
        super.init()
    }
    
    func addProduct(product: Product) {
        if !products.contains(product) {
            products.append(product)
        }
    }
    
    func clearProducts() {
        products.removeAll()
    }
    
    func addReview(review: Review) {
        if !reviews.contains(review) {
            reviews.append(review)
        }
    }
    
    func clearReviews() {
        reviews.removeAll()
    }
}
