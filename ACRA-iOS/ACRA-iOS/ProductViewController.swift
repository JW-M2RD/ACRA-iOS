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
  
    var menuShowing = false
    
    @IBAction func sortMenuTrigger(_ sender: Any) {
        if(menuShowing) {
            trailingConstraint.constant = -180
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
                self.backgroundButton.alpha = 0
            })
        }
        else {
            trailingConstraint.constant = 0
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
                self.backgroundButton.alpha = 0.5
            })
        }
        menuShowing = !menuShowing
    }

    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var sortTableView: UITableView!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageDisplay: UITextField!
    
    var SearchLabel = String()
    var products: [Product] = []
    var selectedAsinProduct = String()
    var selectedProductName = String()
    let fullStarImage:  UIImage = UIImage(named: "starFull.png")!
    let halfStarImage:  UIImage = UIImage(named: "starHalf.png")!
    let emptyStarImage: UIImage = UIImage(named: "starEmpty.png")!
    
    var productRating = Double()
    
    var sortByPrice = ["High to Low","Low to High"]
    var sortByRating = ["High to Low","Low to High"]
    var sortRule = String()
    
    var finishedLoading = false
    var viewApperBool = false
    

    //Sorting options icon by Icons8: https://icons8.com/web-app/18636/Sorting-Options
    //Thanks to Icons8 for Price Tag USD icon: https://icons8.com/web-app/2971/Price-Tag-USD
    //Thanks to Icons8 for the Rating icon: https://icons8.com/web-app/11674/Rating
    let sectionImages: [UIImage] = [#imageLiteral(resourceName: "Sorting"), #imageLiteral(resourceName: "Price Tag"), #imageLiteral(resourceName: "Rating")]
    
    let sections: [String] = ["Sort By", "Price", "Rating"]
    let s1Data: [String] = []
    let s2Data: [String] = ["High to Low", "Low to High"]
    let s3Data: [String] = ["High to Low", "Low to High"]
    
    var sectionData: [Int: [String]] = [:]
    
    func setFinishedLoading(setTo: Bool){
        finishedLoading = setTo
    }
    
    func getFinishedLoading() -> Bool{
        return finishedLoading
    }
    
    func getStarImage(starNumber: Double, forRating rating: Double) -> UIImage {
        if rating >= starNumber {
            return fullStarImage
        } else if rating + 1 > starNumber {
            return halfStarImage
        } else {
            return emptyStarImage
        }
    }
    
    func setMenuToHidden() {
        trailingConstraint.constant = -180
        menuShowing = false
        backgroundButton.alpha = 0
    }
    
    func setDogImg (viewName: UITableView) {
        let image = UIImage(named: "dog")
        let noDataImage = UIImageView(image: image)
        viewName.backgroundView = noDataImage
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Products.sharedProducts.clearProducts()
        
        //if(self.finishedLoading == true){
        //    setDogImg(viewName: productTableView)
        //    activityIndicator.stopAnimating()
            //activityIndicator.hidesWhenStopped = true
        //}
       // if(self.productTableView.numberOfRows(inSection: 0) > 0){
       //     activityIndicator.stopAnimating()
            //activityIndicator.hidesWhenStopped = true
        //}
        viewApperBool = true
        if(self.getFinishedLoading()==true){
            print("stop animation")
            self.activityIndicator.stopAnimating()
            self.messageDisplay.isHidden = true
        }
        else if(self.getFinishedLoading()==false){
            let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                //code with delay
                if(self.productTableView.numberOfRows(inSection: 0) == 0) {
                    print("seting dog")
                    self.messageDisplay.isHidden=false
                    self.setDogImg(viewName: self.productTableView)
                    self.activityIndicator.stopAnimating()
                }
            }
            
        }
        
       print("viewdidappear")
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("")
        print("viewdidload")
        
        setMenuToHidden()
        sortTableView.backgroundColor = UIColor (red: CGFloat(237/255.0), green: CGFloat(250/255.0), blue: CGFloat(255/255.0), alpha: 1.0)

        //for rounded corners
        sortTableView.layer.cornerRadius = 10
        sortTableView.layer.masksToBounds = true
       
        sectionData = [0:s1Data, 1:s2Data, 2:s3Data]

        let escapedString = self.SearchLabel.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        activityIndicator.startAnimating()
        APIModel.sharedInstance.getProducts(escape: escapedString!) { (success:Bool) in
            if success {
                print("Successfully got products")
                print("entered successfully got products")
                DispatchQueue.main.async {
                    for product in Products.sharedProducts.products {
                        self.products.append(product)
                    }
                    self.productTableView.reloadData()
                    if(self.viewApperBool){
                        self.activityIndicator.isHidden = true
                    }
                }
            } else {
                print("Product API call broke")
            }
        }
        navigationTitle.title = "Products"
        
        productTableView.tableFooterView = UIView()
        sortTableView.tableFooterView = UIView()
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
        print("num of rows in sec")
        if(tableView == productTableView) {
            if(self.products.count == 0){
                return 0
            }
            else {
                productTableView.backgroundView = nil
            
                return self.products.count
            }
        }
        else {
            return (sectionData[section]?.count)!
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(tableView == sortTableView){
            return sections.count
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cell for row at")
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
            setFinishedLoading(setTo: true)
            
            return cell
        }
        else {
            var cell2 = tableView.dequeueReusableCell(withIdentifier: "SortCell")
            
            if cell2 == nil {
                cell2 = UITableViewCell(style: .default, reuseIdentifier: "SortCell");
            }
            
            cell2!.textLabel?.text = sectionData[indexPath.section]![indexPath.row]
            
            cell2?.backgroundColor = UIColor (red: CGFloat(237/255.0), green: CGFloat(250/255.0), blue: CGFloat(255/255.0), alpha: 1.0)
            return cell2!
        }
    }
    
    // Get which selected from table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(tableView == productTableView ) {
            print("selected asin: " + self.products[indexPath.row].asin)
            self.selectedAsinProduct = self.products[indexPath.row].asin
            self.selectedProductName = self.products[indexPath.row].title
            self.performSegue(withIdentifier: "ProductToCategory", sender: nil)
            setMenuToHidden()
        }
        
        if(tableView == sortTableView) {
            if(indexPath.section == 1) {
                switch indexPath.row {
                    case 0:
                        print("Sec:1 Row: 0 ->", indexPath.section , indexPath.row)
                        self.products = self.products.sorted{$0.price_int > $1.price_int}
                    case 1:
                        print("Sec:1 Row: 1 ->", indexPath.section , indexPath.row)
                        self.products = self.products.sorted{$0.price_int < $1.price_int}
                    default:
                        break
                    }
                }
            else if(indexPath.section == 2) {
                switch indexPath.row {
                    case 0:
                        print("Sec:2 Row: 0 ->", indexPath.section , indexPath.row)
                        self.products = self.products.sorted{$0.rating > $1.rating}
                    case 1:
                        print("Sec:2 Row: 1 ->", indexPath.section , indexPath.row)
                        self.products = self.products.sorted{$0.rating < $1.rating}
                    default:
                        break
                }
            }
            setMenuToHidden()
            productTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (tableView == sortTableView){
            let cellHeader = sortTableView.dequeueReusableCell(withIdentifier: "HeaderCell\(section)") as! HeaderCellProductSort
            cellHeader.setupCell(image: sectionImages[section], labelText: sections[section])
            return cellHeader
        }
        else {
            return nil
        }
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(tableView == sortTableView) {
            if(section==0){
                return 45
            }
            else{
                return 41
            }
            
        }
        else {
            return 0
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ProductToCategory"){
            let DestViewController: ReviewCategoryViewController = segue.destination as! ReviewCategoryViewController
            DestViewController.selectedAsin = self.selectedAsinProduct
            DestViewController.selectedProductTitle = self.selectedProductName
            DestViewController.products.products = self.products
            
            for product in self.products {
                if DestViewController.similarProducts.count < 11 && product.asin != self.selectedAsinProduct{
                    
                    DestViewController.similarProducts.append(product)
                }
            }
            print("Prouct View Controller: " + DestViewController.selectedAsin)
        }
    }
    
    
}
