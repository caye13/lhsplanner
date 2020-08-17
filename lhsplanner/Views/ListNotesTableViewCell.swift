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
    
    @IBOutlet weak var button: UIButton!
//    {
//        didSet{
//        let image = UIImage(named: imageColor[randNum])
//        tapButton.setImage(image, forState: UIControlState.Normal)
//        }
//    }
    
    @IBAction func buttonPushed(_ sender: UIButton) {
    }
    
}
