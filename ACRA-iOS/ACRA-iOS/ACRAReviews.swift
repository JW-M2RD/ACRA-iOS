//
//  ACRAReviews.swift
//  ACRA-iOS
//
//  Created by Team Amazon on 2/20/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation

class Reviews: NSObject {
    
    //Product quality reviews
//    var reReviews: [Review] = []
    var rePosReviews: [Review] = []
    var reNegReviews: [Review] = []
    
    //Irrelvant reviews
    var irNegReviews: [Review] = []
    var irPosReviews: [Review] = []
    var numReviews: Int! = nil
    
    static let sharedReviews = Reviews()
    
    
    override init () {
        super.init()
    }
    
    
    
    func addReview(review: Review) {
        
        // add to different list based on related or not
        if review.relevant! {

            if review.overall >= 3 {
                if !rePosReviews.contains(review) {
                    rePosReviews.append(review)
                }
            }
            if review.overall <= 2 {
                if !reNegReviews.contains(review) {
                    reNegReviews.append(review)
                }
            }
        }
        else {
            
            if review.overall >= 3 {
                if !irPosReviews.contains(review) {
                    irPosReviews.append(review)
                }
            }
            if review.overall <= 2 {
                if !irNegReviews.contains(review) {
                    irNegReviews.append(review)
                }
            }
        }
    }
    
    func clearReviews() {
//        reviews.removeAll()
//        reReviews.removeAll()
        rePosReviews.removeAll()
        reNegReviews.removeAll()
        irPosReviews.removeAll()
        irNegReviews.removeAll()
    }
}
