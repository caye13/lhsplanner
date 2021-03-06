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
    
    var buttonPush: Bool = true
    
    @IBOutlet weak var completeButton: UIButton!
    // find an alternative for inout swift
    //put button push Bool in parameter
    @IBAction func completeButtonPushed(_ sender: UIButton) {
        buttonPush = !buttonPush
        if buttonPush {
            completeButton.setImage(UIImage(named: "button_complete_solid"), for: .normal)
            
            CoreDataHelper.saveCompleteButton()
        } else {
            completeButton.setImage(UIImage(named: "button_complete_outline"), for: .normal)
            
            CoreDataHelper.saveCompleteButton()
        }
    }
}
