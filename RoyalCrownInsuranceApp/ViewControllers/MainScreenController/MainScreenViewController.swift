//
//  MainScreenViewController.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 23.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit
import SafariServices

final class MainScreenViewController: UIViewController {
    
    //MARK: - Variable
    let dataScreen = DataManager.shared
    
    //MARK: -  @IBOutlet
    @IBOutlet weak private var collectionView: UICollectionView!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        addImageToNavigationBar()
        
    }
    
    //MARK: - Methods
    private func addImageToNavigationBar() {
        let width = (navigationController?.navigationBar.frame.width)! * 0.4
        let height = navigationController?.navigationBar.frame.height
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height!))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height!))
        imageView.image = #imageLiteral(resourceName: "icLogoMain")
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        navigationItem.titleView = view
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "icBack")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "icBack")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    private func registerCells() {
        collectionView.register(UINib(nibName: "MainScreenMaxCell", bundle: nil), forCellWithReuseIdentifier: "MainScreenMaxCell")
    }
}

//MARK: - UICollectionViewDataSource
extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataScreen.text.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainScreenMaxCell", for: indexPath) as! MainScreenMaxCell
        cell.titleLabel.text = dataScreen.text[indexPath.item]
        cell.configureCell(index: indexPath.item)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension MainScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MainScreenMaxCell
        switch indexPath.item {
        case 0, 2, 4:
            let vc = storyboard?.instantiateViewController(withIdentifier: "ServicesAndAboutAndRoyalScrren") as! ServicesAndAboutAndRoyalScrren
            vc.screenName = cell.titleLabel.text
            vc.title = cell.titleLabel.text!.capitalizingFirstLetter()
            navigationController?.pushViewController(vc, animated: true)
            
        case 1:
            let url = URL(string: "https://www.jccsmart.com/eBills/Welcome/Index/9634031")
            let svc = SFSafariViewController(url: url!)
            present(svc, animated: true, completion: nil)
            
        case 3:
            let vc = storyboard?.instantiateViewController(withIdentifier: "WhatToDoIfViewController") as! WhatToDoIfViewController
            vc.title = cell.titleLabel.text!.capitalizingFirstLetter()
            navigationController?.pushViewController(vc, animated: true)
            
        case 5:
            let vc = storyboard?.instantiateViewController(withIdentifier: "QuestionnairesViewController") as! QuestionnairesViewController
            vc.title = cell.titleLabel.text!.capitalizingFirstLetter()
            navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0, 1, 3, 4:
            return CGSize(width: (collectionView.frame.width / 2) - 5, height: (collectionView.frame.height / 4) - 5 )
        default:
            return CGSize(width: collectionView.frame.width, height: (collectionView.frame.height / 4) - 5 )
        }
    }
}
