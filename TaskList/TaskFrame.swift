//
//  TaskFrame.swift
//  TaskList
//
//  Created by Chris Allen on 2/14/18.
//  Copyright © 2018 Chris Allen. All rights reserved.
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
