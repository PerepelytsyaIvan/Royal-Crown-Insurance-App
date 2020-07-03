//
//  AboutUsViewController.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 27.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

final class AboutUsViewController: CustomNaviationBarViewController {
    
    //MARK: - Variables
    private let network = NetworkDataFetcher()
    var nameScrren: String?
    
    //MARK: - @IBOutlet
    @IBOutlet weak private var detailTextView: UITextView!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About us"
        loadData()
    }
    
    //MARK: - Methods
    private func loadData() {
        var url = String()
        if nameScrren == "AboutUs" {
            url = "http://31.131.21.105:82/api/v1/about_us"
        } else {
            url = "http://31.131.21.105:82/api/v1/about_royal_assist"
        }
        network.fetchAboutUs(urlString: url) {[weak self] (text) in
            guard let text = text else { return }
            if self?.nameScrren == "AboutUs" {
                self?.detailTextView.text = text.about?.htmlToString
            } else {
                self?.detailTextView.text = text.aboutRoyalAssist?.htmlToString
            }
            
        }
    }
}

