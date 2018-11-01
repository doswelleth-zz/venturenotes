//
//  PitchViewController.swift
//  venturenotes
//
//  Created by David Doswell on 10/30/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

private let navigationTitle = String.pitchVCTitle

class PitchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = navigationTitle
        
        setUpNavBar()
        setUpViews()
    }
    
    let napkinImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Napkin")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let napkinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.napkinButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = .black
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(napkinButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let elevatorImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Elevator")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let elevatorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.elevatorButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = .black
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(elevatorButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let prototypeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Prototype")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let prototypeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.prototypeButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = .black
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(prototypeButtonType(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let startUpImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Startup")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let startUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.startUpButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = .black
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(startUpButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func napkinButtonTapped(sender: UIButton) {
        let vc = NapkinViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func elevatorButtonTapped(sender: UIButton) {
        let vc = ElevatorViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func prototypeButtonType(sender: UIButton) {
        print("Prototype!")
    }
    
    @objc private func startUpButtonTapped(sender: UIButton) {
        print("Startup!")
    }
    
    private func setUpNavBar() {
        let left = UIButton(type: .custom)
        left.setTitle(String.backButton, for: .normal)
        left.setTitleColor(.white, for: .normal)
        left.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        left.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        left.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        left.adjustsImageWhenHighlighted = false
        left.addTarget(self, action: #selector(leftBarButtonTapped(sender:)), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: left)
    }

    @objc private func leftBarButtonTapped(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUpViews() {
        view.backgroundColor = Appearance.customBackground
        
        view.addSubview(napkinButton)
        view.addSubview(napkinImage)
        view.addSubview(elevatorButton)
        view.addSubview(elevatorImage)
        view.addSubview(prototypeButton)
        view.addSubview(prototypeImage)
        view.addSubview(startUpButton)
        view.addSubview(startUpImage)
        
        napkinImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        napkinImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        napkinImage.widthAnchor.constraint(equalToConstant: 125).isActive = true
        napkinImage.heightAnchor.constraint(equalToConstant: 100).isActive = true

        napkinButton.topAnchor.constraint(equalTo: napkinImage.bottomAnchor, constant: 20).isActive = true
        napkinButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        napkinButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        napkinButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        elevatorImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        elevatorImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        elevatorImage.widthAnchor.constraint(equalToConstant: 125).isActive = true
        elevatorImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        elevatorButton.topAnchor.constraint(equalTo: elevatorImage.bottomAnchor, constant: 20).isActive = true
        elevatorButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        elevatorButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        elevatorButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        prototypeImage.topAnchor.constraint(equalTo: napkinButton.bottomAnchor, constant: 100).isActive = true
        prototypeImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        prototypeImage.widthAnchor.constraint(equalToConstant: 125).isActive = true
        prototypeImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        prototypeButton.topAnchor.constraint(equalTo: prototypeImage.bottomAnchor, constant: 20).isActive = true
        prototypeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        prototypeButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        prototypeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        startUpImage.topAnchor.constraint(equalTo: elevatorButton.bottomAnchor, constant: 100).isActive = true
        startUpImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        startUpImage.widthAnchor.constraint(equalToConstant: 125).isActive = true
        startUpImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        startUpButton.topAnchor.constraint(equalTo: startUpImage.bottomAnchor, constant: 20).isActive = true
        startUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        startUpButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        startUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
