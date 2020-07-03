//
//  QuestionnairesTableViewCell.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 24.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

final class QuestionnairesTableViewCell: UITableViewCell {
    
    //MARK: - Methods
    @IBOutlet weak var nameQuestionnaires: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var estimationLabel: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
}
