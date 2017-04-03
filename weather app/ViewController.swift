//
//  ViewController.swift
//  weather app
//
//  Created by Milos Mladenovic on 3/2/17.
//  Copyright © 2017 Milos Mladenovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBAction func submitPressed(_ sender: Any) {
        view.endEditing(true)
        if let url = URL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest") {
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            var message = ""
            
            if error != nil {
                
                print(error! as NSError)
                
            }else {
                
                if let unwrapedData = data {
                    
                    let dataString = NSString(data: unwrapedData, encoding: String.Encoding.utf8.rawValue)
                    
                    var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                    
                    if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                        
                        if contentArray.count > 1 {
                            
                            stringSeparator = "</span>"
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                            
                            if newContentArray.count > 1 {
                                
                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                
                                print(message)
                                
                                
                            }
                        }
                    }
                }
            }
            
            if message == "" {
                
                message = "Weather couldn't be found. Please try again."
                
            }
            
            DispatchQueue.main.sync(execute: {
                
                self.resultLabel.text = message
                
            })
            
            
            
            
        }
        task.resume()
        
        } else {
            
            resultLabel.text = "Weather couldn't be found. Please try again."
            
        }
        
        
    }
    



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        
    
    
    
}
        
    





}
