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
    @IBOutlet weak var titleLabel: UILabel!
    
    //    var bannerView: GADBannerView!
    
    var menuselect = ""
    var categoryRecieved:String = ""
    var catQuoteObj = [QuoteCard]()
    var hasAlreadyLaunchedThisController = false
    weak var delegate:MenuViewController!
    
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var viewTrailing: NSLayoutConstraint!
    @IBOutlet weak var viewLeading: NSLayoutConstraint!
    @IBOutlet var viewCarousel: iCarousel!
    @IBOutlet weak var menu: UIButton!
    
    var mytodayData : [Thoughts]?
    
    
    //    var quotesImage = [UIImage]()
    var quotes = [Thoughts]()
    //    var catWise=[Thoughts]()
    
    //DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData()
        viewCarousel.type = .invertedWheel
        viewCarousel.isPagingEnabled = true
        
//        ca-app-pub-8459509244834954/4751246966
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        
        let randomValue = arc4random_uniform(11000)
        
        getURL_s(url: "https://www.forbes.com/forbesapi/thought/get.json?", param: ["limit":200,"meta":true,"start":randomValue, "stream":true])
        
    }
    
    @IBAction func pressedHome(_ sender: Any) {
        //        dismiss(animated: true, completion: nil)
        
//        let randomValue = arc4random_uniform(11000)
//
//        getURL_s(url: "https://www.forbes.com/forbesapi/thought/get.json?", param: ["limit":200,"meta":true,"start":randomValue, "stream":true])
        
        self.titleLabel.text = "TODAY"
        
        self.quotes = mytodayData!
        viewCarousel.reloadData()
    }
    
    
    @IBAction func menu_pressed(_ sender: Any) {
        self.slideMenuController()?.openLeft()
        //        dismiss(animated: true, completion: nil)
        
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
            
            self.quotes = (response.result.value!.thoughtStream?.thoughts)!
            self.viewCarousel?.reloadData()
            if !self.hasAlreadyLaunchedThisController {
                self.hasAlreadyLaunchedThisController = true
                self.mytodayData = self.quotes
            }
            
            print("now fetching data from query \(String(describing: response.result.value!.thoughtStream?.thoughts?.first?.quote))")
            
        }
    }
    
    //    func getURL (url:String, param: [String:Any]){
    //        Alamofire.request(url, parameters: param).responseObject { (response: DataResponse<QuoteItem>) in
    //
    //            if(response.result.value?.thought?.thoughtAuthor?.image != nil){
    //
    //                self.quotes.append(response.result.value!)
    //                self.viewCarousel?.reloadData()
    //
    //                print("now fetching data from query \(String(describing: response.result.value!.thought?.quoteFragment))")
    //
    //            }
    //        }
    //    }
    
    func downloadData(){
        
//        if self.categoryRecieved == "" {
//            //            for _ in 0...100 {
//            let randomValue = arc4random_uniform(11000)
//
//            getURL_s(url: "https://www.forbes.com/forbesapi/thought/get.json?", param: ["limit":200,"meta":true,"start":randomValue, "stream":true])
//
////            self.mytodayData = quotes
//
//            //                        }// For loop Ending
//        } else {
        
            let randomValue = arc4random_uniform(10)
            
            getURL_s(url: "https://www.forbes.com/forbesapi/thought/get.json?", param: ["limit":200,"meta":true,"start":randomValue, "stream":true,"themeuri":"\(self.categoryRecieved.lowercased())"])
            //                print("++++Else++")
            
//        }
        
        
        
    }//Download data function Ended
    
    
    
    
    
}//view Controller ended

//**************** Extension ********************

extension ViewController:iCarouselDataSource{
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return self.quotes.count
    }
    
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        let tempView = QuoteCard(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
        
        tempView.setupCard(quote: (self.quotes[index].quote) ?? "Rafay", author: (self.quotes[index].thoughtAuthor?.name) ?? "Rafay", theme: (self.quotes[index].thoughtThemes?.first?.name) ?? "Rafay")
        
        
        //<<<<<<< HEAD
        //        if quotes.count != 0 {
        //                if(self.quotes[index].thought?.thoughtAuthor?.image != nil){
        //
        //                    let s = self.quotes[index].thought?.thoughtAuthor?.image ?? ""
        //
        //                    let url = URL(string: "https://i.forbesimg.com/media/lists/quotebank/\(s)_100x100.jpg")
        //                    tempView.authorImage.kf.setImage(with: url)
        //
        //                    print("bhai ye nil nhi hain \((self.quotes[index].thought?.thoughtAuthor?.image ?? ""))")
        //
        //                    }
        //        } else {
        
        if(self.quotes[index].thoughtAuthor?.image != nil){
            
            let s = self.quotes[index].thoughtAuthor?.image ?? ""
            
            let url = URL(string: "https://i.forbesimg.com/media/lists/quotebank/\(s)_100x100.jpg")
            tempView.authorImage.kf.setImage(with: url)
            
        }
        
        
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


extension ViewController : MenuViewControllerDelegate {
    
    func clickItem(category: String) {
        self.categoryRecieved = category
        downloadData()
        self.titleLabel.text = category.uppercased()
//        for i in 0...category.count{
////            category.
//        }
    }
}


//END OF VIEW CONTROLLER

