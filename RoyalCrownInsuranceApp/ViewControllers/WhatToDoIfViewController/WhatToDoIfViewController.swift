//
//  WhatToDoIfViewController.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 24.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

final class WhatToDoIfViewController: CustomNaviationBarViewController {
    //MARK: - Variables
    private var dataSource: [Instruction] = []
    
    //MARK: - @IBOutlet
    @IBOutlet weak private var tableView: UITableView!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        dataRetrieval()
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "WhatToDoIfTableViewCell", bundle: nil), forCellReuseIdentifier: "WhatToDoIfTableViewCell")
    }
    
    //MARK: - Method
    private func dataRetrieval() {
        let urlString = "http://31.131.21.105:82/api/v1/accident_instructions?sort_column=title&sort_type=asc&"
        let networkDataFeatcher = NetworkDataFetcher()
        networkDataFeatcher.fetchInstruction(urlString: urlString, response: {[weak self] (instructions) in
            guard let instructions = instructions else { return }
            self?.dataSource = instructions
            self?.tableView.reloadData()
        })
    }
}

//MARK: - UITableViewDataSource
extension WhatToDoIfViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhatToDoIfTableViewCell", for: indexPath) as! WhatToDoIfTableViewCell
        cell.titleLabel.text = dataSource[indexPath.row].instructionsTitle
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension WhatToDoIfViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "InstructionViewController") as! InstructionViewController
        vc.instruction = dataSource[indexPath.row]
        vc.title = dataSource[indexPath.row].instructionsTitle.capitalizingFirstLetter()
        navigationController?.pushViewController(vc, animated: true)
    }
}
