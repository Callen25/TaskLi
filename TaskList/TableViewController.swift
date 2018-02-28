//
//  TableViewController.swift
//  TaskList
//
//  Created by Chris Allen on 2/14/18.
//  Copyright © 2018 Chris Allen. All rights reserved.
//

import UIKit
import os.log




class TableViewController: UITableViewController {
    
    
    @IBOutlet var myTableView: UITableView!
    
    var list = [Task]()
    var cellTask = Task(name: "", completed: false, due: Date(), notes: "")
    var thisCellIndex = IndexPath()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        loadInitialTasks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")

        // Configure the cell...
        cell.textLabel?.text = list[indexPath.row].name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateString = dateFormatter.string(from: (list[indexPath.row].due))
        cell.detailTextLabel?.text = dateString
        if list[indexPath.row].completed {
            cell.backgroundColor = .lightGray
            cell.detailTextLabel?.textColor = .black
        }

        return cell
    }
    
    //Adds an item to the array of tasks then updates the tableview
    func addTask( newTask: Task )
    {
        if newTask.completed {
            list.append( newTask )
        }
        else {
            var countVar = 0
            while true {
                if list[countVar].due > newTask.due || list[countVar].completed {
                    list.insert(newTask, at: countVar)
                    break
                }
                else if countVar == list.count - 1 {
                    list.append( newTask )
                    break
                }
                countVar += 1
            }
        }
        myTableView.reloadData()
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    

    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let swipeDone = UITableViewRowAction(style: .normal, title: "Done") { action, index in
            let changeCell = self.list[editActionsForRowAt.row]
            self.list.remove(at: editActionsForRowAt.row)
            changeCell.completed = !changeCell.completed
            self.addTask(newTask: changeCell)
        }
        swipeDone.backgroundColor = UIColor( red: (105.0/255.0), green: (219.0/255.0), blue: (124.0/255.0), alpha: 1.0 )

        
        return [swipeDone]
    }
    
    func loadInitialTasks()
    {
        let firstDate = Date(timeIntervalSinceNow: 99999 )
        let secondDate = Date(timeIntervalSinceNow: 828282)
        let thirdDate = Date(timeIntervalSinceNow: 287606)
        guard let placehold1 = Task(name: "Walk Dog", completed: false, due: firstDate, notes: "Once in morning, once at night")
            else {
                fatalError("Unable to instantiate placehold1")
        }
        guard let placehold2 = Task(name: "Get groceries", completed: false, due: secondDate, notes: "Keep it under 50 dollars")
            else {
                fatalError("Unable to instantiate placehold2")
        }
        guard let placehold3 = Task(name: "Do Homework", completed: true, due: thirdDate, notes: "Page 36, # 1,3,7,9")
            else {
                fatalError("Unable to instantiate placehold3")
        }
        list += [placehold1, placehold2, placehold3]
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
    
    // MARK: - Actions
    @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddViewController, let addTask =
            sourceViewController.addTask {
            self.addTask( newTask: addTask )
        }
        if let sourceViewController = sender.source as? EditCellViewController, let addTask =
            sourceViewController.task {
            list.remove(at: thisCellIndex.row )
            self.addTask( newTask: addTask )
        }
    }
    
    // MARK: - Navigation
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(list.count)
        cellTask = list[indexPath.row]
        thisCellIndex = indexPath
        performSegue(withIdentifier: "editCellSegue", sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
        if let editView = segue.destination as? EditCellViewController {
            editView.task = cellTask
        }
    }



}
