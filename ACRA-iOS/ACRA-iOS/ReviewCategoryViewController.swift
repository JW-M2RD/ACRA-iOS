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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationItem.prompt = "This is the subtitle";
        
        tableView.tableFooterView = UIView()
        categories = ["Product Quality", "Irrelevant"]
        print("Reivew Category View: " + self.selectedAsin)
        
        APIModel.sharedInstance.getReviews(escape: self.selectedAsin) { (success:Bool) in
            if success {
                print("Successfully got reviews")
                DispatchQueue.main.async {
                    for review in Reviews.sharedReviews.reReviews {
                        
                        self.reviews.addReview(review: review)
                    }
                    for review in Reviews.sharedReviews.irReview {
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let backItem = UIBarButtonItem()
//        backItem.title = "Back"
//        navigationItem.backBarButtonItem = backItem
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        if(cell.textLabel?.text == "Product Quality"){
//            cell.detailTextLabel?.text = "472"
            cell.detailTextLabel?.text = String(self.reviews.reReviews.count)
        }
        else if(cell.textLabel?.text == "Irrelevant"){
//            cell.detailTextLabel?.text = "53"
            cell.detailTextLabel?.text = String(self.reviews.irReview.count)
        }
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Products"
    }
    
    
}
