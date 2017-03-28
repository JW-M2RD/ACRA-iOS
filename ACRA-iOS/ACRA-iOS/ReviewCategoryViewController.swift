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
    
    @IBOutlet weak var activityIndicatorCP: UIActivityIndicatorView!
    
    
    var categories = [String]()
    
    var selectedAsin = String()
    var selectedProductTitle = String()
    
    var reviews = Reviews()
    var selectedCategory = String()
    var cp = PhraseCategory()
    var similarProducts = [Product]()
    var similarAsinProduct = String()
    var similarProductName = String()
    var products = Products()
//    var commonPhrases = [String]()
    
    var commonPhrases = PhraseCategories()
    
    func startLoadingAnimation() {
        categoryTableView.isHidden = true
        commonTableView.isHidden = true
        similarCollectionView.isHidden = true
        activityIndicatorCP.startAnimating()
    }
    
    func stopLoadingAnimation() {
        categoryTableView.isHidden = false
        commonTableView.isHidden = false
        similarCollectionView.isHidden = false
        activityIndicatorCP.stopAnimating()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the title in navigation bar
        self.titleView.title = "Review Category"
        
        // Set the prompt(text above title) in navigation bar
        updateTitlePrompt(nameOfProduct: self.selectedProductTitle)
        
        //remove the footer lines
        categoryTableView.tableFooterView = UIView()
        commonTableView.tableFooterView = UIView()
        
        startLoadingAnimation()
        
        categories = ["Product Quality", "Non Product Quality"]
        print("Review Category View: " + self.selectedAsin)

        //ReviewAPI call when the page is loaded first time
        getReviewAPI(selectedAsinAPI: self.selectedAsin)
        
        //sort similar products by qualityNumber
        self.similarProducts = self.similarProducts.sorted{$0.displayProductQualityNumber > $1.displayProductQualityNumber}
    }
    
    func updateTitlePrompt (nameOfProduct: String) {
        self.navigationItem.prompt = nameOfProduct.substring(to: nameOfProduct.index(nameOfProduct.startIndex, offsetBy: CoreDataHelper.setOffSet(titleCount: nameOfProduct.characters.count)))
        self.selectedProductTitle = nameOfProduct
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
            return commonPhrases.phraseCategories.count
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

            cellCP.textLabel?.text = commonPhrases.phraseCategories[indexPath.row].phrases
            cellCP.detailTextLabel?.text = String(commonPhrases.phraseCategories[indexPath.row].uids.count)
            
            stopLoadingAnimation()
            
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
            
            // Update title of the page when item clicked
            updateTitlePrompt(nameOfProduct: self.similarProducts[indexPath.row].title)
            
            //remove the reviews when clicked again
            self.reviews.clearReviews()
            
            //updating the selected ASIN to the selected ASIN of similar product.
            self.selectedAsin = self.similarProducts[indexPath.row].asin
            
            
            startLoadingAnimation()
            
            //call to review API to update our reviews to according to selected ASIN
            getReviewAPI(selectedAsinAPI: self.similarProducts[indexPath.row].asin)
            
            //call to create new similar products collection view accordingly
            createSimilarProducts(selected: self.selectedAsin)
      
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
        if(segue.identifier == "CategoryToList"){
            let DestViewController: ReviewListTable = segue.destination as! ReviewListTable
            let selectedRow = categoryTableView.indexPathForSelectedRow?.row
            DestViewController.selectedCategory = categories[selectedRow!]
            DestViewController.reviews = self.reviews
            DestViewController.selectedProductTitle = self.selectedProductTitle
        }
        else if(segue.identifier == "CommonPhraseToList") {
            let DestViewController: ReviewListTable = segue.destination as! ReviewListTable
            let selectedRow = commonTableView.indexPathForSelectedRow?.row
            DestViewController.selectedCategory = commonPhrases.phraseCategories[selectedRow!].phrases
            DestViewController.selectedProductTitle = self.selectedProductTitle
            DestViewController.phraseCategory = self.commonPhrases.phraseCategories[selectedRow!]
          //DestViewController.reviews = self.commonPhrases.phraseCategories[selectedRow!].uids
        }
    }
    
    func createSimilarProducts (selected : String) {
        self.similarProducts.removeAll()
        for product in self.products.products {
            if self.similarProducts.count < 11 && product.asin != selected{
                self.similarProducts.append(product)
            }
        }
        self.similarProducts = self.similarProducts.sorted{$0.displayProductQualityNumber > $1.displayProductQualityNumber}
    }
    
    func getReviewAPI(selectedAsinAPI: String){
        APIModel.sharedInstance.getReviews(escape: selectedAsinAPI) { (success:Bool) in
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
                    
                    self.commonPhrases = PhraseCategories.sharedPhraseCategories
                    self.categoryTableView.reloadData()
                    self.commonTableView.reloadData()
                    self.similarCollectionView.reloadData()
                }
                
            } else {
                print("Product API call broke")
            }
            
        }
    }
    
}


