//
//  ReviewCategoryViewController.swift
//  ACRA-iOS
//
//  Created by Ankit Luthra on 2/19/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation
import UIKit

class ReviewCategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    var categories = [String]()
    var selectedAsin = String()
    var reviews = Reviews()
    var selectedCategory = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationItem.prompt = "This is the subtitle";
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("Review number: ", self.reviews.numReviews)
        print("Positive Review number: ", self.reviews.rePosReviews.count)
        print("Negative Review number: ", self.reviews.reNegReviews.count)
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        if(cell.textLabel?.text == "Product Quality"){
//            cell.detailTextLabel?.text = "472"
//            let relCount = self.reviews.rePosReviews.count + self.reviews.reNegReviews.count
            print("review number: ", self.reviews.rePosReviews.count + self.reviews.reNegReviews.count)
            
            cell.detailTextLabel?.text = String(self.reviews.rePosReviews.count + self.reviews.reNegReviews.count)
        }
        else if(cell.textLabel?.text == "Non Product Quality"){
//            cell.detailTextLabel?.text = "53"
            cell.detailTextLabel?.text = String(self.reviews.irPosReviews.count + self.reviews.irNegReviews.count)
        }
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Products"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let DestViewController: ReviewListTable = segue.destination as! ReviewListTable
            let selectedRow = tableView.indexPathForSelectedRow?.row
            DestViewController.selectedCategory = categories[selectedRow!]
            DestViewController.reviews = self.reviews


    }
    

    
    
}
