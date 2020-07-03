//
//  QuestViewController.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 28.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

final class QuestViewController: CustomNaviationBarViewController {
    
    //MARK: - Variable
    private var dataSource: [QuestionsList] = []
    var id: Int?
    private let network = NetworkDataFetcher()
    private var index = 0
    private var user: [String?: [String? :Bool?]] = [:]
    private var answersUser: [String? : [String? :Bool?]] = [:]
    private var quest = QuestionsList()
    private var previousIndexPath: IndexPath?
    private var targetRespond: [Int: Int] = [:]
    
    //MARK: - @IBOutlet
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var questionNumberLabel: UILabel!
    @IBOutlet weak private var questionLabel: UILabel!
    @IBOutlet weak private var pageControl: UIPageControl!
    @IBOutlet weak private var prevButton: UIButton!
    @IBOutlet weak private var nextButton: UIButton!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "QuestTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestTableViewCell")
        let url = "http://31.131.21.105:82/api/v1/questions?questionnaire_id=\(id!)&"
        network.fetchQuestionsList(urlString: url) {[weak self] (quest) in
            guard let quest = quest else { return }
            self?.dataSource = quest
            self?.pageControl.numberOfPages = (self?.dataSource.count)!
            self?.quest = quest.first!
            self?.tableView.reloadData()
        }
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prevButton.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pageControl.customPageControl(dotFillColor: .purple, dotBorderColor: .lightGray, dotBorderWidth: 1.0)

    }
    
    //MARK: - Methods
    private func countingAnswers() {
        var index = 0
        for key in answersUser.keys {
            for value in answersUser[key]!.values{
                if value! == true {
                    index += 1
                }
            }
        }
        let result = ("\(index)/\(dataSource.count)")
        
        UserDefaults.standard.set(result, forKey: "\(id!)")
        
    }
    
    @IBAction func scrollButton(_ sender: UIButton) {
        previousIndexPath = nil
        if !dataSource.isEmpty {
        if sender.currentTitle == "Next" {
            
            index += 1
        } else {
            index -= 1
        }
        if index == dataSource.count && sender.tag == 1 {
            UserDefaults.standard.set(answersUser, forKey: "\(id!)")
            countingAnswers()
            navigationController?.popViewController(animated: true)
            return
        } else {
            nextButton.isHidden = false
        }
        
        if index == 0 && sender.tag == 0 {
            prevButton.isHidden = true
        } else {
            prevButton.isHidden = false
        }
        
        quest = dataSource[index]
        pageControl.currentPage = index
        answersUser = user
        tableView.reloadData()
        }
    }
}

//MARK: - UITableViewDataSource
extension QuestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource.isEmpty {
            return 0
        }
        return quest.answers!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestTableViewCell", for: indexPath) as! QuestTableViewCell
        cell.questLabel.text = quest.answers![indexPath.row].text
        questionLabel.text = quest.text
        cell.questLabel.textColor = .lightGray
        questionNumberLabel.text = ("\(index + 1)/\(dataSource.count)")
        
        if indexPath.row == targetRespond[index] {
            cell.questLabel.textColor = .black
        }
        return cell
    }
    
    
}

//MARK: - UITableViewDelegate
extension QuestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        targetRespond[index] = indexPath.row
        let cell = tableView.cellForRow(at: indexPath) as! QuestTableViewCell
        if let indexPathPrevius = previousIndexPath {
            let cell2 = tableView.cellForRow(at: indexPathPrevius) as! QuestTableViewCell
            cell2.questLabel.textColor = .lightGray
            previousIndexPath = nil
        }
        cell.questLabel.textColor = .black
        
        if indexPath.row == targetRespond[index] {
            cell.questLabel.textColor = .black
            tableView.reloadData()
        } else {
            cell.questLabel.textColor = .lightGray
        }
        guard let anwers = quest.answers else { return }
        user["\(index)"] = ["\(anwers[indexPath.row].order ?? 0)": anwers[indexPath.row].correct]
        previousIndexPath = indexPath
    }
    
}

    
    extension UIPageControl {
        func customPageControl(dotFillColor: UIColor, dotBorderColor: UIColor, dotBorderWidth: CGFloat) {
            for (pageIndex, dotView) in self.subviews.enumerated() {
                dotView.backgroundColor = currentPage == pageIndex ? dotFillColor : .clear
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
                dotView.layer.borderColor = dotBorderColor.cgColor
                dotView.layer.borderWidth = dotBorderWidth
            }
        }
    }

