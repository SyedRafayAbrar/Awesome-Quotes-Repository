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
    
    var helper = Helper()
    
    
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
<<<<<<< HEAD
=======
  
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Categories"
    }
>>>>>>> 8a8f0a75f1e41ea2794500271879dfe158874a39
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCell
        cell.textLabel?.text = categoriesArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Avenir", size: 15)
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = table.cellForRow(at: indexPath)
        
        helper.ItemName =  selectedCell?.textLabel?.text
        
        performSegue(withIdentifier: "CategorySegue", sender: indexPath.row)
        
        
        
    }
    
   
    
}
