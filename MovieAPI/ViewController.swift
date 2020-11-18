//
//  ViewController.swift
//  MovieAPI
//
//  Created by Alan Aumiller II on 2/21/20.
//  Copyright © 2020 Alan Aumiller II. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backlabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var infoDisplayLabel: UILabel!
    @IBOutlet weak var movieTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func movieSearchButton(_ sender: Any) {
        
    if let url = URL(string:"http://www.omdbapi.com/?apikey=d647ef41&t=" + movieTextField.text!.replacingOccurrences(of: " ", with: "%20") + "") {
                
        let task = URLSession.shared.dataTask(with: url) {
                    (data, response, error) in
                    
            if error != nil {
                    print(error!)
            }else {
                        
            if let urlContent = data {
                    
                do {
                        
            let jsonResult = try JSONSerialization.jsonObject(with:urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
        
            DispatchQueue.main.sync(execute: {
               
                
                self.titleLabel.text =
                    (jsonResult["Title"]!! as? String)
                self.infoDisplayLabel.text =
                    (jsonResult["Year"]!! as? String)
                self.directorLabel.text =
                    (jsonResult["Director"]!! as? String)
                self.actorsLabel.text =
                    (jsonResult["Actors"]!! as? String)
                self.ratingLabel.text =
                    (jsonResult["Rated"]!! as? String)
                
                let string = jsonResult["Poster"] as? String
                let url = URL(string: string!)
                let data = try? Data(contentsOf: url!)
                self.posterImage.image = UIImage(data: data!)
                })
                
                    
                } catch {
                    
                        print("JSON Processing Failed")
                    
                        }
                    } else {
                        DispatchQueue.main.sync(execute: {
                            self.errorLabel.text = "Movie not found."
                        })
                    }
                }
            }
        
            task.resume()
                    
                }
        
    }// End movieSearchButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }//End viewDidLoad


}//End ViewController




