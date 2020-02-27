//
//  TableViewControllerSub.swift
//  ToDoList
//
//  Created by Harry DeCecco (student HH) on 2/27/20.
//  Copyright © 2020 Bigham, Elijah. All rights reserved.
//

import Foundation
import UIKit


class TableViewControllerSub: UITableViewController {
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    var isPickerHidden = true
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesTextViewIndexPath = IndexPath(row: 0, section: 2)
    let normalCellHeight: CGFloat = 44
    let largeCellHeight: CGFloat = 200
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var dueDatePickerView: UIDatePicker!
    @IBOutlet var notesTextView: UITextView!
    var todo: ToDo?
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func prepare(for segue: UIStoryboardSegue, sender:
    Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else { return }
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        todo = ToDo(title: title, isComplete: isComplete, dueDate:
        dueDate, notes: notes)
        
    }
    
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = todo {
          navigationItem.title = "To-Do"
          titleTextField.text = todo.title
          isCompleteButton.isSelected = todo.isComplete
          dueDatePickerView.date = todo.dueDate
          notesTextView.text = todo.notes
        } else {
          dueDatePickerView.date =
          Date().addingTimeInterval(24*60*60)
        }
    
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
    }
   
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    @IBAction func returnPressed(_ sender: Any) {
        titleTextField.resignFirstResponder()
    }
    @IBAction func isCompleteButtoneTapped(_ sender: Any) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = TableViewControllerSub.dueDateFormatter.string(from: date)
    }
    @IBAction func datePIckerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt
    indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath:
            return isPickerHidden ? 0 :
            dueDatePickerView.frame.height
        case notesTextViewIndexPath:
            return largeCellHeight
        default:
            return normalCellHeight
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt
    indexPath: IndexPath) {
        if indexPath == dateLabelIndexPath {
            isPickerHidden = !isPickerHidden
            dueDateLabel.textColor = isPickerHidden ? .black :
            tableView.tintColor
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    
    
}
