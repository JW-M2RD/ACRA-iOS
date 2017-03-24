//
//  ACRAPhraseCategories.swift
//  ACRA-iOS
//
//  Created by Team Amazon on 3/23/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation

class PhraseCategories : NSObject {
    
    var asin: String! = nil
    
    var phraseCategories: [PhraseCategory] = []
    
    static let sharedPhraseCategories = PhraseCategories()
    
    override init() {
        super.init()
    }
    
    func addPhraseCategory(category: PhraseCategory) {
        phraseCategories.append(category)
    }
    
    func clearPhraseCategories() {
        phraseCategories.removeAll()
    }
}
