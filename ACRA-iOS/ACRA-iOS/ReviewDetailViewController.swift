//
//  ReviewDetailViewController.swift
//  ACRA-iOS
//
//  Created by Team Amazon on 3/1/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation
import UIKit

class ReviewDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    var titleList = ["Very Happy"]
    var reviewerList = ["quirt27"]
    var reviewText = ["Love the new TV. Picture is awesome and set up was quick and easy. Also love Amazon's enhanced delievery......was very nice to have such a large... While I watch a lot of TV, I'd never claim to be an expert on the differences between models. So when the time came to buy a new one, I went... Considering the price I paid which was a bit less than $1100.00, I will rate this 5 stars. It has a good crisp picture. With a larger screen I... Absolutely stunning 4K TV for the money. Put this TV next to an old HD Sony I was replacing. With normal HD streaming the upscaling gave a remarkably better picture. Of course its"]
    var date = ["January 13, 2017"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.rowHeight = rev
//        tableView.estimatedRowHeight = 40
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 140
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resoureces that can be recreated
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ReviewDetailCell", for: indexPath) as! ReviewDetailCell
        
        cell.titleText.text = titleList[indexPath.row]
        cell.reviewer.text = "By " + reviewerList[indexPath.row]
        cell.reviewDate.text = "on " + date[indexPath.row]
        cell.reviewFullText.text = reviewText[indexPath.row]
        
        return cell
    }

}
