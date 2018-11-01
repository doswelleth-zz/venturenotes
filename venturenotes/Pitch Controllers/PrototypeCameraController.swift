//
//  PrototypeCameraController.swift
//  venturenotes
//
//  Created by David Doswell on 10/31/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import AVFoundation

class PrototypeCameraController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
        case .authorized:
            self.showCamera()
            break
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if !granted { fatalError("Video Filters Needs Camera Access") }
                self.showCamera()
            }
            
        case .denied:
            fallthrough
            
        case .restricted:
            fatalError("Video Filters Needs Camera Access")
        }
    }
    
    private func showCamera() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showCamera", sender: nil)
        }
    }
    
}
