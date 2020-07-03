//
//  ServiceDescriptionViewController.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 24.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit
import SafariServices

final class ServiceDescriptionViewController: CustomNaviationBarViewController {
    var service: Services?
    
    //MARK: - @IBOutlet
    @IBOutlet weak var serviceDescriptionTextView: UITextView!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceDescriptionTextView.text = service?.description.htmlToString
        title = service?.title
    }
    
    
    
    //MARK: - @IBAction
    @IBAction func goToTheWebsite(_ sender: UIButton) {
        let url = URL(string: service!.website)
        let svc = SFSafariViewController(url: url!)
        present(svc, animated: true, completion: nil)
    }
}
