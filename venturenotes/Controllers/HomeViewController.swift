//
//  HomeViewController.swift
//  venturenotes
//
//  Created by David Doswell on 10/29/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
        setUpViews()
    }
    
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
    
    let pitchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.pitchButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = .black
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(pitchButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Logo")
        image.layer.cornerRadius = 75
        image.layer.shadowColor = UIColor.lightGray.cgColor
        image.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        image.layer.shadowOpacity = 1.0
        image.layer.shadowRadius = 4
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    @objc private func notesButtonTapped(sender: UIButton) {
        let vc = NotesViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func glossaryButtonTapped(sender: UIButton) {
        let vc = GlossaryTableViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func dealFlowButtonTapped(sender: UIButton) {
        let alert = UIAlertController(title: "Welcome investors", message: "Please subscribe to receive high quality deal flow.", preferredStyle: .alert)
        let goBack = UIAlertAction(title: "Go Back", style: .default) { (action) in
        }
        let subscribe = UIAlertAction(title: "Subscribe", style: .default) { (action) in
            //        IAPHelper.shared.purchase(product: .autoRenewingSubscription)
            let vc = DealViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        alert.addAction(goBack)
        alert.addAction(subscribe)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func pitchButtonTapped(sender: UIButton) {
        let vc = PitchViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setUpNavBar() {
        let left = UIButton(type: .custom)
        left.setTitle(login.usernameTextField.text!, for: .normal)
        left.setTitleColor(.white, for: .normal)
        left.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        left.widthAnchor.constraint(equalToConstant: 200).isActive = true
        left.heightAnchor.constraint(equalToConstant: 20).isActive = true
        left.adjustsImageWhenHighlighted = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: left)
    }
    
    var login = LoginViewController()
    
    private func setUpViews() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationItem.hidesBackButton = true
        
        view.backgroundColor = Appearance.customBackground
       
        self.title = String.homeVCTitle
        
        view.addSubview(notesButton)
        view.addSubview(glossaryButton)
        view.addSubview(dealFlowButton)
        view.addSubview(pitchButton)
        view.addSubview(logoImage)
        
        notesButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 175.0).isActive = true
        notesButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        notesButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        notesButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        glossaryButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 175.0).isActive = true
        glossaryButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0).isActive = true
        glossaryButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        glossaryButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        logoImage.topAnchor.constraint(equalTo: glossaryButton.bottomAnchor, constant: 50).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        dealFlowButton.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 50).isActive = true
        dealFlowButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        dealFlowButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        dealFlowButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
       
        pitchButton.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 50).isActive = true
        pitchButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        pitchButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        pitchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}
