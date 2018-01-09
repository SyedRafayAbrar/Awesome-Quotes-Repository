//
//  ViewController.swift
//  QuotesCollection
//
//  Created by Syed Rafay on 1/9/18.
//  Copyright © 2018 Syed Rafay. All rights reserved.
//

import UIKit

class ViewController: UIViewController,iCarouselDataSource,iCarouselDelegate {
    @IBOutlet var viewCarousel: iCarousel!
var quotesImage = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewCarousel.type = .invertedWheel
        // Do any additional setup after loading the view, typically from a nib.
    }
    
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

