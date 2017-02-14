//
//  ViewController.swift
//  ACRA-iOS
//
//  Created by Mr.RD on 2/6/17.
//  Copyright © 2017 Team Amazon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testField: UITextView!
    @IBOutlet weak var searchInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //testing commit..
    @IBAction func searchButton(_ sender: UIButton) {
        testField.text = searchInput.text
    }


}

