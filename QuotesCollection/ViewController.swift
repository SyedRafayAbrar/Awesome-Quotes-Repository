//
//  ViewController.swift
//  QuotesCollection
//
//  Created by Syed Rafay on 1/9/18.
//  Copyright © 2018 Syed Rafay. All rights reserved.
//

import UIKit

class ViewController: UIViewController,iCarouselDataSource,iCarouselDelegate {
    var quotesmenuIsVisible = false
    @IBOutlet weak var ubeView: UIView!
    @IBOutlet weak var viewTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var viewLeading: NSLayoutConstraint!
    
    @IBOutlet var viewCarousel: iCarousel!
    @IBOutlet weak var menu: UIButton!
var quotesImage = [UIImage]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        ubeView.isHidden = true
        viewCarousel.type = .invertedWheel
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func menu_button_Pressed(_ sender: Any) {

        if ubeView.isHidden{
                        viewLeading.constant = 0
                        viewTrailing.constant = 150
                        ubeView.isHidden = false
                    } else {
                        viewLeading.constant = 0
                        viewTrailing.constant = 0
                        ubeView.isHidden = true
                    }
            
                    UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn, animations: {self.view.layoutIfNeeded()}) {
                        (animationComplete) in
                        print("Animation is complete")
                    }

            
        //        if ubeView.isHidden == true {
//           ubeView.isHidden = false
//        } else {
//            ubeView.isHidden = true
//        }
    }
 
    
        
//        if ubeView.isHidden{
//            viewLeading.constant = 150
//            viewTrailing.constant = -150
//            ubeView.isHidden = false
//        } else {
//            viewLeading.constant = 0
//            viewTrailing.constant = 0
//            quotesmenuIsVisible = true
//        }
//        
//        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {self.view.layoutIfNeeded()}) {
//            (animationComplete) in
//            print("Animation is complete")
//        }

    
   

    
    override func awakeFromNib() {
        super.awakeFromNib()
        quotesImage = [#imageLiteral(resourceName: "q1"),#imageLiteral(resourceName: "q1"),#imageLiteral(resourceName: "q1")]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfItems(in carousel: iCarousel) -> Int {
        return quotesImage.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
            
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
        var newimg = quotesImage[index]
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
    
   }

