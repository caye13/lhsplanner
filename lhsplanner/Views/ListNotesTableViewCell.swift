//
//  ListNotesTableViewCell.swift
//  lhsplanner
//
//  Created by Caye on 8/13/20.
//  Copyright © 2020 caye. All rights reserved.
//

import UIKit

class ListNotesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var noteModificationTimeLabel: UILabel!
    
    var buttonPush:Bool = true
    
    @IBOutlet weak var completeButton: UIButton!
    @IBAction func completeButtonPushed(_ sender: UIButton) {
        buttonPush = !buttonPush
        if buttonPush {
            completeButton.setImage(UIImage(named: "checkmark.circle"), for: .normal)
        } else {
            completeButton.setImage(UIImage(named: "circle"), for: .normal)
        }
    }
    
    
//put button here functions in the controller
    
}
