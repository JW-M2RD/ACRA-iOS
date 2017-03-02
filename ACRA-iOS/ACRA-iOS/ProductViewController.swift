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
    var products: [Product] = []
    var selectedAsinProduct = String()
//    var names = [String]()
//    var prices = [String]()
//    var images = [UIImage]()
    let fullStarImage:  UIImage = UIImage(named: "starFull.png")!
    let halfStarImage:  UIImage = UIImage(named: "starHalf.png")!
    let emptyStarImage: UIImage = UIImage(named: "starEmpty.png")!
    
    var productRating = Double()
    
    
    func getStarImage(starNumber: Double, forRating rating: Double) -> UIImage {
        if rating >= starNumber {
            return fullStarImage
        } else if rating + 1 > starNumber {
            return halfStarImage
        } else {
            return emptyStarImage
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Products.sharedProducts.clearProducts()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let escapedString = self.SearchLabel.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        APIModel.sharedInstance.getProducts(escape: escapedString!) { (success:Bool) in
            if success {
                print("Successfully got products")
                DispatchQueue.main.async {
                    for product in Database.sharedProducts.products {
//                        self.names.append(product.title)
//                        self.prices.append(product.price_string)
//                        self.images.append(self.get_image(product.image_url))
                        
                        self.products.append(product)
                    }
                    self.tableView.reloadData()
                }
                
            } else {
                print("Product API call broke")
            }
        }
        
        navigationTitle.title = SearchLabel
        tableView.tableFooterView = UIView()
        
//        tableView.layoutMargins = UIEdgeInsets.zero
        
//        UIEdgeInsets layoutMargins = self.tableView.layoutMargins;
//        layoutMargins.right = 20.0f;
//        
//        self.tableView.layoutMargins = layoutMargins;


    }
    
    func get_image(_ urlString:String) -> UIImage {
        let strurl = NSURL(string: urlString)!
        let dtinternet = NSData(contentsOf:strurl as URL)!
        return UIImage(data: dtinternet as Data)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.products.count == 0){
            let image = UIImage(named: "dog")
            let noDataImage = UIImageView(image: image)
            tableView.backgroundView = noDataImage

            return 0
        }
        else {
            tableView.backgroundView = nil
            
            return self.products.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
        
        
//        print("aaaaaaaaaaa")
//        print("Title: " + Products.sharedProducts.products[indexPath.row].title)
        print("ASIN: " + self.products[indexPath.row].asin)
        print("Price: " + self.products[indexPath.row].price_string)
        print("Rating: ", +self.products[indexPath.row].rating)
//        print("Price: " + self.products[indexPath.row].rating)
//        cell.photo.image = images[indexPath.row]
//        cell.name.text = names[indexPath.row]
//        cell.price.text = prices[indexPath.row]
        
        cell.photo.image = get_image(self.products[indexPath.row].image_url)
        cell.name.text = self.products[indexPath.row].title
        cell.price.text = self.products[indexPath.row].price_string
        if let productRating = self.products[indexPath.row].rating {
            cell.star1.image = getStarImage(starNumber: 1, forRating: productRating)
            cell.star2.image = getStarImage(starNumber: 2, forRating: productRating)
            cell.star3.image = getStarImage(starNumber: 3, forRating: productRating)
            cell.star4.image = getStarImage(starNumber: 4, forRating: productRating)
            cell.star5.image = getStarImage(starNumber: 5, forRating: productRating)
        }
        let rounded_rating = Double(round(100*(self.products[indexPath.row].rating))/100)
        cell.ratingValue.text = "(" + String(rounded_rating) + ")"

        return cell
    }
    
    // Get which selected from table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected asin: " + self.products[indexPath.row].asin)
        self.selectedAsinProduct = self.products[indexPath.row].asin
        self.performSegue(withIdentifier: "ProductToCategory", sender: nil)
        }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ProductToCategory"){
            let DestViewController: ReviewCategoryViewController = segue.destination as! ReviewCategoryViewController
            DestViewController.selectedAsin = self.selectedAsinProduct
            print("Prouct View Controller: " + DestViewController.selectedAsin)
        }
    }
    
    
}
