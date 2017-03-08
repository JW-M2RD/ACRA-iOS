//
//  ACRAReview.swift
//  ACRA-iOS
//
//  Created by Team Amazon on 2/22/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation

class Review: NSObject {
    var asin: String! = nil
    var uid: String! = nil
    var relevant: Bool! = nil
    var reviewerName: String! = nil
    var reviewerTime: String! = nil
    var reviewText: String! = nil
    var reviewerID: String! = nil
    var overall: Int! = nil
    var unixReviewTime: Int! = nil
    var summary: String! = nil

    
    override init() {
        super.init()
    }
    
    override var debugDescription: String {
        let review =
        "asin: \(asin!)" +
        "uid: \(uid!)" +
        "relevant: \(relevant!)" +
        "summary: \(summary!)" +
        "reviewerName: \(reviewerName!)" +
        "reviewerTime: \(reviewerTime!)" +
        "reviewerID: \(reviewerID!)" +
        "overall: \(overall!)" +
        "unixReviewTime: \(unixReviewTime!)" +
        "\n" + //review text is annoying
        "reviewText: \(reviewText!)"
        
        
        return review
    }
    
}
