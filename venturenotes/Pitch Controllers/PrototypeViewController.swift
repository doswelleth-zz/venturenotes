//
//  PrototypeViewController.swift
//  venturenotes
//
//  Created by David Doswell on 10/30/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class PrototypeViewController: UIViewController, AVCaptureFileOutputRecordingDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCapture()
        updateViews()
        setUpViews()
    }
    
    let previewView = CameraPreviewView()
    
    private var captureSession: AVCaptureSession!
    private var recordOutput: AVCaptureMovieFileOutput!
    
    var prototypeController: PrototypeController?
    
    let recordButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(recordButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func recordButtonTapped(sender: UIButton) {
        if recordOutput.isRecording {
            recordOutput.stopRecording()
            
            guard let url = recordOutput.outputFileURL else { return }
            prototypeController?.createPrototype(url: url, date: Date())
            presentHomeVC()
        } else {
            recordOutput.startRecording(to: newRecordingURL(), recordingDelegate: self)
        }
    }
    
    private func presentHomeVC() {
        let vc = HomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        DispatchQueue.main.async {
            self.updateViews()
        }
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        DispatchQueue.main.async {
            self.updateViews()
        }
        
        PHPhotoLibrary.requestAuthorization { (status) in
            if status != .authorized {
                NSLog("Please give me access")
                return
            }
            
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: outputFileURL)
            }, completionHandler: { (success, error) in
                if let error = error {
                    NSLog("Error: \(error)")
                }
            })
        }
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        
        let recordButtonImageName = recordOutput.isRecording ? "Stop" : "Record"
        recordButton.setImage(UIImage(named: recordButtonImageName)!, for: .normal)
    }
    
    private func setUpCapture() {
        let captureSession = AVCaptureSession()
        let device = bestCamera()
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: device),
            captureSession.canAddInput(videoDeviceInput) else {
                fatalError()
        }
        captureSession.addInput(videoDeviceInput)
        
        let fileOutput = AVCaptureMovieFileOutput()
        guard captureSession.canAddOutput(fileOutput) else { fatalError() }
        captureSession.addOutput(fileOutput)
        recordOutput = fileOutput
        
        captureSession.sessionPreset = .hd1920x1080
        captureSession.commitConfiguration()
        
        self.captureSession = captureSession
        previewView.videoPreviewLayer.session = captureSession
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        captureSession.startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        captureSession.stopRunning()
    }
    
    private func bestCamera() -> AVCaptureDevice {
        if let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) {
            return device
        } else if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            return device
        } else {
            fatalError("Missing expected back camera")
        }
    }
    
    private func newRecordingURL() -> URL {
        let fm = FileManager.default
        let documentsDir = try! fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        return documentsDir.appendingPathComponent(UUID().uuidString).appendingPathExtension("mov")
    }
    
    private func setUpViews() {
        previewView.frame = UIScreen.main.bounds
        view.addSubview(recordButton)
        
        recordButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recordButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        recordButton.heightAnchor.constraint(equalToConstant: 100).isActive = true

    }

}
