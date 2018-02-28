//
//  TaskFrame.swift
//  TaskList
//
//  Created by Chris Allen on 2/14/18.
//  Copyright © 2018 Chris Allen. All rights reserved.
//  Model for the app, basically holds all the variables of a task
//

import Foundation

class Task{
    var name: String
    var due: Date
    var completed = false
    var notes: String?
    
    init?(name: String, completed: Bool, due:Date, notes:String?) {
        self.name = name
        self.completed = completed
        self.due = due
        self.notes = notes
    }
    
    
}
