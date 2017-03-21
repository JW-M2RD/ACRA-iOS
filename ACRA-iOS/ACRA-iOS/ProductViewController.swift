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
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var navigationTitle: UINavigationItem!
  
    @IBAction func sortMenuTrigger(_ sender: Any) {
        sortTableView.isHidden = false
    }

    @IBOutlet weak var sortTableView: UITableView!
    
    var SearchLabel = String()
    var products: [Product] = []
    var selectedAsinProduct = String()
    var selectedProductName = String()
    let fullStarImage:  UIImage = UIImage(named: "starFull.png")!
    let halfStarImage:  UIImage = UIImage(named: "starHalf.png")!
    let emptyStarImage: UIImage = UIImage(named: "starEmpty.png")!
    
    var productRating = Double()
    
    var sortRules = ["Price: High to Low","Price: Low to High","Rating: High to Low","Rating: Low to High"]
    var sortRule = String()
    
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
                    for product in Products.sharedProducts.products {
                        self.products.append(product)
                    }
                    self.productTableView.reloadData()
                }
                
            } else {
                print("Product API call broke")
            }
        }
        
        navigationTitle.title = "Products"
        
//        self.productTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        self.sortTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SortCell")
        productTableView.tableFooterView = UIView()
        sortTableView.tableFooterView = UIView()
        sortTableView.backgroundColor = UIColor.gray
        sortTableView.tintColor = UIColor.blue
        

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
        if(tableView == productTableView) {
            if(self.products.count == 0){
                let image = UIImage(named: "dog")
                let noDataImage = UIImageView(image: image)
                productTableView.backgroundView = noDataImage

                return 0
            }
            else {
                productTableView.backgroundView = nil
            
                return self.products.count
            }
        }
        else {
            return self.sortRules.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == productTableView) {
            let cell = self.productTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
        
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
        else {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "SortCell", for: indexPath)
            cell2.textLabel?.text = self.sortRules[indexPath.row]
            cell2.backgroundColor = UIColor (red: CGFloat(237/255.0), green: CGFloat(250/255.0), blue: CGFloat(255/255.0), alpha: 1.0)
            return cell2
        }
    }
    
    // Get which selected from table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == productTableView) {
            print("selected asin: " + self.products[indexPath.row].asin)
            self.selectedAsinProduct = self.products[indexPath.row].asin
            self.selectedProductName = self.products[indexPath.row].title
            self.performSegue(withIdentifier: "ProductToCategory", sender: nil)
        }
        
        if(tableView == sortTableView) {
            switch indexPath.row {
            case 0:
                print("0: ", indexPath.row)
                self.products = self.products.sorted{$0.price_int > $1.price_int}
            case 1:
                print("1: ", indexPath.row)
                self.products = self.products.sorted{$0.price_int < $1.price_int}
            case 2:
                print("2: ", indexPath.row)
                self.products = self.products.sorted{$0.rating > $1.rating}
            case 3:
                print("3: ", indexPath.row)
                self.products = self.products.sorted{$0.rating < $1.rating}
            default:
                break
            }
            tableView.isHidden = true
            productTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ProductToCategory"){
            let DestViewController: ReviewCategoryViewController = segue.destination as! ReviewCategoryViewController
            DestViewController.selectedAsin = self.selectedAsinProduct
            DestViewController.selectedProductTitle = self.selectedProductName
            print("Prouct View Controller: " + DestViewController.selectedAsin)
        }
    }
    
    
}
