//
//  PhotoCollectionViewCell.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 25.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit
protocol PhotoCollectionViewCellDelegate {
    func didTappedCell(from: PhotoCollectionViewCell)
}
final class PhotoCollectionViewCell: UICollectionViewCell {

    var delegate: PhotoCollectionViewCellDelegate?
    //MARK: - @IBOutlet
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var delatePhotoButton: UIButton!
    
    @IBAction func delateImageButton(_ sender: UIButton) {
        delegate?.didTappedCell(from: self)
    }
    
}
