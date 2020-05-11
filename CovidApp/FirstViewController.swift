//
//  FirstViewController.swift
//  CovidApp
//
//  Created by Anna Maria on 06/05/2020.
//  Copyright © 2020 Anna Maria. All rights reserved.
//

import UIKit
import Foundation

class FirstViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLiveStatus()
        
    }

    func getLiveStatus() {
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-ddTHH:mm:ssZ"
        let dateString = df.string(from: date)
        
        let urlDenmark = "https://api.covid19api.com/country/denmark/status/confirmed/live?from=2020-05-10T00:00:00Z&to=\(dateString)"
        
        print(urlDenmark)
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: urlDenmark)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            let liveData = String(data: data, encoding: .utf8)!
            print(liveData)
            print(type(of: liveData))
            //liveData.indices(of: "Cases")
            print(self.findCases(liveData))
            
            
            do {
                let liveDataArray = try JSONSerialization.jsonObject(with: data, options: [])
                //print(liveDataArray)
                //print(type(of: liveDataArray))
                //let lastIndex = (liveDataArray as AnyObject).count!
                //print((liveDataArray as AnyObject).index(of: lastIndex))
            
                
            } catch {
                print("error")
            }
            
        
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
    
    func findCases(_ content:String) -> [Substring] {
        let pattern = "Cases\":"
        var srcs:[Substring] = []
        var startIndex = content.startIndex
        while let range =  content[startIndex...].range(of: pattern, options: .regularExpression) {
            srcs.append(content[range])
            startIndex = range.upperBound
        }
        return srcs
    }
    
    

}

