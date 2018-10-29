//
//  GlossaryViewController.swift
//  venturenotes
//
//  Created by David Doswell on 10/29/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class GlossaryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
    }
    
    private func setUpViews() {
        view.backgroundColor = Appearance.customBackground
        self.title = String.glossaryVCTitle
    }
    

}
