//
//  toDoList.swift
//  ToDoList
//
//  Created by Harry DeCecco (student HH) on 2/21/20.
//  Copyright © 2020 Bigham, Elijah. All rights reserved.
//

import Foundation
import UIKit

struct ToDo: Codable {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static let DocumentsDirectory =
    FileManager.default.urls(for: .documentDirectory,
    in: .userDomainMask).first!
    
    static let ArchiveURL =
    DocumentsDirectory.appendingPathComponent("todos")
       .appendingPathExtension("plist")
    
    static func saveToDos(_ todos: [ToDo]){
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
    static func loadToDos() -> [ToDo]? {
         guard let codedToDos = try? Data(contentsOf: ArchiveURL)
              else {return nil}
            let propertyListDecoder = PropertyListDecoder()
            return try? propertyListDecoder.decode(Array<ToDo>.self,
              from: codedToDos)

    }
    
    
}
class toDoList: UITableViewController, ToDoCellDelegate {
    var toDos = [ToDo]()
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt
    indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit
    editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath:
    IndexPath) {
        if editingStyle == .delete {
            toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ToDo.saveToDos(toDos)
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt
    indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier:
//        "ToDoCellIdentifier", for: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
        "ToDoCellIdentifier") as? ToDoCell else {
            fatalError("Could not dequeue a cell")
        }
       
        
        let todo = toDos[indexPath.row]
        cell.titleLabel?.text = todo.title
        cell.isCompleteButton.isSelected = todo.isComplete
        cell.delegate = self
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedToDos = ToDo.loadToDos(){
            toDos = savedToDos
        } else {
            toDos = toDoList.loadSampleToDos()
        }
        navigationItem.leftBarButtonItem = editButtonItem

    }
    
    static func loadSampleToDos() -> [ToDo]{
        let todo1 = ToDo(title: "ToDo One", isComplete: false, dueDate: Date(), notes: "Notes 1")
        
        let todo2 = ToDo(title: "ToDo Two", isComplete: false, dueDate: Date(), notes: "Notes 2")
        
        let todo3 = ToDo(title: "ToDo Three", isComplete: false, dueDate: Date(), notes: "Notes 3")
        
            return [todo1, todo2, todo3]
    }
    
    

    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
            let sourceViewController = segue.source as!
            TableViewControllerSub
        
            if let todo = sourceViewController.todo {
                if let selectedIndexPath =
                tableView.indexPathForSelectedRow {
                    toDos[selectedIndexPath.row] = todo
                    tableView.reloadRows(at: [selectedIndexPath],
                    with: .none)
                } else {
                    let newIndexPath = IndexPath(row: toDos.count,
                    section: 0)
                    toDos.append(todo)
                    tableView.insertRows(at: [newIndexPath],
                    with: .automatic)
                }
            }
        ToDo.saveToDos(toDos)
    }
    override func prepare(for segue: UIStoryboardSegue, sender:
    Any?) {
        if segue.identifier == "EditToDo",
            let navController = segue.destination as?
            UINavigationController,
            let todoDetailTableViewController =
            navController.topViewController as?
            TableViewControllerSub {
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedToDo = toDos[indexPath.row]
            todoDetailTableViewController.todo = selectedToDo
        }
    }
    func checkmarkTapped(sender: ToDoCell){
        if let indexPath = tableView.indexPath(for: sender) {
                var todo = toDos[indexPath.row]
                todo.isComplete = !todo.isComplete
                toDos[indexPath.row] = todo
                tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(toDos)
            }
        
    }

    
    

    
}
