//
//  ExtensionTextField.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 02.07.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import Foundation
import UIKit
extension UITextField {
    func placeholderColor(color: UIColor) {
        let attributeString = [
            NSAttributedString.Key.foregroundColor: color.withAlphaComponent(0.6),
            NSAttributedString.Key.font: self.font!
            ] as [NSAttributedString.Key : Any]
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: attributeString)
    }
}
