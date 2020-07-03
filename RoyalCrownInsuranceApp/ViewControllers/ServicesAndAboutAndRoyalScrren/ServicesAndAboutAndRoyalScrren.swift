//
//  ServicesAndAboutAndRoyalScrren.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 24.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit
import SafariServices
final class ServicesAndAboutAndRoyalScrren: CustomNaviationBarViewController {
    
    //MARK: - Variable
    var screenName: String?
    private var screenImage: [String] = []
    private var screenTitle: [String] = []
    private var dataScreen = DataManager.shared
    
    //MARK: - @IBOutlet
    @IBOutlet weak private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "AboutTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let key = screenName else { return }
        screenImage = dataScreen.screen[key]!
        screenTitle = dataScreen.titleScreen[key]!
    }
    
    private func goToTheServiceScreen(indexPath: IndexPath, nameScrren: String) {
        if screenName == "SERVICES" {
            title = "Servicess"
            let vc = storyboard?.instantiateViewController(withIdentifier: "ServicessViewController") as! ServicessViewController
            vc.type = screenTitle[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func goToTheBranchesScreen(indexPath: IndexPath, nameScrren: String) {
        if screenName == "ABOUT" {
            title = "About" 
            switch indexPath.row {
            case 0:
                let vc = storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
                vc.nameScrren = "AboutUs"
                navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = storyboard?.instantiateViewController(withIdentifier: "BranchesViewController") as! BranchesViewController
                navigationController?.pushViewController(vc, animated: true)
            case 2:
                let url = URL(string: "http://cw.royalcrowninsurance.eu/Login.aspx?ReturnUrl=%2f")
                let svc = SFSafariViewController(url: url!)
                present(svc, animated: true, completion: nil)
            default:
                break
            }
        }
    }
    
    private func goToTheRoyalAssistScreen(indexPath: IndexPath, nameScrren: String) {
        if screenName == "ROYAL ASIST" {
            switch indexPath.row {
            case 0:
                let vc = storyboard?.instantiateViewController(withIdentifier: "ReportAnAccidentViewController") as! ReportAnAccidentViewController
                navigationController?.pushViewController(vc, animated: true)
            case 1:
                let url = URL(string: "tel://77777773")
                guard let url1 = url, UIApplication.shared.canOpenURL(url1) else { return }
                UIApplication.shared.open(url1)
            case 2:
                let vc = storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
                navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension ServicesAndAboutAndRoyalScrren: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return screenImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutTableViewCell", for: indexPath) as! AboutTableViewCell
        cell.aboutImageView.image = UIImage(named: screenImage[indexPath.row])
        cell.aboutTitleLabel?.text = screenTitle[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenCount = CGFloat(screenImage.count)
        return tableView.frame.height / screenCount - 10.0
    }
}

//MARK: - UITableViewDelegate
extension ServicesAndAboutAndRoyalScrren: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToTheServiceScreen(indexPath: indexPath, nameScrren: screenName!)
        goToTheRoyalAssistScreen(indexPath: indexPath, nameScrren: screenName!)
        goToTheBranchesScreen(indexPath: indexPath, nameScrren: screenName!)
        
    }
}
