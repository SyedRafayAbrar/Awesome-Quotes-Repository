//
//  categoryTableViewCell.swift
//  QuotesCollection
//
//  Created by Syed  Rafay on 21/01/2018.
//  Copyright © 2018 z. All rights reserved.
//

import UIKit

class categoryTableViewCell: UITableViewCell {

    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var blur: UIVisualEffectView!
    override func awakeFromNib() {
        super.awakeFromNib()
        blur.layer.cornerRadius = 20
    
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
