//
//  ProductViewController.swift
//  ACRA-iOS
//
//  Created by Ankit Luthra on 2/16/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import Foundation
import UIKit

class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    var SearchLabel = String()
    
    
    var names = ["Samsung QN55Q7F Flat 55-Inch 4K Ultra HD Smart QLED TV (2017 Model)", "Samsung QN55Q8C Curved 55-Inch 4K Ultra HD Smart QLED TV (2017 Model)", "Samsung UN65KS8000 65-Inch 4K Ultra HD Smart LED TV (2016 Model)", "Samsung UN40J6200 40-Inch 1080p Smart LED TV (2015 Model)"]
    var prices = ["$2499.99", "$3499.99", "$1597.99", "$347.99"]
    var images = [UIImage(named: "Samsung1"), UIImage(named: "Samsung2"), UIImage(named: "Samsung3"), UIImage(named: "Samsung4")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitle.title = SearchLabel
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
        
        cell.photo.image = images[indexPath.row]
        cell.name.text = names[indexPath.row]
        cell.price.text = prices[indexPath.row]
        
        return cell
    }

    
}
