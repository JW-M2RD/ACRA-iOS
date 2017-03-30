//
//  ACRAPhraseCategory.swift
//  ACRA-iOS
//
//  Created by Team Amazon on 3/23/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation

class PhraseCategory: NSObject {
    
//    var asin: String! = nil
//    var phrases: [String]! = nil
//    var uids: Set<String>! = []
    
    var phrases: String! = nil
    var uids = [String]()
    var posReviews = [Review]()
    var negReviews = [Review]()
    
    override init() {
        super.init()
    }
    
    func addReview(review: Review) {
        if review.overall >= 3 {
            if !posReviews.contains(review) {
                posReviews.append(review)
            }
        }
        if review.overall <= 2 {
            if !negReviews.contains(review) {
                print("got neg Reviw")
                negReviews.append(review)
            }
        }
    }
}
