//
//  MenuViewController.swift
//  QuotesCollection
//
//  Created by Syed Rafay on 1/11/18.
//  Copyright © 2018 Syed Rafay. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var table: UITableView!
    
//    var listener:ClickDelegate?
    
    var text:String = ""
    
    var categoriesArray = ["Self","Best","Emotions","Life","Justice","Wealth","Laughter","AngerArt","Executvves","Power","Education","Wisdom","Greatness"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.backgroundColor = .clear
        table.backgroundView = nil
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
        let cell = table.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCell
        cell.textLabel?.text = categoriesArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Avenir", size: 15)
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//     performSegue(withIdentifier: "home", sender: self)
        
//        if(self.listener != nil){
//            self.listener?.clickItem(category: categoriesArray[indexPath.row])
//        }
        
        
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

protocol ClickDelegate {
    func clickItem(category: String)
}

