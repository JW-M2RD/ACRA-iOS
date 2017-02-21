//
//  ProductViewController.swift
//  ACRA-iOS
//
//  Created by Ankit Luthra on 2/16/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation
import UIKit

class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationTitle: UINavigationItem!
  
    
    var SearchLabel = String()
    
    var names = [String]()
    var prices = [String]()
    var images = [UIImage]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Products.sharedProducts.clearProducts()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let escapedString = self.SearchLabel.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        APIModel.sharedInstance.getData(escape: escapedString!) { (success:Bool) in
            if success {
                print("Fuck yeah")
                DispatchQueue.main.async {
                    for product in Products.sharedProducts.products {
                        self.names.append(product.title)
                        self.prices.append(product.price_string)
                        self.images.append(self.get_image(product.image_url))
                    }
                    self.tableView.reloadData()
                }
                
            } else {
                print("Nope")
            }
        }
        
        navigationTitle.title = SearchLabel
        tableView.tableFooterView = UIView()


    }
    
    func get_image(_ urlString:String) -> UIImage {
        let strurl = NSURL(string: urlString)!
        let dtinternet = NSData(contentsOf:strurl as URL)!
        return UIImage(data: dtinternet as Data)!
        //        let bongtuyet:UIImageView = UIImageView(frame:CGRectMake(CGFloat(160),CGFloat(130),60,60))
        //        bongtuyet.image = UIImage(data:dtinternet as Data)
        //        self.view.addSubview(bongtuyet)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
        
//        cell.name.text = Products.sharedProducts.products[indexPath.row].title
//        cell.photo.image = get_image(Products.sharedProducts.products[indexPath.row].image_url)
//        cell.price.text = Products.sharedProducts.products[indexPath.row].price_string
//        
        
        print("aaaaaaaaaaa")
        print(Products.sharedProducts.products[indexPath.row].title)
        
        cell.photo.image = images[indexPath.row]
        cell.name.text = names[indexPath.row]
        cell.price.text = prices[indexPath.row]
        
        return cell
    }
}
