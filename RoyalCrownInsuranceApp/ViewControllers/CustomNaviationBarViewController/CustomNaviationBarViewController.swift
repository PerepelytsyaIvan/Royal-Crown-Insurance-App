//
//  CustomNaviationBarViewController.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 27.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

class CustomNaviationBarViewController: UIViewController {

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icIconRed"), style: .plain, target: self, action: #selector(backToRoot))
        backButton.tintColor = .red
        navigationItem.rightBarButtonItem = backButton
        let image = #imageLiteral(resourceName: "icBack").tinted(with: .purple)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(backButtonPop))
    }
    //MARK: - Methods
    @objc func backToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    @objc func backButtonPop() {
        navigationController?.popViewController(animated: true)
    }
}
