//
//  MenuViewController.swift
//  QuotesCollection
//
//  Created by Syed Rafay on 1/11/18.
//  Copyright © 2018 Syed Rafay. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate : class {
    func clickItem(category: String)
}


class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var table: UITableView!
    weak var delegate : MenuViewControllerDelegate?
    
    //    var listener:ClickDelegate?
    
    var text:String = ""
    
    var categoriesArray = ["Self","Best","Emotions","Life","Justice","Wealth","Laughter","Anger","Art","Executives","Power","Education","Wisdom","Greatness","Busy","Criticism","Courage","Blessings","Trust","Tragedy","Sorrow","War","Action","Aging","Man","Politics","Ability","Virtue","Goals","Riches","Achievements","Pleasure","Animals","Mistakes","Money","Women","Peace","Religion"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoriesArray.sort()
        table.backgroundColor = UIColor.clear
        table.backgroundView = nil
        table.separatorStyle = .singleLineEtched
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Categories"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.textColor = UIColor(hex: "6EB79B")
        cell.textLabel?.text = categoriesArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Avenir", size: 15)
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "homeViewController") as! ViewController
        mainVC.categoryRecieved = categoriesArray[indexPath.row]
//        show(mainVC, sender: self)
        
        self.delegate?.clickItem(category: categoriesArray[indexPath.row])
        
        self.slideMenuController()?.closeLeft()
        
//        self.slideMenuController()?.changeMainViewController(mainVC, close: true)
        
        
        
        
        //     performSegue(withIdentifier: "home", sender: self)
        
        //        if(self.listener != nil){
        //            self.listener?.clickItem(category: categoriesArray[indexPath.row])
        //        }
        
        //        self.slideMenuController()
        
        
    }
    //    Segue Recieved
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "home" {
    //            if let indexPath = self.table.indexPathForSelectedRow {
    //                let controller = segue.destination as! ViewController
    //                controller.categoryRecieved = categoriesArray[indexPath.row]
    //            }
    //        }
    //    }
    
    //    func setListener(listener:ClickDelegate){
    //        self.listener = listener
    //    }
    
    
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}


