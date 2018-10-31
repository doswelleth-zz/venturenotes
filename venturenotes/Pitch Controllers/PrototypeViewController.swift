//
//  PrototypeViewController.swift
//  venturenotes
//
//  Created by David Doswell on 10/30/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class PrototypeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()

    }
    
    private func setUpViews() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "PitchBackground")!)
        
    }

}
