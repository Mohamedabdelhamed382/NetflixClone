//
//  Extension.swift
//  NetflixClone
//
//  Created by MOHAMED ABD ELHAMED AHMED on 26/03/2022.
//

import Foundation
import UIKit

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

extension UIViewController {
    var isDarkMode: Bool {
        if #available(iOS 13.0, *) {
            return self.traitCollection.userInterfaceStyle == .dark
        }
        else {
            return false
        }
    }

}

enum ColorCompatibility {
    static func myOlderiOSCompatibleColorName(darkMode: UIColor , lightMode: UIColor) -> UIColor {
        if UIViewController().isDarkMode {
            return darkMode
        }
        else {
            return lightMode
        }
    }
}
