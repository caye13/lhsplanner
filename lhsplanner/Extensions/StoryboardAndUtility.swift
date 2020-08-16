//
//  StoryboardAndUtility.swift
//  lhsplanner
//
//  Created by Caye on 8/13/20.
//  Copyright © 2020 caye. All rights reserved.
//

import UIKit

extension UIStoryboard {
    enum StoryType: String {
        case main
        case login

        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(type: StoryType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    
    // way of setting initial viewcontroller for users
    static func initialViewController(for type: StoryType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial view controller for \(type.filename) storyboard.")
        }

        return initialViewController
    }
}
