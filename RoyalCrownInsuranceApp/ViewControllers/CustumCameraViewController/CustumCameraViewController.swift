//
//  CustumCameraViewController.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 25.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit
import AVFoundation
protocol ViewControllerDelegate {
    func dataTransfer(image: [UIImage])
}

class CustumCameraViewController: CustomNaviationBarViewController {
    
    //MARK: - enum
    enum Position {
        case back
        case front
    }
    
    //MARK: - Variables
    private var captureSession: AVCaptureSession?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
    private var backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    private var capturePhotoOutput: AVCapturePhotoOutput?
    private let imagePickerController = UIImagePickerController()
    private var flash: AVCaptureDevice.FlashMode? = .off
    private var image = [UIImage]()
    private var flashCount = 0
    
    
    var delegate: ViewControllerDelegate?
    
    //MARK: - @IBOutlet
    @IBOutlet weak private var flashButton: UIButton!
    @IBOutlet weak private var cameraView: UIView!
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var cameraButton: UIButton!
    @IBOutlet weak private var switchButton: UIButton!
    @IBOutlet weak private var galleryButton: UIButton!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        requestToTheCamera()
        configureButtonCamera()
        collectionView.register(UINib(nibName: "CameraCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CameraCollectionCell")
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
    }
    
    //MARK: - Methods
    private func requestToTheCamera() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            let alert = UIAlertController(title: nil, message: "Permission is required to use the camera", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Settings", style: .default) { (_) in
                let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
                if !isRegisteredForRemoteNotifications {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                }
            }
            let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel) {[weak self] (_) in
                self?.navigationController?.popViewController(animated: true)
            }
            alert.addAction(alertAction)
            alert.addAction(alertActionCancel)
            present(alert, animated: true, completion: nil)
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.cameraSwitch(regime: self.backCamera, position: .front)
                }
            }
        case .restricted:
            navigationController?.popViewController(animated: true)
            return
        case .authorized:
            cameraSwitch(regime: backCamera, position: .front)
        @unknown default:
            break
        }
    }
    
    private func configureButtonCamera() {
        let imageSwitch = #imageLiteral(resourceName: "icons8-перезапуск-80").tinted(with: .white)
        let imagePhoto = #imageLiteral(resourceName: "icons8-circle-80").tinted(with: .white)
        let imageGallery = #imageLiteral(resourceName: "icons8-picture-60").tinted(with: .white)
        let flashImage = #imageLiteral(resourceName: "icons8-lightning-bolt-60").tinted(with: .white)
        switchButton.setImage(imageSwitch, for: .normal)
        cameraButton.setImage(imagePhoto, for: .normal)
        galleryButton.setImage(imageGallery, for: .normal)
        flashButton.setImage(flashImage, for: .normal)
    }
    
    private func cameraSwitch(regime: AVCaptureDevice?, position: Position) {
        let captureDevice: AVCaptureDevice?
        if regime?.isConnected == true {
            captureSession?.stopRunning()
            if position == .back {
                captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            } else {
                captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
                flash = .off
            }
            
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice!)
                captureSession = AVCaptureSession()
                captureSession?.addInput(input)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                videoPreviewLayer?.frame = view.layer.bounds
                cameraView.layer.addSublayer(videoPreviewLayer!)
                captureSession?.startRunning()
            } catch {
                
            }
            
            capturePhotoOutput = AVCapturePhotoOutput()
            capturePhotoOutput?.isHighResolutionCaptureEnabled = true
            captureSession?.addOutput(capturePhotoOutput!)
        }
    }
    
    //MARK: - @IBAction
    @IBAction func doneButton(_ sender: UIButton) {
        delegate?.dataTransfer(image: image)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func takeAPhoto(_ sender: UIButton) {
        guard let capturePhotoOutput = capturePhotoOutput else { return }
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = flash!
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
        
    }
    
    @IBAction func rotateCamera(_ sender: UIButton) {
        guard let currentCameraInput: AVCaptureInput = captureSession?.inputs.first else { return }
        if let input = currentCameraInput as? AVCaptureDeviceInput {
            if input.device.position == .back {
                cameraSwitch(regime: frontCamera, position: .front)
                flash = .off
            } else {
                cameraSwitch(regime: backCamera, position: .back)
            }
        }
    }
    
    @IBAction func flashButton(_ sender: UIButton) {
        guard let device = frontCamera else { return }
        if flash == AVCaptureDevice.FlashMode.off {
            flashButton.setImage(#imageLiteral(resourceName: "icons8-lightning-bolt-60-2"), for: .normal)
            flash = .on
        } else {
            flashButton.setImage(#imageLiteral(resourceName: "icons8-lightning-bolt-60"), for: .normal)
            flash = .off
        }
        guard device.isTorchAvailable else { return }
        do {
            try device.lockForConfiguration()
            if device.torchMode == .on {
                try device.setTorchModeOn(level: 0.7)
            }
        } catch {
            debugPrint(error)
        }
    }
    
    @IBAction func gallaryButton(_ sender: Any) {
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
}

//MARK: - UICollectionViewDataSource
extension CustumCameraViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CameraCollectionCell", for: indexPath) as! CameraCollectionCell
        cell.photoImageView.image = image[indexPath.item]
        return cell
    }
}

//MARK: - AVCapturePhotoCaptureDelegate
extension CustumCameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        let imageData = photo.fileDataRepresentation()
        guard let imageD = imageData else { return }
        let capturedImage = UIImage(data: imageD, scale: 1.0)
        if let image = capturedImage {
            self.image.append(image)
            collectionView.reloadData()
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension CustumCameraViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.image.append(image)
            collectionView.reloadData()
            self.dismiss(animated: true, completion: nil)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UINavigationControllerDelegate
extension CustumCameraViewController: UINavigationControllerDelegate {
}

