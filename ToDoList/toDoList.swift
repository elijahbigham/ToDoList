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

    

    
    

    
}
