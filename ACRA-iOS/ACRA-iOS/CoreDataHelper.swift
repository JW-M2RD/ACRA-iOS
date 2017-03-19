//
//  CoreDataHelper.swift
//  ACRA-iOS
//
//  Created by Team Amazon on 3/19/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation
import UIKit

class CoreDataHelper {
      // function to set the offSet for the prompt
    static func setOffSet(titleCount: Int?)  -> Int {
        // variable that stores '55' which we are considerng as the maximum length of the title
        let maxLength = 55
        //if title is more than maxLength then return the max string length
        if (titleCount! >= maxLength) {
            return maxLength
        } else {
            return titleCount!
        }
    }
}
