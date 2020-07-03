//
//  Model.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 23.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.

import Foundation
import UIKit

struct Branch: Decodable {
    var idBranch: Int
    var title: String
    var address: String
    var phone: String
    var fax: String
    var email: String
    var postalCode: String
    var latitude: Double
    var longitude: Double

    enum CodingKeys: String, CodingKey {
        case idBranch = "id"
        case title
        case address
        case phone
        case fax
        case email
        case postalCode = "postal_code"
        case latitude
        case longitude
    }
}

struct Instruction: Decodable {
    var instructinID: Int
    var instructionsTitle: String
    var isTabs: Bool
    var firstTabTitle: String
    var firstTabContent: String
    var secondTabTitle: String
    var secondTabContent: String
    
    enum CodingKeys: String, CodingKey {
        case instructinID = "id"
        case instructionsTitle = "title"
        case isTabs = "tabs"
        case firstTabTitle = "tab_1_title"
        case firstTabContent = "tab_1_content"
        case secondTabTitle = "tab_2_title"
        case secondTabContent = "tab_2_content"
    }
}

struct Services: Decodable {
    var servicesID: Int
    var title: String
    var type: String
    var description: String
    var website: String
    enum CodingKeys: String, CodingKey {
        case servicesID = "id"
        case title
        case type
        case description
        case website
    }
}

struct Report: Decodable {
    var message: String?
    var errors: [String]?
}


struct AboutUs: Decodable {
    var about: String?
    var aboutRoyalAssist: String?
    
    enum CodingKeys: String, CodingKey {
        case about = "about_us"
        case aboutRoyalAssist = "about_royal_assist"
    }
}
struct Questionnaire: Decodable {
    var id: Int?
    var title: String?
    var description: String?
    var createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case createdAt = "created_at"
    }
}
struct QuestionsList: Decodable {
    var id: Int?
    var text: String?
    var order: Int?
    var answers: [Quest]?
}
struct Quest: Decodable {
    var id: Int?
    var text: String?
    var correct: Bool?
    var order: Int?
}


