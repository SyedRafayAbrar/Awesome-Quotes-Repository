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
import GoogleMobileAds

protocol ViewControllerDelegate : class {
    func ViewControllerDidShowUp()
}

class ViewController: UIViewController, iCarouselDelegate {
    
    //admob
    @IBOutlet weak var bannerView: GADBannerView!
    
//    var bannerView: GADBannerView!
    
    var menuselect = ""
    var categoryRecieved:String = ""
    var catQuoteObj = [QuoteCard]()
    
    weak var delegate:MenuViewController!
    
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var viewTrailing: NSLayoutConstraint!
    @IBOutlet weak var viewLeading: NSLayoutConstraint!
    @IBOutlet var viewCarousel: iCarousel!
    @IBOutlet weak var menu: UIButton!
    
    var quotesImage = [UIImage]()
    var quotes = [QuoteItem]()
    var catWise=[BaseClass]()
    
    //DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData()
        viewCarousel.type = .invertedWheel
        currentLabel.text = categoryRecieved
        print("******************\(categoryRecieved)")
        
        // In this case, we instantiate the banner with desired ad size.
//        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        
//        addBannerViewToView(bannerView)
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    @IBAction func menu_pressed(_ sender: Any) {
        self.slideMenuController()?.openLeft()
        dismiss(animated: true, completion: nil)
        
//        self.slideMenuController().
        
//        if categoryRecieved != ""{
//            categoryRecieved = ""
//        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // DOWNLOADING DATA
    
    func getURL_s(url:String, param: [String:Any]){
        Alamofire.request(url, parameters: param).responseObject { (response: DataResponse<BaseClass>) in
            
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
                
                getURL(url: "https://www.forbes.com/forbesapi/thought/uri.json", param: ["enrich": "false", "query": randomValue])
                
                        }// For loop Ending
        } else {
            for _ in 0...49 {
                let randomValue = arc4random_uniform(50)
                
                
                getURL_s(url: "https://www.forbes.com/forbesapi/thought/get.json?", param: ["limit":100,"meta":true,"start":randomValue, "stream":true,"themeuri":"\(self.categoryRecieved.lowercased())"])
                print("++++Else++")
                
                
            }
        }
        
    }//Download data function Ended
    
   
    
  
    
}//view Controller ended

//**************** Extension ********************

extension ViewController:iCarouselDataSource{
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        if self.categoryRecieved == "" {
            return self.quotes.count
            
        } else {
            return self.catWise.count
            
        }
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
    
}



//END OF VIEW CONTROLLER

