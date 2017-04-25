//
//  ViewController.swift
//  ACRA-iOS
//
//  Created by Mr.RD on 2/6/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import UIKit
import Foundation

// Display Search View

class ViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    @IBOutlet weak var searchInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchInput.delegate = self
        navigationController?.navigationBar.barTintColor = UIColor (red: CGFloat(52/255.0), green: CGFloat(168/255.0), blue: CGFloat(188/255.0), alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide keyborad
        searchInput.resignFirstResponder()
        return true
    }
    //MARK: Actions
    
    
    // Search button function
    // will pass search string to product result view
    @IBAction func searchButton(_ sender: UIButton) {
         //escaping string to send in an HTTP request
        let escapedString = searchInput.text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        // Call the get data from model
    
        guard escapedString != nil else {
            // Throw error in here
            return
        }
        
    }
    
    // Send search text to product View table controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController: ProductViewController = segue.destination as! ProductViewController
        
        DestViewController.SearchLabel = searchInput.text!
        
    }


}

