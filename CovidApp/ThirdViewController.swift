//
//  ThirdViewController.swift
//  CovidApp
//
//  Created by Plam Stefanova on 5/8/20.
//  Copyright © 2020 Anna Maria. All rights reserved.
//

import UIKit
import Foundation

class ThirdViewController: UIViewController, UITableViewDataSource {
    
    
    
   let sections = ["Symptoms"]
    let sympt = ["Headache", "Fever", "Cold"]

    override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return sections[section]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
      return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sympt.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      // Create an object of the dynamic cell "PlainCell"
      let cell = tableView.dequeueReusableCell(withIdentifier: "PlainCell", for: indexPath)
      // Depending on the section, fill the textLabel with the relevant text
      cell.textLabel?.text = sympt[indexPath.row]
        
      // Return the configured cell
      return cell
    }

    
}
