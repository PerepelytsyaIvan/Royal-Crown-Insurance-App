//
//  BranchesViewController.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 26.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.

import UIKit
import GoogleMaps

final class BranchesViewController: CustomNaviationBarViewController {
    
    //MARK: - Variable
    private let meneger = NetworkDataFetcher()
    private var dataSource: [Branch]?
    private  var selectMarker: GMSMarker?
    private var isPressed = 0
    
    //MARK: - @IBOutlet
    @IBOutlet weak private var mapView: GMSMapView!
    @IBOutlet weak private var heightConstraintLabel: NSLayoutConstraint!
    @IBOutlet weak private var heightConstraintView: NSLayoutConstraint!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var infoLabel: UILabel!
    @IBOutlet weak private var infoView: UIView!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        infoView.isHidden = true
        configureMap()
        data()
        title = "Branches"
    }
    
    //MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        addMapToView()
    }
    
    //MARK: - Methods
    private func configureMap() {
        mapView?.delegate = self
        mapView.addSubview(infoView)
    }
    
    private func data() {
        let urlString = "http://31.131.21.105:82/api/v1/branches"
        meneger.fetchBranch(urlString: urlString) {[weak self] (branch) in
            self?.dataSource = branch
        }
    }
    
    private func addMapToView() {
        addMarker()
        let camera = GMSCameraPosition.camera(withLatitude: 35.1655379384343, longitude: 33.3601695857942, zoom: 8)
        mapView!.isMyLocationEnabled = true
        mapView!.camera = camera
    }
    
    private func addMarker() {
        guard self.dataSource != nil else { return }
        for item in dataSource! {
            let latitude = item.latitude
            let longitude = item.longitude
            let marker = GMSMarker(position: CLLocationCoordinate2DMake(latitude, longitude))
            marker.icon = #imageLiteral(resourceName: "icPinPassive")
            marker.title = item.title
            marker.snippet = item.address
            marker.map = mapView
            marker.tracksInfoWindowChanges = true
        }
    }
    
    private func addDiscription(title: String?) {
        guard let title = title else { return }
        guard let branches = dataSource else { return }
        
        for branch in branches {
            if title == branch.title {
                titleLabel.text = title
                infoLabel.text = "\(branch.address)\nP.O.Box: \(branch.postalCode)\nT: \(branch.phone)\nF: \(branch.fax)\nE: \(branch.email)"
            }
        }
    }
    
    //MARK: - @IBAction
    @IBAction func increasesViewButton(_ sender: UIButton) {
        isPressed += 1
        self.loadViewIfNeeded()
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let strongSelf = self else { return }
            if strongSelf.isPressed % 2 == 1 {
                sender.setImage(#imageLiteral(resourceName: "icArrowDown"), for: .normal)
                strongSelf.heightConstraintView.constant = 250
                strongSelf.heightConstraintLabel.constant = 150
                strongSelf.view.layoutIfNeeded()
            } else {
                sender.setImage(#imageLiteral(resourceName: "icArrowUp"), for: .normal)
                strongSelf.heightConstraintView.constant = 100
                strongSelf.heightConstraintLabel.constant = 150
                strongSelf.view.layoutIfNeeded()
            }
        }
    }
}

//MARK: - GMSMapViewDelegate
extension BranchesViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        infoView.isHidden = false
        selectMarker?.icon = #imageLiteral(resourceName: "icPinPassive")
        marker.icon = #imageLiteral(resourceName: "icPinActive")
        selectMarker = marker
        addDiscription(title: selectMarker?.title)
        return true
    }
}
