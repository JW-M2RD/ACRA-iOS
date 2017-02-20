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
    
    
    var names = ["Samsung 55-Inch", "Samsung Curved 4K", "Samsung 65-Inch 4K", "Samsung 40-Inch 1080p"]
    var prices = ["$2,499.99", "$3,499.99", "$1,597.99", "$3,47.99"]
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
