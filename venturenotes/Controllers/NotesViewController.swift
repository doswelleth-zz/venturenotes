//
//  NotesViewController.swift
//  venturenotes
//
//  Created by David Doswell on 10/29/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
        setUpViews()
        hideKeyboardWhenTapped()
    }
    
    private func setUpNavBar() {
        let left = UIButton(type: .custom)
        left.setTitle(String.backButton, for: .normal)
        left.setTitleColor(.white, for: .normal)
        left.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        left.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        left.adjustsImageWhenHighlighted = false
        left.addTarget(self, action: #selector(leftBarButtonTapped(sender:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: left)
    }
    
    @objc private func leftBarButtonTapped(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUpViews() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "NotesBackground")!)
        self.title = String.notesVCTitle
    }
    
}
