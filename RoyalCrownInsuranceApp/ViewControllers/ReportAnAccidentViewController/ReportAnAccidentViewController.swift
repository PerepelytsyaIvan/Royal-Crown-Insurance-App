
//  ReportAnAccidentViewController.swift
//  RoyalCrownInsuranceApp

//  Created by Dream Store on 25.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.

import UIKit
import AVFoundation

final class ReportAnAccidentViewController: CustomNaviationBarViewController, ViewControllerDelegate {
    
    //MARK: Variables
    private var image = [UIImage(named: "icAdd")]
    private let network = NetworkDataFetcher()
    private var photo = [UIImage]()
    private var error: [String]?
    
    //MARK: - @IBOutlet
    
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var reportAccident: UIButton!
    @IBOutlet private var errorView: [UIView]!
    @IBOutlet weak private var gestureView: UIView!
    @IBOutlet private var errorLabels: [UILabel]!
    @IBOutlet private var personalDetailsTextFields: [UITextField]!
    
    @IBOutlet weak private var isAgreeUser: UISwitch!
    @IBOutlet private var errorLabelsConstraint: [NSLayoutConstraint]!
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Accident report"
        collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        configureButton()
        createTapGestureRecognizer()
    }
    
    //MARK: - Methods
    @objc func closingTheKeyboard() {
        for textField in personalDetailsTextFields {
            textField.resignFirstResponder()
        }
    }
    
    private func configureButton() {
        for textField in personalDetailsTextFields {
            textField.borderStyle = .none
        }
        
        reportAccident.clipsToBounds = true
        reportAccident.layer.cornerRadius = 20
        reportAccident.isUserInteractionEnabled = false
        reportAccident.alpha = 0.5
    }
    
    private func createTapGestureRecognizer() {
        let myTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closingTheKeyboard))
        myTapGestureRecognizer.numberOfTapsRequired = 1
        gestureView.addGestureRecognizer(myTapGestureRecognizer)
    }
    
    private func createAlert(massage: String) {
        let alert = UIAlertController(title: nil, message: massage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Home", style: .default, handler: {[weak self] (_) in
            self?.navigationController?.popToRootViewController(animated: true)
        })
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func errorMassage(error: [String]?) {
        var errorMassage = error
        
        if personalDetailsTextFields[0].text == "" {
            errorView[0].backgroundColor = .red
            errorLabels[0].text = errorMassage?[0]
            errorLabelsConstraint[0].constant = 15
        } else {
            errorView[0].backgroundColor = .purple
            errorLabels[0].text = ""
            errorMassage?.insert("", at: 0)
        }
        
        if personalDetailsTextFields[1].text == "" {
            errorView[2].backgroundColor = .red
            errorLabelsConstraint[1].constant = 15
            errorLabels[1].text = errorMassage?[1]
        } else {
            errorView[2].backgroundColor = .purple
            errorLabels[1].text = ""
            errorMassage?.insert("", at: 1)
        }
        
        if personalDetailsTextFields[2].text == "" {
            errorView[1].backgroundColor = .red
            errorLabelsConstraint[2].constant = 18
            errorLabels[2].text = errorMassage?[2]
        } else {
            errorView[1].backgroundColor = .purple
            errorLabels[2].text = ""
            errorMassage?.append("")
        }
    }
    
    func dataTransfer(image: [UIImage]) {
        photo = image
        collectionView.reloadData()
    }
    
    //MARK: - @IBAction
    @IBAction func reportAccident(_ sender: UIButton) {
        let urlString = "http://31.131.21.105:82/api/v1/accident_reports"
        let imageData = photo.compactMap { (image) in
            image.pngData()?.base64EncodedData()
        }
        let parametrs = [
            "name" : "\(personalDetailsTextFields[0].text ?? "")" ,
            "reg_policy_number": "\(personalDetailsTextFields[2].text ?? "")",
            "phone_number" : "\(personalDetailsTextFields[1].text ?? "")",
            "photos_attributes" : "\(imageData)"
        ]
        network.post(parametrs: parametrs, urlString: urlString) {[weak self] (massage) in
            if massage?.errors != nil {
                self?.error = massage?.errors
                self?.errorMassage(error: massage?.errors)
            } else {
                guard let massage = massage?.message else { return }
                self?.createAlert(massage: massage)
                guard let strongSelf = self else { return }
                for index in 0..<strongSelf.errorLabelsConstraint.count {
                   strongSelf.errorLabelsConstraint[index].constant = 0
                   strongSelf.errorView[index].backgroundColor = .purple
                }
            }
        }
    }
    
    @IBAction func agreeSwitch(_ sender: UISwitch) {
        reportAccident.alpha = sender.isOn ? 1 : 0.5
        reportAccident.isUserInteractionEnabled = sender.isOn ? true : false
    }
}

//MARK: - UICollectionViewDataSource
extension ReportAnAccidentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        cell.delegate = self
        if indexPath.item == 0 {
            cell.photoImageView.image = image[0]
            cell.delatePhotoButton.isHidden = true
        } else {
            cell.photoImageView.image = photo[indexPath.item - 1]
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ReportAnAccidentViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "CustumCameraViewController") as! CustumCameraViewController
            
            navigationController?.navigationBar.backItem?.backBarButtonItem = nil
            vc.delegate = self
            print(indexPath)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - PhotoCollectionViewCellDelegate
extension ReportAnAccidentViewController: PhotoCollectionViewCellDelegate {
    func didTappedCell(from: PhotoCollectionViewCell) {
        let indexPath = collectionView.indexPath(for: from)
        if indexPath?.row != 0 {
            photo.remove(at: indexPath!.row - 1)
        } else {
            photo.remove(at: indexPath!.row)
        }
        collectionView.reloadData()
    }
}

//MARK: - UITextFieldDelegate
extension ReportAnAccidentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if personalDetailsTextFields[1].text!.count < 8 {
            isAgreeUser.isOn = false
            isAgreeUser.isUserInteractionEnabled = false
            reportAccident.isUserInteractionEnabled = false
            reportAccident.alpha = 0.5
            errorLabelsConstraint[1].constant = 15
            errorLabels[1].text = "Tell numbers should be 8 digits numbers"
        } else {
            isAgreeUser.isUserInteractionEnabled = true
            errorLabelsConstraint[1].constant = 0
        }
    }
}

