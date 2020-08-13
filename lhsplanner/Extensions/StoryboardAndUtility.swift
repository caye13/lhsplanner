//
//  StoryboardAndUtility.swift
//  lhsplanner
//
//  Created by Caye on 8/13/20.
//  Copyright © 2020 caye. All rights reserved.
//

import UIKit

extension UIStoryboard {
    enum LHSType: String {
        case main
        case login

        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(type: LHSType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    
    static func initialViewController(for type: LHSType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial view controller for \(type.filename) storyboard.")
        }

        return initialViewController
    }
}
