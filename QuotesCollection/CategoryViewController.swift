//
//  CategoryViewController.swift
//  QuotesCollection
//
//  Created by Syed  Rafay on 13/01/2018.
//  Copyright © 2018 Syed Rafay. All rights reserved.
//

import UIKit
import Alamofire

class CategoryViewController: UIViewController,iCarouselDelegate,iCarouselDataSource {
    var catCard = [CategoryCard]()
var helperClass = Helper()
    @IBOutlet weak var carousel: iCarousel!
    override func viewDidLoad() {
        super.viewDidLoad()
carousel.type = .invertedWheel
        downloadData()
        print(helperClass.ItemName)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backTomain(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)

    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 5    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
//        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
    let tempView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 350))

        tempView.backgroundColor = .red
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func downloadData(){
        
        let quotesURL = URL(string: "https://www.forbes.com/forbesapi/thought/get.json?limit=5&meta=true&start=0&stream=true&themeuri=anger")
        
        Alamofire.request(quotesURL!).responseJSON { response in
            let result = response.result
            let obj = CategoryCard()

            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let first = dict["thoughtStream"] as? Dictionary<String,AnyObject> {
                    if let grabQuote = first["thoughts"] as? [Dictionary<String,AnyObject>] {
                        if let grab = grabQuote[0] as? Dictionary<String,AnyObject> {
                            if let quote = grab["quote"] as? String {
                                obj.quote = quote
                                print(quote)
                            }
                            if let author = grab["thoughtAuthor"] as? Dictionary<String,AnyObject> {
                                if let author_name = author["name"] as? String {
                                    obj.author = author_name
                                }
                                
                            }
                            
                            if let theme = grab["thoughtThemes"] as? [Dictionary<String,AnyObject>] {
                                if let theme_name = theme[0]["name"] as? String {
                                    obj.theme = theme_name
                                }
                                
                            }
                            
                        }
                    }
                    
                }
            }
            
            self.catCard.append(obj)

        }


    }// downloadData ending

}
