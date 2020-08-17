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

//    @IBOutlet weak var button: UIButton!
//    
//    @IBAction func buttonPushed(_ sender: UIButton) {
//        buttonPush = !buttonPush
//        if buttonPush {
//            button.setImage(UIImage(named: "checkmark.circle.png"), for: .normal)
//        } else {
//            button.setImage(UIImage(named: "circle.png"), for: .normal)
//        }
    }
    
}
