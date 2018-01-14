//
//  ViewController.swift
//  QuotesCollection
//
//  Created by Syed Rafay on 1/9/18.
//  Copyright © 2018 Syed Rafay. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import Kingfisher
import RealmSwift

protocol ViewControllerDelegate : class {
    func ViewControllerDidShowUp()
}

class ViewController: UIViewController, iCarouselDelegate {
    
    
    @IBOutlet weak var favouriteButton: UIButton!
    var q_Name:String = ""
    var a_Name:String = ""
    var c_Name:String = ""
    var n_ID:String = ""
    
    var quotesmenuIsVisible = false
    
    @IBOutlet weak var viewTrailing: NSLayoutConstraint!
    @IBOutlet weak var viewLeading: NSLayoutConstraint!
    @IBOutlet var viewCarousel: iCarousel!
    @IBOutlet weak var menu: UIButton!
    
    var quotesImage = [UIImage]()
    var quotes = [QuoteItem]()
//<<<<<<< HEAD
    
    
    
//=======
    var indexValue:Int?
    var quoteObj:[Quotes] = []
   
//>>>>>>> 8a8f0a75f1e41ea2794500271879dfe158874a39
    
    //DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData()
        viewCarousel.type = .invertedWheel
        retrieveData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func menu_pressed(_ sender: Any) {
        self.slideMenuController()?.openLeft()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // DOWNLOADING DATA
    
    func getURL (url:String, param: [String:Any]){
        Alamofire.request(url, parameters: param).responseObject { (response: DataResponse<QuoteItem>) in
            
            if(response.result.value?.thought?.thoughtAuthor?.image != nil){
                
                self.quotes.append(response.result.value!)
                self.viewCarousel.reloadData()
                
                print("now fetching data from query \(String(describing: response.result.value!.thought?.quoteFragment))")
                
            }
        }
    }
    
    func downloadData(){
        for _ in 0...40 {
            let randomValue = arc4random_uniform(11000)
            let quotesURL = URL(string: "https://www.forbes.com/forbesapi/thought/uri.json?enrich=false&query=\(randomValue)")
            
            getURL(url: "https://www.forbes.com/forbesapi/thought/uri.json", param: ["enrich": "false", "query": randomValue])
            
            let realmObj = Quotes()
            
            Alamofire.request(quotesURL!).responseJSON { response in
                
                var q_obj  = Quotes()
                let result = response.result
                if let dict = result.value as? Dictionary<String, AnyObject> {
                    
                    if let  secondDict = dict["thought"] as? Dictionary<String, AnyObject> {
                        
                        if let quoteMessage = secondDict["quote"] as? String {
                            q_obj.message = quoteMessage
                            
                            print(quoteMessage)
                            
                            
                            
                        }
                        
                        if let natural_id = secondDict["naturalId"] as? String {
                            
                            q_obj.natural_ID = natural_id
                            print(natural_id)
                            
                            
                            
                        }
                        
                        
                        if let authorGrab = secondDict["thoughtAuthor"] as? Dictionary<String,String> {
                            
                            if let authorName = authorGrab["name"]{
                                q_obj.Author = authorName
                                print(authorName)
                                
                                
                            }
                            
                            
                            
                        }
                        
                        if let categoryGrab = secondDict["thoughtThemes"] as? [Dictionary<String,String>] {
                            
                            if let categoryName = categoryGrab[0]["name"] {
                                q_obj.category = categoryName
                                print(categoryName)
                                
                                
                            }
                        }
                    }
                    
                }
//<<<<<<< HEAD
                realmObj.writeToRealm()
//=======
                
                
                
                self.quoteObj.append(q_obj)
                print(self.quoteObj)
//>>>>>>> 8a8f0a75f1e41ea2794500271879dfe158874a39
            }
        }// For loop Ending
        
        
    }//Download data function Ended
    
    @IBAction func selectFavourite(_ sender:Any){
        
        let realmObj = Quotes()
        
        realmObj.natural_ID = self.quoteObj[indexValue!].natural_ID
        realmObj.Author = self.quoteObj[indexValue!].Author
        realmObj.category = self.quoteObj[indexValue!].category

        realmObj.message = self.quoteObj[indexValue!].message
 realmObj.writeToRealm()
        retrieveData()

       
    }
    
 func retrieveData()
 {
    let quoteRecieved = uiRealm.objects(Quotes.self)
    print(quoteRecieved)
    }
    
}


extension ViewController:iCarouselDataSource{
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return self.quotes.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        let tempView = QuoteCard(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
        
        tempView.setupCard(quote: (self.quotes[index].thought?.quote) ?? "Umer", author: (self.quotes[index].thought?.thoughtAuthor?.name)?.capitalized ?? "Umer", theme: (self.quotes[index].thought?.thoughtThemes?.first?.name)?.capitalized ?? "Umer")
        
//<<<<<<< HEAD
        if(self.quotes[index].thought?.thoughtAuthor?.image != nil){
            
            let s = self.quotes[index].thought?.thoughtAuthor?.image ?? ""
            
            let url = URL(string: "https://i.forbesimg.com/media/lists/quotebank/\(s)_100x100.jpg")
            tempView.authorImage.kf.setImage(with: url)
            
            print("bhai ye nil nhi hain \((self.quotes[index].thought?.thoughtAuthor?.image ?? ""))")
            
//            let s = self.quotes[index].thought?.thoughtAuthor?.image ?? ""
//
//            Alamofire.request("https://i.forbesimg.com/media/lists/quotebank/\(s)_100x100.jpg").responseImage { response in
//                debugPrint(response)
//                if let image = response.result.value {
//                    tempView.setupImage(image: image)
//                }
//            }
        }
//=======
    
//>>>>>>> 8a8f0a75f1e41ea2794500271879dfe158874a39
        return tempView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.spacing{
            return value*1.25
        } else if option == iCarouselOption.arc{
            return value*(-0.1)
        }
        return value
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        if let indxVal = carousel.currentItemIndex as? Int {
       self.indexValue = indxVal
            print(indxVal)
            print("index 00000 \(self.indexValue!)")
        }
       
    }
 
    
}



//END OF VIEW CONTROLLER

