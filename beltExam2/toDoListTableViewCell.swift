//
//  toDoListTableViewCell.swift
//  beltExam2
//
//  Created by Ricardo Rojas on 11/19/17.
//  Copyright © 2017 Ricardo Rojas. All rights reserved.
//

import UIKit
import CoreData

class toDoListTableViewCell: UITableViewCell {
   
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        
    }
    
    
    @IBOutlet weak var toDoItemLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
