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
    @IBOutlet weak var reviewListTableView: UITableView!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var positiveSegmentedController: UISegmentedControl!
    @IBOutlet weak var listSortTableView: UITableView!
       @IBAction func SegmentedAction(_ sender: Any) {
        self.reviewListTableView.reloadData()
    }
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBAction func sortMenuTrigger(_ sender: Any) {
        if(menuShowing) {
            trailingConstraint.constant = -180
        }
        else {
            trailingConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = !menuShowing
    }


  
    var menuShowing = false

    var SearchLabel = String()
//    var database = Database()
    var reviews = Reviews()
    var selectedCategory = String()
    var selectedProductTitle = String ()
//    var sortByTitles = ["Newest","Oldest"]
    
    let sectionImages: [UIImage] = [#imageLiteral(resourceName: "Sorting"), #imageLiteral(resourceName: "Date")]
    
    let sections: [String] = ["Sort By", "Date"]
    let s1Data: [String] = []
    let s2Data: [String] = ["Newest", "Oldest"]
    

    var sectionData: [Int: [String]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationTitle.title = "Review List (" + self.selectedCategory + ")"
        setMenuToHidden()
        sectionData = [0:s1Data, 1:s2Data]
        
        listSortTableView.backgroundColor = UIColor (red: CGFloat(237/255.0), green: CGFloat(250/255.0), blue: CGFloat(255/255.0), alpha: 1.0)
        
        //for rounded corners
        listSortTableView.layer.cornerRadius = 10
        listSortTableView.layer.masksToBounds = true
        
        // Set the prompt(text above title) in navigation bar
        self.navigationItem.prompt = selectedProductTitle.substring(to: selectedProductTitle.index(selectedProductTitle.startIndex, offsetBy: CoreDataHelper.setOffSet(titleCount: selectedProductTitle.characters.count)))

        reviewListTableView.tableFooterView = UIView()
        listSortTableView.tableFooterView = UIView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setMenuToHidden() {
        trailingConstraint.constant = -180
        menuShowing = false
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView == reviewListTableView){
            if (self.selectedCategory == "Product Quality") {
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
        else {
            return (sectionData[section]?.count)!
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(tableView == listSortTableView){
            return sections.count
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == reviewListTableView){

            let cell = self.reviewListTableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewListCell
        
        
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
            else {
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
            setMenuToHidden()
            return cell
        }
        else {
            var cell2 = tableView.dequeueReusableCell(withIdentifier: "ListSortCell")
            if cell2 == nil {
                cell2 = UITableViewCell(style: .default, reuseIdentifier: "ListSortCell");
            }
            cell2!.textLabel?.text = sectionData[indexPath.section]![indexPath.row]
            cell2?.backgroundColor = UIColor (red: CGFloat(237/255.0), green: CGFloat(250/255.0), blue: CGFloat(255/255.0), alpha: 1.0)
            return cell2!
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (tableView == listSortTableView){
            let cellHeader = listSortTableView.dequeueReusableCell(withIdentifier: "HeaderCell\(section)") as! HeaderCellListSort
            cellHeader.setupCell(image: sectionImages[section], labelText: sections[section])
            return cellHeader

        }
        else {
            return nil
        }
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(tableView == listSortTableView) {
            return 45
        }
        else {
            return 0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if (segue.identifier == "ReviewCategory"){
        
        let DestViewController: ReviewDetailViewController = segue.destination as! ReviewDetailViewController
        let selectedRow = reviewListTableView.indexPathForSelectedRow?.row
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if (tableView == listSortTableView) {
                if(indexPath.section == 1){
                    switch indexPath.row {
                    case 0:
                        self.reviews.irNegReviews = self.reviews.irNegReviews.sorted{$0.unixReviewTime > $1.unixReviewTime}
                        self.reviews.irPosReviews = self.reviews.irPosReviews.sorted{$0.unixReviewTime > $1.unixReviewTime}
                        self.reviews.reNegReviews = self.reviews.reNegReviews.sorted{$0.unixReviewTime > $1.unixReviewTime}
                        self.reviews.rePosReviews = self.reviews.rePosReviews.sorted{$0.unixReviewTime > $1.unixReviewTime}
                    case 1:
                        self.reviews.irNegReviews = self.reviews.irNegReviews.sorted{$0.unixReviewTime < $1.unixReviewTime}
                        self.reviews.irPosReviews = self.reviews.irPosReviews.sorted{$0.unixReviewTime < $1.unixReviewTime}
                        self.reviews.reNegReviews = self.reviews.reNegReviews.sorted{$0.unixReviewTime < $1.unixReviewTime}
                        self.reviews.rePosReviews = self.reviews.rePosReviews.sorted{$0.unixReviewTime < $1.unixReviewTime}
                    default:
                        break
                    }
                setMenuToHidden()
                reviewListTableView.reloadData()
            }
        }
    }
    
    
    func setDogImg () {
        let image = UIImage(named: "dog")
        let noDataImage = UIImageView(image: image)
        reviewListTableView.backgroundView = noDataImage
    }
    
}
