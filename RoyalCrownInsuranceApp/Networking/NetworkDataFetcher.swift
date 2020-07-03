//
//  NetworkDataFetcher.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 23.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import Foundation
final class NetworkDataFetcher {
    
    let networkServise = NetworkService()
    
    func fetchInstruction(urlString: String, response: @escaping ([Instruction]?) -> Void) {
        networkServise.request(urlString: urlString) { (resault) in
            switch resault {
            case .success(let data):
                do {
                    let data = try? JSONDecoder().decode([Instruction].self, from: data)
                    response(data)
                }
            case .failure(_):
                response(nil)
            }
        }
    }
    
    func fetchServices(urlString: String, response: @escaping ([Services]?) -> Void) {
        networkServise.request(urlString: urlString) { (resault) in
            switch resault {
            case .success(let data):
                do {
                    let data = try? JSONDecoder().decode([Services].self, from: data)
                    response(data)
                }
            case .failure(_):
                response(nil)
            }
        }
    }
    
    func fetchBranch(urlString: String, response: @escaping ([Branch]?) -> Void) {
        networkServise.request(urlString: urlString) { (resault) in
            switch resault {
            case .success(let data):
                do {
                    let data = try? JSONDecoder().decode([Branch].self, from: data)
                    response(data)
                }
            case .failure(_):
                response(nil)
            }
        }
    }
    
    func fetchAboutUs(urlString: String, response: @escaping (AboutUs?) -> Void) {
        networkServise.request(urlString: urlString) { (resault) in
            switch resault {
            case .success(let data):
                do {
                    let data = try? JSONDecoder().decode(AboutUs?.self, from: data)
                    response(data)
                }
            case .failure(_):
                response(nil)
            }
        }
    }
    
    func fetchQuestionnaire(urlString: String, response: @escaping ([Questionnaire]?) -> Void) {
        networkServise.request(urlString: urlString) { (resault) in
            switch resault {
            case .success(let data):
                do {
                    let data = try? JSONDecoder().decode([Questionnaire].self, from: data)
                    response(data)
                }
            case .failure(_):
                response(nil)
            }
        }
    }
    
    func fetchQuestionsList(urlString: String, response: @escaping ([QuestionsList]?) -> Void) {
        networkServise.request(urlString: urlString) { (resault) in
            switch resault {
            case .success(let data):
                do {
                    let data = try? JSONDecoder().decode([QuestionsList].self, from: data)
                    response(data)
                }
            case .failure(_):
                response(nil)
            }
        }
    }
    
    func post(parametrs: [String: String], urlString: String, response: @escaping (Report?) -> Void) {
            guard let url = URL(string: urlString) else {return}
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json;", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parametrs, options: []) else {return}
            request.httpBody = httpBody

        networkServise.postRequest(request: request) { (result) in
            switch result {
            case .success(let data):
                do {
                    let data = try? JSONDecoder().decode(Report.self, from: data)
                    response(data)
                }
            case .failure(_):
                response(nil)
            }
        }
    }
}
