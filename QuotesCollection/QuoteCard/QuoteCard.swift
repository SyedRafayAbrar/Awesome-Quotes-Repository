//
//  QuoteCard.swift
//  QuotesCollection
//
//  Created by Umer Jabbar on 11/01/2018.
//  Copyright © 2018 Syed Rafay. All rights reserved.
//

import UIKit


class QuoteCard: UIView {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    
    
    @IBOutlet var contentView: UIView!
    
    //     Only override draw() if you perform custom drawing.
//     An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
////         Drawing code
//    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        
        Bundle.main.loadNibNamed("QuoteCard", owner: self, options: nil)
        guard let content = contentView else { return }
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        self.addSubview(content)
    }
    
    
    func setupCard(quote:String, author:String, theme:String){
        
        
//        UINib(nibName: "nib file name", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        
        self.authorLabel.text = author
        self.quoteLabel.text = quote
        self.themeLabel.text = theme
        
        
    }
    
    func setupImage(image: Any){
        
        self.authorImage.image = image as? UIImage
        
    }
    

}
