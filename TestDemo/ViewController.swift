//
//  ViewController.swift
//  TestDemo
//
//  Created by Faisal Maqsood on 25/10/2016.
//  Copyright © 2016 NenuTech. All rights reserved.
//

import UIKit
import SDWebImage



class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var trainTravelObjectArray : [TravelData] = []
    var busTravelObjectArray : [TravelData] = []
    var flightTravelObjectArray : [TravelData] = []

    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    @IBOutlet weak var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }

    @IBAction func refreshData(_ sender: UIBarButtonItem) {
        
        loadItems()
    }
    
    /* ===================================================================
     - Activity indicator for Load data wait
     =================================================================== */
    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadItems()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnValue = 0
        
        switch(mySegmentedControl.selectedSegmentIndex)
        {
        case 0:
            returnValue = trainTravelObjectArray.count
            break
        case 1:
            returnValue = busTravelObjectArray.count
            break
            
        case 2:
            returnValue = flightTravelObjectArray.count
            break
            
        default:
            break
            
        }
        
        return returnValue
    }
    
    
    
    
    
    func modifyURL(urlString : String , size : Int) -> String {
    
    
        return ""
    
    }
    
    /* ===================================================================
     - Load Items on Cell with Fetched Data on Cell Rows
     =================================================================== */
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let myCell : CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomTableViewCell
        
      // let imageView = myCell.viewWithTag(1) as! UIImageView
        
        
        
              switch(mySegmentedControl.selectedSegmentIndex)
        {
        case 0:
            
            
            let urlOfImageWithoutChangeOfSize = trainTravelObjectArray[indexPath.row].provider_logo
            let imageUrl = (urlOfImageWithoutChangeOfSize as NSString).replacingOccurrences(of: "{size}", with: "63")
            let url = NSURL(string: imageUrl)
       
            
            
           myCell.travelPrice.text = trainTravelObjectArray[indexPath.row].price_in_euros
           myCell.departureTimeLabel.text = trainTravelObjectArray[indexPath.row].departure_time
          myCell.travelImage.sd_setImage(with: url! as URL!)
            
            
            break
        case 1:
            
            let urlOfImageWithoutChangeOfSize = busTravelObjectArray[indexPath.row].provider_logo
            let imageUrl = (urlOfImageWithoutChangeOfSize as NSString).replacingOccurrences(of: "{size}", with: "63")
            let url = NSURL(string: imageUrl)
       
            
            
            
            myCell.travelPrice.text = busTravelObjectArray[indexPath.row].price_in_euros
           myCell.departureTimeLabel.text = busTravelObjectArray[indexPath.row].departure_time
             myCell.travelImage.sd_setImage(with: url! as URL!)
            
            break
            
        case 2:
            
            let urlOfImageWithoutChangeOfSize = flightTravelObjectArray[indexPath.row].provider_logo
            let imageUrl = (urlOfImageWithoutChangeOfSize as NSString).replacingOccurrences(of: "{size}", with: "63")
            let url = NSURL(string: imageUrl)
       
            
            
            myCell.travelPrice.text = flightTravelObjectArray[indexPath.row].price_in_euros
            myCell.departureTimeLabel.text = flightTravelObjectArray[indexPath.row].departure_time
             myCell.travelImage.sd_setImage(with: url! as URL!)
            
            break
            
        default:
            break
            
        }

        return myCell
    }

    /* ===================================================================
     - check wheater is empty or full with data
     =================================================================== */
    
    @IBAction func segmentedControlActionChanged(_ sender: UISegmentedControl) {
        
    switch(mySegmentedControl.selectedSegmentIndex)
        {
        case 0:
            
            if(trainTravelObjectArray.count == 0)
            {
                loadItems()
            } else {
                
                myTableView.reloadData()
            }
            break
            
        case 1:
            if(busTravelObjectArray.count == 0)
            {
                loadItems()
            } else {
                myTableView.reloadData()
            }
            break
            
        case 2:
            if(flightTravelObjectArray.count == 0)
            {
                loadItems()
            } else {
                myTableView.reloadData()
            }
            break
            
        default:
            break
            
        }
   
    }

    /* ===================================================================
     - Load Items function
     =================================================================== */
    
    func loadItems()
    {
        switch(mySegmentedControl.selectedSegmentIndex)
        {
        case 0:
            
            loadItemsNow(listType: "w60i")
            break
        case 1:
            loadItemsNow(listType: "3zmcy")
            break
            
        case 2:
            loadItemsNow(listType: "37yzm")
            break
            
        default:
            break
        }
    }

    /* ===================================================================
     - Get JSON from Server and Insert one by one as record in Objects and
     - save in Arrays of Travel Data Object
     =================================================================== */
    
    func loadItemsNow(listType:String){
        
        myActivityIndicator.startAnimating()
        
        let listUrlString =  "https://api.myjson.com/bins/" + listType
        let myUrl = NSURL(string: listUrlString);
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "GET";
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
 
            if error != nil {
                print(error!.localizedDescription)
                
                DispatchQueue.main.async(execute: {
                    
                    self.myActivityIndicator.stopAnimating()
                })
                
                return
            }

            do {
                
                if data?.count != 0
                {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) //as? NSArray
                for anItem in json as! [Dictionary<String, AnyObject>] {
                    
                         if(listType == "w60i")
                           {
                            
                            let travelSource = TravelData()
                            
                            travelSource.departure_time = String(describing: anItem["departure_time"]!)
                            travelSource.arrival_time = String(describing: anItem["arrival_time"]!)
                            travelSource.price_in_euros = String(describing: anItem["price_in_euros"]!)
                            travelSource.provider_logo = String(describing: anItem["provider_logo"]!)
                            self.trainTravelObjectArray.append(travelSource)
                           } else if(listType == "3zmcy")
                           {

                            let travelSource = TravelData()
                            
                            travelSource.departure_time = String(describing: anItem["departure_time"]!)
                            travelSource.arrival_time = String(describing: anItem["arrival_time"]!)
                            travelSource.price_in_euros = String(describing: anItem["price_in_euros"]!)
                            travelSource.provider_logo = String(describing: anItem["provider_logo"]!)
                            self.busTravelObjectArray.append(travelSource)
                            } else if(listType == "37yzm") {
                    
                            let travelSource = TravelData()
                            
                            travelSource.departure_time = String(describing: anItem["departure_time"]!)
                            travelSource.arrival_time = String(describing: anItem["arrival_time"]!)
                            travelSource.price_in_euros = String(describing: anItem["price_in_euros"]!)
                            travelSource.provider_logo = String(describing: anItem["provider_logo"]!)

                            self.flightTravelObjectArray.append(travelSource)
                            }
                      }
                }

            } catch {
                print(error)
                
            }
            
            DispatchQueue.main.async(execute: {
                
                self.myActivityIndicator.stopAnimating()
                self.myTableView.reloadData()

            })
        }
        
        task.resume()
    }
} // class ends






