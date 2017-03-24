//
//  ReviewCategoryViewController.swift
//  ACRA-iOS
//
//  Created by Ankit Luthra on 2/19/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation
import UIKit

class ReviewCategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var similarCollectionView: UICollectionView!
    @IBOutlet weak var titleView: UINavigationItem!
    var categories = [String]()
    var selectedAsin = String()
    var selectedProductTitle = String()
    var reviews = Reviews()
    var selectedCategory = String()
    var similarProducts = [Product]()
    var similarAsinProduct = String()
    var similarProductName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the title in navigation bar
        self.titleView.title = "Review Category"
        
        // Set the prompt(text above title) in navigation bar
        self.navigationItem.prompt = selectedProductTitle.substring(to: selectedProductTitle.index(selectedProductTitle.startIndex, offsetBy: CoreDataHelper.setOffSet(titleCount: selectedProductTitle.characters.count)))
        
        tableView.tableFooterView = UIView()
        
        categories = ["Product Quality", "Non Product Quality"]
        print("Review Category View: " + self.selectedAsin)
        
        APIModel.sharedInstance.getReviews(escape: self.selectedAsin) { (success:Bool) in
            if success {
                print("Successfully got reviews")
                DispatchQueue.main.async {
                    for review in Reviews.sharedReviews.rePosReviews {
                        
                        self.reviews.addReview(review: review)
                    }
                    for review in Reviews.sharedReviews.reNegReviews {
                        
                        self.reviews.addReview(review: review)
                    }
                    for review in Reviews.sharedReviews.irPosReviews {
                        self.reviews.addReview(review: review)
                    }
                    for review in Reviews.sharedReviews.irNegReviews {
                        self.reviews.addReview(review: review)
                    }
                    self.tableView.reloadData()
                }
                
            } else {
                print("Product API call broke")
            }
        }
        
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
        //print("Positive Review number: ", self.reviews.rePosReviews.count)
        //print("Negative Review number: ", self.reviews.reNegReviews.count)
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        if(cell.textLabel?.text == "Product Quality"){

            //print("review number: ", self.reviews.rePosReviews.count + self.reviews.reNegReviews.count)
            
            cell.detailTextLabel?.text = String(self.reviews.rePosReviews.count + self.reviews.reNegReviews.count)
        }
        else if(cell.textLabel?.text == "Non Product Quality"){
            cell.detailTextLabel?.text = String(self.reviews.irPosReviews.count + self.reviews.irNegReviews.count)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let similarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellSimilar", for: indexPath) as! SimilarProductCell
        
        similarCell.setupSimilarCell(prImage: get_image(similarProducts[indexPath.row].image_url), name: similarProducts[indexPath.row].title,
                                     productQuality: similarProducts[indexPath.row].displayProductQualityNumber,
                                     nonProductQuality: similarProducts[indexPath.row].displayNonProductQualityNumber,
                                     productRating: similarProducts[indexPath.row].rating,
                                     price: similarProducts[indexPath.row].price_string)
        
        return similarCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == similarCollectionView {
            print("didSeclect CollectionView: ", self.similarProducts[indexPath.row].asin)
            self.similarAsinProduct = self.similarProducts[indexPath.row].asin
            self.similarProductName = self.similarProducts[indexPath.row].title
            self.performSegue(withIdentifier: "SimilarToCategory", sender: self)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SimilarToCategory"){
            let DestViewControllerSim: ReviewCategoryViewController = segue.destination as! ReviewCategoryViewController
        
        print("prepare CollectionView: ", self.similarAsinProduct)
            DestViewControllerSim.selectedAsin = self.similarAsinProduct
            DestViewControllerSim.selectedProductTitle = self.similarProductName
            
            print("SimilarAsin: " + self.similarAsinProduct)
            print("SimilarProductName" + self.similarProductName)
            
            print("Segue in Similar")
            print("Prouct View Controller: " + DestViewControllerSim.selectedAsin)
        }
        else {
            let DestViewController: ReviewListTable = segue.destination as! ReviewListTable
            let selectedRow = tableView.indexPathForSelectedRow?.row
            DestViewController.selectedCategory = categories[selectedRow!]
            DestViewController.reviews = self.reviews
            DestViewController.selectedProductTitle = self.selectedProductTitle
        }
    }
    
}


