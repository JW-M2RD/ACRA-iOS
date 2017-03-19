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
    @IBOutlet weak var positiveSegmentedController: UISegmentedControl!
    @IBAction func SegmentedAction(_ sender: Any) {
        self.tableView.reloadData()
    }

    
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

            tableView.backgroundView = nil
            
            switch self.positiveSegmentedController.selectedSegmentIndex {
            case 0:
                if(self.reviews.rePosReviews.count == 0){
                    setDogImg()
                    return 0
                }
                return self.reviews.rePosReviews.count
            case 1:
                if(self.reviews.reNegReviews.count == 0){
                    setDogImg()
                    return 0
                }
                return self.reviews.reNegReviews.count
            default:
                break
            }
        }
        else {
            switch self.positiveSegmentedController.selectedSegmentIndex {
            case 0:
                if(self.reviews.irPosReviews.count == 0){
                    setDogImg()
                    return 0
                }
                return self.reviews.irPosReviews.count
            case 1:
                if(self.reviews.irNegReviews.count == 0){
                    setDogImg()
                    return 0
                }
                return self.reviews.irNegReviews.count
            default:
                break
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewListCell
        
        
        if self.selectedCategory == "Product Quality" {
            
            
            switch self.positiveSegmentedController.selectedSegmentIndex {
            case 0:
                cell.titleText.text = self.reviews.rePosReviews[indexPath.row].summary
                cell.reviewer.text = self.reviews.rePosReviews[indexPath.row].reviewerName
                cell.ReviewText.text = self.reviews.rePosReviews[indexPath.row].reviewText
            case 1:
                cell.titleText.text = self.reviews.reNegReviews[indexPath.row].summary
                cell.reviewer.text = self.reviews.reNegReviews[indexPath.row].reviewerName
                cell.ReviewText.text = self.reviews.reNegReviews[indexPath.row].reviewText
            default:
                break
            }
            
        }
        else{
            // None product quality
            switch self.positiveSegmentedController.selectedSegmentIndex {
            case 0:
                cell.titleText.text = self.reviews.irPosReviews[indexPath.row].summary
                cell.reviewer.text = self.reviews.irPosReviews[indexPath.row].reviewerName
                cell.ReviewText.text = self.reviews.irPosReviews[indexPath.row].reviewText
            case 1:
                cell.titleText.text = self.reviews.irNegReviews[indexPath.row].summary
                cell.reviewer.text = self.reviews.irNegReviews[indexPath.row].reviewerName
                cell.ReviewText.text = self.reviews.irNegReviews[indexPath.row].reviewText
            default:
                break
            }
        }
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if (segue.identifier == "ReviewCategory"){
        
        let DestViewController: ReviewDetailViewController = segue.destination as! ReviewDetailViewController
        let selectedRow = tableView.indexPathForSelectedRow?.row
        DestViewController.selectedProductTitle = self.selectedProductTitle

        if self.selectedCategory == "Product Quality" {
            DestViewController.reviewCategoryName = self.selectedCategory
            
            switch self.positiveSegmentedController.selectedSegmentIndex {
            case 0:
                DestViewController.review = self.reviews.rePosReviews[selectedRow!]
            case 1:
                DestViewController.review = self.reviews.reNegReviews[selectedRow!]
            default:
                break
            }
        }
        else{
            DestViewController.reviewCategoryName = self.selectedCategory
            
            switch self.positiveSegmentedController.selectedSegmentIndex {
            case 0:
                DestViewController.review = self.reviews.irPosReviews[selectedRow!]
            case 1:
                DestViewController.review = self.reviews.irNegReviews[selectedRow!]
            default:
                break
            }
        }
    }
    
    func setDogImg () {
        let image = UIImage(named: "dog")
        let noDataImage = UIImageView(image: image)
        tableView.backgroundView = noDataImage
    }
    
}
