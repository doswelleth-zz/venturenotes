//
//  HomeViewController.swift
//  venturenotes
//
//  Created by David Doswell on 10/29/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let profileButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Profile"), for: .normal)
        button.layer.cornerRadius = 50
        button.clipsToBounds = true
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(profileButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let notesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.notesButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = .black
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(notesButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let glossaryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.glossaryButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = .black
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(glossaryButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let dealFlowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.dealFlowButtonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = .white
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(dealFlowButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func profileButtonTapped(sender: UIButton) {
        print("Yay!")
    }
    
    @objc private func notesButtonTapped(sender: UIButton) {
        let vc = NotesViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func glossaryButtonTapped(sender: UIButton) {
        let vc = GlossaryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func dealFlowButtonTapped(sender: UIButton) {
        print("Hey!")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    private func setUpViews() {
        view.backgroundColor = Appearance.customBackground
       
        self.title = String.homeVCTitle
        
        view.addSubview(profileButton)
        view.addSubview(notesButton)
        view.addSubview(glossaryButton)
        view.addSubview(dealFlowButton)
        
        profileButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 175.0).isActive = true
        profileButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        profileButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        notesButton.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 50.0).isActive = true
        notesButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        notesButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        notesButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        glossaryButton.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 50.0).isActive = true
        glossaryButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0).isActive = true
        glossaryButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        glossaryButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        dealFlowButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0).isActive = true
        dealFlowButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dealFlowButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        dealFlowButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}
