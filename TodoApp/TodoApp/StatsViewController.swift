//
//  StatsViewController.swift
//  TodoApp
//
//  Created by William Smith on 10/15/16.
//  Copyright © 2016 William Smith. All rights reserved.
//

import UIKit


class StatsViewController: UIViewController {
    var newStats : String?
    @IBOutlet weak var statLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if newStats != nil {
            statLabel.text = newStats
        }
        
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
