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
    
//    var titleList = ["Very Happy", "Delighted with this!", "It has a good picture", "With normal HD stream"]
//    var reviewerList = ["quirt27", "JAL", "raz", "game_a_lot"]
//    var reviewText = ["Love the new TV. Picture is awesome and set up was quick and easy. Also love Amazon's enhanced delievery......was very nice to have such a large...", "While I watch a lot of TV, I'd never claim to be an expert on the differences between models. So when the time came to buy a new one, I went...", "Considering the price I paid which was a bit less than $1100.00, I will rate this 5 stars. It has a good crisp picture. With a larger screen I...", "Absolutely stunning 4K TV for the money. Put this TV next to an old HD Sony I was replacing. With normal HD streaming the upscaling gave a remarkably better picture. Of course its", "Very nice tv at good price. Great picture quality, very thin but sturdy. Def would recommend"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitle.title = "Review List"
        tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if self.selectedCategory == "Product Quality" {
            
            
            if(self.reviews.negReviews.count == 0){
//                let image = UIImage(named: "dog")
//                let noDataImage = UIImageView(image: image)
//                tableView.backgroundView = noDataImage
//                
//                return 0
                setDogImg()
                return 0
            }
            // use negative reiviews for now
            tableView.backgroundView = nil
            return self.reviews.negReviews.count
        }
        else {
            if(self.reviews.irReview.count == 0){
//                let image = UIImage(named: "dog")
//                let noDataImage = UIImageView(image: image)
//                tableView.backgroundView = noDataImage
//                
//                return 0
                setDogImg()
                return 0
            }
            tableView.backgroundView = nil
            return self.reviews.irReview.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewListCell
        
//        cell.titleText.text = titleList[indexPath.row]
//        cell.reviewer.text = reviewerList[indexPath.row]
//        cell.ReviewText.text = reviewText[indexPath.row]
        
        print(self.selectedCategory)
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
    
    func setDogImg () {
        let image = UIImage(named: "dog")
        let noDataImage = UIImageView(image: image)
        tableView.backgroundView = noDataImage
    }
}
