//
//  QuestionnairesViewController.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 24.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

final class QuestionnairesViewController: CustomNaviationBarViewController {
    //MARK: Variables
    private let network = NetworkDataFetcher()
    private var dataSourse: [Questionnaire] = []
    var id = Int()
    
    
    //MARK: - @IBOutlet
    @IBOutlet weak private var tableView: UITableView!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Questionnaires"
        tableView.register(UINib(nibName: "QuestionnairesTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionnairesTableViewCell")
        dataRetrieval()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func dataRetrieval() {
        let urlString = "http://31.131.21.105:82/api/v1/questionnaires"
        network.fetchQuestionnaire(urlString: urlString) {[weak self] (qest) in
            guard let qest = qest else { return }
            self?.dataSourse = qest
            self?.tableView.reloadData()
        }
    }
}

//MARK: - UITableViewDataSource
extension QuestionnairesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionnairesTableViewCell", for: indexPath) as! QuestionnairesTableViewCell
        cell.nameQuestionnaires.text = dataSourse[indexPath.row].title
        cell.discriptionLabel.text = dataSourse[indexPath.row].description
        let key: Int? = indexPath.row + 1
        let indexCell: Int? = key! - 1
        
        let estimation = UserDefaults.standard.string(forKey: "\(key!)")
        if indexCell == indexPath.row {
            if let es = estimation {
                cell.heightConstraint.constant = 20
                cell.estimationLabel.text = es
            }
        }
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension QuestionnairesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        id = indexPath.row + 1
        let vc = storyboard?.instantiateViewController(withIdentifier: "QuestViewController") as! QuestViewController
        vc.id = id
        vc.title = dataSourse[indexPath.row].title?.capitalizingFirstLetter()
        navigationController?.pushViewController(vc, animated: true)
    }
}
