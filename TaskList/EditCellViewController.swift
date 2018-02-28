//
//  EditCellViewController.swift
//  TaskList
//
//  Created by Chris Allen on 2/25/18.
//  Copyright © 2018 Chris Allen. All rights reserved.
//

import UIKit
import os.log

class EditCellViewController: UIViewController {
    
    var task = Task(name: "", completed: false, due: Date(), notes: "")

    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var taskName: UITextField!
    @IBOutlet var taskDescription: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var doneSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        taskName.text = task?.name
        taskDescription.text = task?.notes
        taskDescription.layer.borderWidth = 0.5
        taskDescription.layer.borderColor = UIColor.lightGray.cgColor
        taskDescription.layer.cornerRadius = 5
        datePicker.date = (task?.due)!
        doneSwitch.isOn = (task?.completed)!
        
    }

    // MARK: - Navigation
    //Hide view when cancel is pressed
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true)
    }
    //Hide keyboard when an area outside the keyboard is pressed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //Hide keyboard for ONLY the textfield when return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }

    
    // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     super.prepare(for: segue, sender: sender)
     guard let button = sender as? UIBarButtonItem, button === saveButton else {
     os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
     return
     }
     let name = taskName.text;
     let completed = doneSwitch.isOn;
     let due = datePicker.date;
     let notes = taskDescription.text
     
     task = Task(name: name!, completed: completed, due: due, notes: notes)
     }
    
    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
