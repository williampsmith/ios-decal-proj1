//
//  AddViewController.swift
//  TodoApp
//
//  Created by William Smith on 10/15/16.
//  Copyright © 2016 William Smith. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let nav = segue.destination as! UINavigationController
        let listView = nav.topViewController as! MasterTableViewController
        
        if titleTextField.text != "" { // don't push empty text fields
            listView.newTask = titleTextField.text
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let nav = segue.destination as! UINavigationController
//        let tvc = nav.topViewController as! TaskViewController
//        
//        tvc.task = textField.text
//    }

}





