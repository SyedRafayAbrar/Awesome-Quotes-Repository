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
   var menuselect = ""
    var categoryRecieved:String = ""
     weak var delegate:MenuViewController!
    @IBOutlet weak var currentLabel: UILabel!
    var catQuoteObj = [QuoteCard]()
    @IBOutlet weak var favouriteButton: UIButton!
    
    var quotesmenuIsVisible = false
    
    @IBOutlet weak var viewTrailing: NSLayoutConstraint!
    @IBOutlet weak var viewLeading: NSLayoutConstraint!
    @IBOutlet var viewCarousel: iCarousel!
    @IBOutlet weak var menu: UIButton!
    
    var quotesImage = [UIImage]()
    var quotes = [QuoteItem]()
    var catWise=[BaseClass]()
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
        currentLabel.text = categoryRecieved
        print("******************\(categoryRecieved)")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func menu_pressed(_ sender: Any) {
        self.slideMenuController()?.openLeft()
        dismiss(animated: true, completion: nil)
        if categoryRecieved == "Selected"{
            categoryRecieved = "Deselected"
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // DOWNLOADING DATA
    

    func getURL_s(url:String, param: [String:Any]){
        Alamofire.request(url, parameters: param).responseObject { (response: DataResponse<BaseClass>) in
            
//            if(response.result.value?.thought?.thoughtAuthor?.image != nil){
            
                self.catWise.append(response.result.value!)
                self.viewCarousel.reloadData()
                
                print("now fetching data from query \(String(describing: response.result.value!.thoughtStream?.thoughts?.first?.quote))")
                
            
        }
    }
    
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
        
        if self.categoryRecieved == "" {
        for _ in 0...40 {
            let randomValue = arc4random_uniform(11000)
            let quotesURL = URL(string: "https://www.forbes.com/forbesapi/thought/uri.json?enrich=false&query=\(randomValue)")
            
            getURL(url: "https://www.forbes.com/forbesapi/thought/uri.json", param: ["enrich": "false", "query": randomValue])
            
            
            Alamofire.request(quotesURL!).responseJSON { response in
                
                let q_obj  = Quotes()
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

                
                
                
                self.quoteObj.append(q_obj)
//                print(self.quoteObj)
//>>>>>>> 8a8f0a75f1e41ea2794500271879dfe158874a39
            }
        }// For loop Ending
        } else {
            for _ in 0...5 {
                let randomValue = arc4random_uniform(10)


                getURL_s(url: "https://www.forbes.com/forbesapi/thought/get.json?", param: ["limit":1,"meta":true,"start":randomValue, "stream":true,"themeuri":"\(self.categoryRecieved.lowercased())"])
            print("++++Else++")
            
                
//                let quotesURL = URL(string: "https://www.forbes.com/forbesapi/thought/get.json?limit=1&meta=true&start=\(randomValue)&stream=true&themeuri=\(categoryRecieved.lowercased())")
                
//                Alamofire.request(quotesURL!).responseJSON { response in
//                    let cQuoteObj = ()
//                    let result = response.result
//
//                    if let dict = result.value as? Dictionary<String, AnyObject> {
//                        if let first = dict["thoughtStream"] as? Dictionary<String,AnyObject> {
//                            if let grabQuote = first["thoughts"] as? [Dictionary<String,AnyObject>] {
//                                if let grab = grabQuote[0] as? Dictionary<String,AnyObject> {
//                                    if let quote = grab["quote"] as? String {
//                                        cQuoteObj.message = quote
//                                        print("------\(quote)")
//                                    }
//                                    if let author = grab["thoughtAuthor"] as? Dictionary<String,AnyObject> {
//                                        if let author_name = author["name"] as? String {
//                                            cQuoteObj.Author = author_name
//                                            print("------\(author_name)")
//
//                                        }
//
//                                    }
//
//                                    if let theme = grab["thoughtThemes"] as? [Dictionary<String,AnyObject>] {
//                                        if let theme_name = theme[0]["name"] as? String {
//                                            cQuoteObj.Theme = theme_name
//                                            print("------\(theme_name)")
//
//                                        }
//
//                                    }
//
//                                }
//                            }
//
//                        }
//                    }
//                    self.catWise.append(cQuoteObj)
//                }
            }
        }

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

   
    
}//view Controller ended

//**************** Extension ********************

extension ViewController:iCarouselDataSource{
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return self.catWise.count
    }
 

    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
       
        let tempView = QuoteCard(frame: CGRect(x: 0, y: 0, width: 250, height: 350))

        if self.categoryRecieved == "" {
        tempView.setupCard(quote: (self.quotes[index].thought?.quote) ?? "Umer", author: (self.quotes[index].thought?.thoughtAuthor?.name)?.capitalized ?? "Umer", theme: (self.quotes[index].thought?.thoughtThemes?.first?.name)?.capitalized ?? "Umer")
        } else {
        tempView.setupCard(quote: (self.catWise[index].thoughtStream?.thoughts?.first?.quote) ?? "Rafay", author: (self.catWise[index].thoughtStream?.thoughts?.first?.thoughtAuthor?.name) ?? "Rafay", theme: (self.catWise[index].thoughtStream?.thoughts?.first?.thoughtThemes?.first?.name) ?? "Rafay")
        }
    
//<<<<<<< HEAD
//        if(self.quotes[index].thought?.thoughtAuthor?.image != nil){
//
//            let s = self.quotes[index].thought?.thoughtAuthor?.image ?? ""
//
//            let url = URL(string: "https://i.forbesimg.com/media/lists/quotebank/\(s)_100x100.jpg")
//            tempView.authorImage.kf.setImage(with: url)
//
//            print("bhai ye nil nhi hain \((self.quotes[index].thought?.thoughtAuthor?.image ?? ""))")
//
////            let s = self.quotes[index].thought?.thoughtAuthor?.image ?? ".
////
////            Alamofire.request("https://i.forbesimg.com/media/lists/quotebank/\(s)_100x100.jpg").responseImage { response in
////                debugPrint(response)
////                if let image = response.result.value {
////                    tempView.setupImage(image: image)
////                }
////            }
//            }
//
////=======
//
//>>>>>>> 8a8f0a75f1e41ea2794500271879dfe158874a39
        return tempView
    }
    
//     else {
//
//    }
    
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

