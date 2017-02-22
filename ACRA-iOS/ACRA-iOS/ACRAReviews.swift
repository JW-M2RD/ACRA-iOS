//
//  ACRAReviews.swift
//  ACRA-iOS
//
//  Created by Team Amazon on 2/20/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation

class Reviews: NSObject {
    
    var reviews: [Review] = []
    var numReviews: Int! = nil 
    
    static let sharedReviews = Reviews()
    
    
    override init () {
        super.init()
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
