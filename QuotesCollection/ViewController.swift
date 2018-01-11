//
//  ViewController.swift
//  QuotesCollection
//
//  Created by Syed Rafay on 1/9/18.
//  Copyright © 2018 Syed Rafay. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController,iCarouselDataSource,iCarouselDelegate {
    var q_Name:String = ""
    var a_Name:String = ""
    var c_Name:String = ""
    var quotesmenuIsVisible = false
    @IBOutlet weak var viewTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var viewLeading: NSLayoutConstraint!
    
    @IBOutlet var viewCarousel: iCarousel!
    @IBOutlet weak var menu: UIButton!
var quotesImage = [UIImage]()
   
    //DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
    downloadData()
        viewCarousel.type = .invertedWheel

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func menu_pressed(_ sender: Any) {
        
         self.slideMenuController()?.openLeft()
    }
    
    
//    @IBAction func menu_button_Pressed(_ sender: Any) {
//
//        if ubeView.isHidden{
//                        viewLeading.constant = 0
//                        viewTrailing.constant = 150
//                        ubeView.isHidden = false
//                    } else {
//                        viewLeading.constant = 0
//                        viewTrailing.constant = 0
//                        ubeView.isHidden = true
//                    }
//            
//                    UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn, animations: {self.view.layoutIfNeeded()}) {
//                        (animationComplete) in
//                        print("Animation is complete")
//                    }
//
//            
//
//    }
 
    
//    func setupSlideMenuController() {
//        
//        self.slideMenuController()?.removeLeftGestures()
//        
//    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        quotesImage = [#imageLiteral(resourceName: "q1"),#imageLiteral(resourceName: "q1"),#imageLiteral(resourceName: "q1")]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // CAROUSELS BEGIN
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return quotesImage.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
            
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
        let newimg = quotesImage[index]
        button.setImage(newimg, for: .normal)
        tempView.addSubview(button)
        return tempView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.spacing{
            return value*1.2
        } else if option == iCarouselOption.arc{
            return value*(-0.1)
        }
    return value
    }
    
    // DOWNLOADING DATA
    
    func downloadData(){
for _ in 0...4 {
        let randomValue = arc4random_uniform(11000)
        let quotesURL = URL(string: "https://www.forbes.com/forbesapi/thought/uri.json?enrich=false&query=\(randomValue)")
        
        
        
        Alamofire.request(quotesURL!).responseJSON { response in
            
            let realmObj = Quotes()
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let  secondDict = dict["thought"] as? Dictionary<String, AnyObject> {
                    
                    if let quoteMessage = secondDict["quote"] as? String {
                        
                        realmObj.message = quoteMessage
                        
                        print(quoteMessage)
                        
                        
                        
                    }
                    
                    if let natural_id = secondDict["naturalId"] as? String {
                        
                        realmObj.natural_ID = natural_id
                        
                        print(natural_id)
                        
                        
                        
                    }

                    
                    if let authorGrab = secondDict["thoughtAuthor"] as? Dictionary<String,String> {
                        
                        if let authorName = authorGrab["name"]{
                            
                            print(authorName)
                            
                            realmObj.Author = authorName
                            
                        }
                        
                        
                        
                    }
                    
                    if let categoryGrab = secondDict["thoughtThemes"] as? [Dictionary<String,String>] {
                        
                        if let categoryName = categoryGrab[0]["name"] {
                            
                            print(categoryName)
                            
                                                       realmObj.category = categoryName
                            
                        }
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                }
                
            }
            
            
            
                        realmObj.writeToRealm()
            
        }
        }// For loop Ending

    
    }//Download data function Ended
    
    
    
    }

    
    //END OF VIEW CONTROLLER

