//
//  ExpendViewController.swift
//  QuotesCollection
//
//  Created by Umer Jabbar on 17/01/2018.
//  Copyright © 2018 z. All rights reserved.
//

import UIKit

class ExpendViewController: UIViewController {
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    
    @IBAction func dragging(_ sender: UIPanGestureRecognizer) {
        
        let touchPoint = sender.location(in: self.view?.window)
        
        if sender.state == UIGestureRecognizerState.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizerState.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizerState.ended || sender.state == UIGestureRecognizerState.cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
        
    }
    
    @IBOutlet weak var labelTheme: UILabel!
    @IBOutlet weak var labelThought: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    
    var thought: Thoughts? = nil
    
    @IBAction func whenPressed(_ sender: Any) {
        
        dismiss(animated: true) {
            
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.labelTheme.text = thought?.thoughtThemes?.first?.name
        self.labelAuthor.text = thought?.thoughtAuthor?.name
        self.labelThought.text = thought?.quote
        
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

}
