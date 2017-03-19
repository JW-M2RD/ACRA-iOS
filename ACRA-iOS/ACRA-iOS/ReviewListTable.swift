//
//  ReviewListTable.swift
//  ACRA-iOS
//
//  Created by Mr.RD on 2/20/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation
import UIKit

class ReviewListTable: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationTitle: UINavigationItem!

    
    var SearchLabel = String()
//    var database = Database()
    var reviews = Reviews()
    var selectedCategory = String()
    var selectedProductTitle = String ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationTitle.title = "Review List (" + self.selectedCategory + ")"
        
        // Set the prompt(text above title) in navigation bar
        self.navigationItem.prompt = selectedProductTitle.substring(to: selectedProductTitle.index(selectedProductTitle.startIndex, offsetBy: CoreDataHelper.setOffSet(titleCount: selectedProductTitle.characters.count)))

        tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if self.selectedCategory == "Product Quality" {
            
            
            if(self.reviews.negReviews.count == 0){
                setDogImg()
                return 0
            }
            // use negative reiviews for now
            tableView.backgroundView = nil
            return self.reviews.negReviews.count
        }
        else {
            if(self.reviews.irReview.count == 0){
                setDogImg()
                return 0
            }
            tableView.backgroundView = nil
            return self.reviews.irReview.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewListCell
        
//        print(self.selectedCategory)
        
        
        if self.selectedCategory == "Product Quality" {
            // use negative reiviews for now
            
            // another if to display positive or negative
            cell.titleText.text = self.reviews.negReviews[indexPath.row].summary
            cell.reviewer.text = self.reviews.negReviews[indexPath.row].reviewerName
            cell.ReviewText.text = self.reviews.negReviews[indexPath.row].reviewText
        }
        else{
            // None product quality
            cell.titleText.text = self.reviews.irReview[indexPath.row].summary
            cell.reviewer.text = self.reviews.irReview[indexPath.row].reviewerName
            cell.ReviewText.text = self.reviews.irReview[indexPath.row].reviewText
        }
        
        
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if (segue.identifier == "ReviewCategory"){
        
        let DestViewController: ReviewDetailViewController = segue.destination as! ReviewDetailViewController
        let selectedRow = tableView.indexPathForSelectedRow?.row
        DestViewController.selectedProductTitle = self.selectedProductTitle

        if self.selectedCategory == "Product Quality" {
            DestViewController.review = self.reviews.negReviews[selectedRow!]
            DestViewController.reviewCategoryName = self.selectedCategory
        }
        else{
            DestViewController.review = self.reviews.irReview[selectedRow!]
            DestViewController.reviewCategoryName = self.selectedCategory
        }
    }
    
    func setDogImg () {
        let image = UIImage(named: "dog")
        let noDataImage = UIImageView(image: image)
        tableView.backgroundView = noDataImage
    }
    
}
