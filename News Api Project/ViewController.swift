//
//  ViewController.swift
//  News Api Project
//
//  Created by suryansh Bisen on 13/07/22.
//

import UIKit

class ViewController: UIViewController {

    var model = MainModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        model.getNews()
    }


}

