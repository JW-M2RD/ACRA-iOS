//
//  ACRAProducts.swift
//  ACRA-iOS
//
//  Created by Team Amazon on 2/20/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation

class Products: NSObject {
    
    var products: [Product] = []
    
    static let sharedProducts = Products()
    
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
}
