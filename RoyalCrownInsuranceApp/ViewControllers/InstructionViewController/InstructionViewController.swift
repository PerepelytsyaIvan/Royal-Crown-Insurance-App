//
//  InstructionViewController.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 25.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

final class InstructionViewController: CustomNaviationBarViewController {
    
    //MARK: - Variables
    var instruction: Instruction?
    private var isActive = false
    
    //MARK: - @IBOutlet

    @IBOutlet weak private var instructionTextView: UITextView!
    @IBOutlet weak private var firstTabButton: UIButton!
    @IBOutlet weak private var secondTabButton: UIButton!
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureButton()
        firstTabButton.backgroundColor = .blue
        secondTabButton.setTitleColor(.blue, for: .normal)
        instructionTextView.text = instruction?.firstTabContent.htmlToString
    }
    
    //MARK: - Methods
    private func configureButton() {
        firstTabButton.setTitle(instruction?.firstTabTitle, for: .normal)
        secondTabButton.setTitle(instruction?.secondTabTitle, for: .normal)
        if instruction?.secondTabTitle == "" {
            secondTabButton.isHidden = true
        }
    }
    
    //MARK: - @IBAction
    @IBAction func tabButton(_ sender: UIButton) {
        if sender.tag == 0 {
            instructionTextView.text = instruction?.firstTabContent.htmlToString
            firstTabButton.backgroundColor = .blue
            secondTabButton.backgroundColor = .white
            secondTabButton.setTitleColor(.blue, for: .normal)
            firstTabButton.setTitleColor(.white, for: .normal)
            isActive = true
        } else {
            instructionTextView.text = instruction?.secondTabContent.htmlToString
            firstTabButton.backgroundColor = .white
            secondTabButton.backgroundColor = .blue
            firstTabButton.setTitleColor(.blue, for: .normal)
            secondTabButton.setTitleColor(.white, for: .normal)
        }
    }
}
