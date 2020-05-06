//
//  SecondViewController.swift
//  CovidApp
//
//  Created by Anna Maria on 06/05/2020.
//  Copyright © 2020 Anna Maria. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // Prompts to call when on physical device
    @IBAction func callBtnPressed(_ sender: UIButton) {
        guard let numberString = sender.titleLabel?.text,
              let url = URL(string:"telprompt://\(numberString)") else {
            return
        }
        UIApplication.shared.open(url)
    }
    

    
}

