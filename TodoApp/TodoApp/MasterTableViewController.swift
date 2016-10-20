//
//  MasterTableViewController.swift
//  TodoApp
//
//  Created by William Smith on 10/15/16.
//  Copyright © 2016 William Smith. All rights reserved.
//
// Things that still need to be done:
// - Add persistent storage, which should load the completed amount and the
//   to do items when app is reloaded (should be done in viewDidLoad)
// - Do autolayout

import UIKit

struct toDoItem {
    var item : String
    var checked : Bool
    var date : Date?
}

var toDoItems : [toDoItem] = []
var doneCount = 0

class MasterTableViewController: UITableViewController {
    
    var newTask : String? // for temporary transfer of new tasks via segue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if newTask != nil {
            let newItem = toDoItem(item: newTask!, checked: false, date: nil)
            toDoItems.append(newItem)
            self.tableView.reloadData()
            print(toDoItems)
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
        var purgedList : [toDoItem] = []
        
        for i in 0..<toDoItems.count {
            let item = toDoItems[i]
            
            if let date = item.date {
                let lifetime = Date().timeIntervalSince(date)
                if lifetime > (3600 * 24) { // do not add item to purgedList
                    print("lifetime = \(lifetime). Max lifetime = 10")
                    print(toDoItems)
                } else {
                    purgedList.append(item)
                    print("Item not yet at the limit. Date = \(item.date)")
                }
            } else {
                purgedList.append(item)
                print("Item not yet checked. Date = \(item.date)")
            }
        }
        
        toDoItems = purgedList
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        let cellData = toDoItems[indexPath.row]
        cell.textLabel?.text = cellData.item
        
        if cellData.checked == true {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = self.tableView.cellForRow(at: indexPath) {
            //tableView.deleteRows(at: [indexPath], with: .fade)
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none // undo the checkmark
                toDoItems[indexPath.row].checked = false
                toDoItems[indexPath.row].date = nil
                print("Item unchecked, date reset. Date = \(toDoItems[indexPath.row].date)")
                doneCount -= 1
            } else {
                cell.accessoryType = .checkmark
                toDoItems[indexPath.row].checked = true
                toDoItems[indexPath.row].date = Date()
                print("Item checked, date set. Date = \(toDoItems[indexPath.row].date)")
                doneCount += 1
            }
        }
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoItems.remove(at: indexPath.row) // remove from to do list
            tableView.deleteRows(at: [indexPath], with: .fade) // remove from table
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // this assumes that the destination is indeed the stats view controller
        // Needs to be fixed
        if segue.identifier == "showStatsSegue" && doneCount != 0 {
            let statView = segue.destination as! StatsViewController
            
            let statLabelUpdate = String(doneCount)
            //print("stat label value: \(statLabelUpdate) ")
            //print(statView.statLabel.text)
            statView.newStats = statLabelUpdate
            print(statLabelUpdate)
        }
    }
    
}
