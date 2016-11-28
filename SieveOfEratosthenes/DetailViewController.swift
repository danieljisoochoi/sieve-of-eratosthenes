//
//  DetailViewController.swift
//  SieveOfEratosthenes
//
//  Created by Daniel Jisoo Choi on 11/27/16.
//  Copyright © 2016 Daniel Jisoo Choi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    
    var number = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        numberLabel.text = number
    }


}
