//
//  FirstViewController.swift
//  CovidApp
//
//  Created by Anna Maria on 06/05/2020.
//  Copyright © 2020 Anna Maria. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class FirstViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var showCasesBtn: UIButton!
    let locationManager = CLLocationManager()
    var liveCaseData:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        getLiveStatus()

    }

    @IBAction func showBtnPressed(_ sender: Any) {
    
        let alertController = UIAlertController(title: "Total Cases: \(self.liveCaseData)", message: "Stay home.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alertController, animated: true, completion: nil)
        
    }
    
    

    
    func getLiveStatus() {
        
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-ddTHH:mm:ssZ"
        let yesterdayString = df.string(from: yesterday)
        let todayString = df.string(from: today)
        
        let urlDenmark = "https://api.covid19api.com/country/denmark/status/confirmed/live?from=\(yesterdayString)&to=\(todayString)"
        
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: urlDenmark)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            let liveData = String(data: data, encoding: .utf8)!
            self.liveCaseData = self.findCases(liveData)
            print("total case: \(self.liveCaseData)")
        
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
    
    func findCases(_ content:String) -> Int {
       
        let strArr = content.split{ $0 == "," }
        
        let casesInMainland = strArr[7]
        let casesInGreenland = strArr[17]
        let casesInFaroeIsland = strArr[27]
        
        let mainlandIndex = casesInMainland.index(casesInMainland.startIndex, offsetBy: 14)
        let greenlandIndex = casesInGreenland.index(casesInGreenland.startIndex, offsetBy: 14)
        let faroeIndex = casesInFaroeIsland.index(casesInFaroeIsland.startIndex, offsetBy: 14)
        
        let mainlandCase = Int(casesInMainland[mainlandIndex...])!
        let greeenlandCase = Int(casesInGreenland[greenlandIndex...])!
        let faroeCase = Int(casesInFaroeIsland[faroeIndex...])!
    
        let totalCases = mainlandCase + greeenlandCase + faroeCase
        
        return totalCases
    }
    

}


// mainland lat 56.26 lon 9.5
