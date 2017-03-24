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
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var commonTableView: UITableView!
    
    @IBOutlet weak var similarCollectionView: UICollectionView!
    @IBOutlet weak var titleView: UINavigationItem!
    var categories = [String]()
    
    var selectedAsin = String()
    var selectedProductTitle = String()
    
    var reviews = Reviews()
    var selectedCategory = String()
    var cp = PhraseCategory()
    var similarProducts = [Product]()
    var similarAsinProduct = String()
    var similarProductName = String()
    var commonPhrases = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the title in navigation bar
        self.titleView.title = "Review Category"
        
        // Set the prompt(text above title) in navigation bar
        self.navigationItem.prompt = selectedProductTitle.substring(to: selectedProductTitle.index(selectedProductTitle.startIndex, offsetBy: CoreDataHelper.setOffSet(titleCount: selectedProductTitle.characters.count)))
        
        categoryTableView.tableFooterView = UIView()
        // We set the table view header.
        //let categoryHeader = tableView.dequeueReusableCellWithIdentifier("HeaderCatCell") as! UITableViewCell
        //cellTableViewHeader.frame = CGRectMake(0, 0, self.tableView.bounds.width, self.heightCache[TableViewController.tableViewHeaderCustomCellIdentifier]!)
        //self.tableView.tableHeaderView = cellTableViewHeader
        commonTableView.tableFooterView = UIView()
        
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
                    
                    for obj in PhraseCategories.sharedPhraseCategories.phraseCategories {
                        var phraseString = ""
                        for word in obj.phrases {
                            phraseString += "\"" + word + "\" "
                        }
                        self.commonPhrases.append(phraseString)
                    }
                    
                    self.categoryTableView.reloadData()
                    self.commonTableView.reloadData()
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
        if(tableView == categoryTableView) {
            return categories.count
        }
        else if (tableView == commonTableView){
            return commonPhrases.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == categoryTableView) {
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
        else {
            let cellCP = tableView.dequeueReusableCell(withIdentifier: "CellCommon", for: indexPath)
            cellCP.textLabel?.text = commonPhrases[indexPath.row]
            //cellCP.detailTextLabel?.text = String(self.cp.uids.count)
            
            return cellCP
        }
        
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
            return 43
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(tableView == categoryTableView){
            let cellHeader = categoryTableView.dequeueReusableCell(withIdentifier: "HeaderCatCell")
            cellHeader?.textLabel?.text = "Categories"
            return cellHeader
        }
        
        if (tableView == commonTableView){
            let cellHeader2 = commonTableView.dequeueReusableCell(withIdentifier: "HeaderCommonCell")
            cellHeader2?.textLabel?.text = "Common Phrases"
            return cellHeader2
        }
        
        else {
            return nil
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
            let selectedRow = categoryTableView.indexPathForSelectedRow?.row
            DestViewController.selectedCategory = categories[selectedRow!]
            DestViewController.reviews = self.reviews
            DestViewController.selectedProductTitle = self.selectedProductTitle
        }
    }
    
}


