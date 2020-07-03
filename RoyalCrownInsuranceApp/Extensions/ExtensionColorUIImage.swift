//
//  ExtensionColorUIImage.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 02.07.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.


import Foundation
import UIKit
extension UIImage {
    func tinted(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        color.set()
        withRenderingMode(.alwaysTemplate)
            .draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
