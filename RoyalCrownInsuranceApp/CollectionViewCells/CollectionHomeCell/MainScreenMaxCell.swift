//
//  MainScreenMaxCell.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 23.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

final class MainScreenMaxCell: UICollectionViewCell {

    //MARK: - @IBOutlet
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - Methods
    func configureCell(index: Int) {
        switch index {
        case 0:
            imageView.image = #imageLiteral(resourceName: "imgRoyalAssist")
        case 1:
            imageView.image = #imageLiteral(resourceName: "imgRoyalPayment")
        case 2:
              imageView.image = #imageLiteral(resourceName: "imgServices")
        case 3:
            imageView.image = #imageLiteral(resourceName: "imgWhatToDoIf")
        case 4:
            imageView.image = #imageLiteral(resourceName: "imgAbout")
        case 5:
            imageView.image = #imageLiteral(resourceName: "imgServices")
        default: break
        }
    }
}
