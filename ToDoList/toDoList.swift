//
//  toDoList.swift
//  ToDoList
//
//  Created by Harry DeCecco (student HH) on 2/21/20.
//  Copyright © 2020 Bigham, Elijah. All rights reserved.
//

import Foundation
import UIKit

struct ToDo{
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
}
class toDoList: UITableViewController {
    var toDos = [ToDo]()
    
    override func tableView(_ tableView: UITableView, cellForRowAt
    indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
        "ToDoCellIdentifier", for: indexPath)
        
        let todo = toDos[indexPath.row]
        cell.textLabel?.text = todo.title
        return cell
    }
    override func tableView(_ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedToDos = toDoList.loadToDos(){
            toDos = savedToDos
        } else {
            toDos = toDoList.loadSampleToDos()
        }
    }
    static func loadToDos() -> [ToDo]? {
        return nil
    }
    static func loadSampleToDos() -> [ToDo]{
        let todo1 = ToDo(title: "ToDo One", isComplete: false, dueDate: Date(), notes: "Notes 1")
        
        let todo2 = ToDo(title: "ToDo Two", isComplete: false, dueDate: Date(), notes: "Notes 2")
        
        let todo3 = ToDo(title: "ToDo Three", isComplete: false, dueDate: Date(), notes: "Notes 3")
        
            return [todo1, todo2, todo3]
    }

    

    
    

    
}
