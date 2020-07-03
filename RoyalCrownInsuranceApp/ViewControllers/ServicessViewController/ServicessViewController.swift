//
//  ServicessViewController.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 24.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

final class ServicessViewController: CustomNaviationBarViewController {
    
    var type: String?
    private var dataSource: [Services] = []
    private var typeRequest: String {
        if type == "BUSSINES"{
            return "business"
            
        } else {
            return "personal"
        }
    }
    
    //MARK: -  @IBOutlet
    @IBOutlet weak private var tableView: UITableView!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = type?.capitalizingFirstLetter()
        tableView.register(UINib(nibName: "ServicessTableViewCell", bundle: nil), forCellReuseIdentifier: "ServicessTableViewCell")
        tableView.tableFooterView = UIView()
        dataRetrieval()
    }
    
    private func dataRetrieval() {
        let urlString = "http://31.131.21.105:82/api/v1/services?per_page=14&service_type=\(typeRequest)&sort_column=title&"
        let networkDataFeatcher = NetworkDataFetcher()
        networkDataFeatcher.fetchServices(urlString: urlString, response: {[weak self] (services) in
            guard let services = services else { return }
            self?.dataSource = services
            self?.tableView.reloadData()
        })
    }
}

//MARK: - UITableViewDataSource
extension ServicessViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServicessTableViewCell", for: indexPath) as! ServicessTableViewCell
        cell.titleLable.text = dataSource[indexPath.row].title
        return cell
    }
}

//MARK: - UITableViewDataSource
extension ServicessViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ServiceDescriptionViewController") as! ServiceDescriptionViewController
        vc.service = dataSource[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
