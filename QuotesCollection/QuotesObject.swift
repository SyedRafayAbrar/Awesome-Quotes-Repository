//
//  QuotesObject.swift
//  QuotesCollection
//
//  Created by Syed Rafay on 1/10/18.
//  Copyright © 2018 Syed Rafay. All rights reserved.
//

import Foundation
import RealmSwift
class Quotes : Object {
    
    @objc dynamic var message:String? = nil
    @objc dynamic var Author:String? = nil
    @objc dynamic var category:String? = nil
    
}

extension Quotes{
    func writeToRealm(){
        uiRealm.add(self)
    }
}
