//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Harry DeCecco (student HH) on 2/27/20.
//  Copyright © 2020 Bigham, Elijah. All rights reserved.
//

import UIKit
protocol ToDoCellDelegate: class {
    func checkmarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell {
    weak var delegate: ToDoCellDelegate?
    
    @IBOutlet weak var isCompleteButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func completeButtonPressed(_ sender: Any) {
         delegate?.checkmarkTapped(sender: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
