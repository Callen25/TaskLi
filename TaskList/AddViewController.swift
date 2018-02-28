//
//  AddViewController.swift
//  TaskList
//
//  Created by Chris Allen on 2/24/18.
//  Copyright © 2018 Chris Allen. All rights reserved.
//

import UIKit
import os.log

class AddViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet var taskDescription: UITextView!
    @IBOutlet var taskName: UITextField!
    @IBOutlet var taskIsDone: UISwitch!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var datePicker: UIDatePicker!
    
    var addTask: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.taskName.delegate = self

        // Do any additional setup after loading the view.
        saveButton.isEnabled = false
        taskIsDone.isOn = false
        taskDescription.layer.borderWidth = 0.5
        taskDescription.layer.borderColor = UIColor.lightGray.cgColor
        taskDescription.layer.cornerRadius = 5
        

    }
    
    //Enable saveButton once a taskName has been entered
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !saveButton.isEnabled{
            saveButton.isEnabled = true;
        }
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
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = taskName.text;
        let completed = taskIsDone.isOn;
        let due = datePicker.date;
        let notes = taskDescription.text
        
        addTask = Task(name: name!, completed: completed, due: due, notes: notes)
    }
    

}
