//
//  PhotoScreens.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 24.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import Foundation

class DataManager {
    static var shared = DataManager()
    let screen = ["ABOUT": ["imgAboutUs", "imgBranches", "imgEnshured"], "SERVICES": ["imgWhatToDoIf-1", "imgWhatToDoIf-2"], "ROYAL ASIST" : ["imgRoyalAssist", "imgEnshured", "imgAboutUs"]]
    let titleScreen = ["ABOUT": ["ABOUT US", "BRANCHES", "E - NSURED"], "SERVICES": ["BUSSINES", "PERSONAL"], "ROYAL ASIST": ["REPORT AN ACCIDENT", "MAKE A CALL", "ABOUT ROYAL ASIST"]]
    var text = ["ROYAL ASIST", "ROYAL PAYMENT", "SERVICES", "WHAT TO DO IF", "ABOUT", "QUESTIONNAIRES"]
}
