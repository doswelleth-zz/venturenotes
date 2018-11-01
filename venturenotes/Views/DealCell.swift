//
//  DealCell.swift
//  venturenotes
//
//  Created by David Doswell on 10/31/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class DealCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let stageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let productLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.forwardButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = .black
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contactLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setUpViews() {
        
        backgroundColor = .black
        
        addSubview(stageLabel)
        addSubview(nameTextLabel)
        addSubview(productLabel)
        addSubview(playButton)
        addSubview(durationLabel)
        addSubview(contactLabel)
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 2
        
        stageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        stageLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        stageLabel.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
        stageLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        nameTextLabel.topAnchor.constraint(equalTo: stageLabel.bottomAnchor, constant: 40).isActive = true
        nameTextLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        nameTextLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        nameTextLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        productLabel.topAnchor.constraint(equalTo: nameTextLabel.bottomAnchor, constant: 10).isActive = true
        productLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        productLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        productLabel.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        playButton.topAnchor.constraint(equalTo: productLabel.bottomAnchor, constant: 30).isActive = true
        playButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        durationLabel.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 30).isActive = true
        durationLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        durationLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        durationLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        contactLabel.topAnchor.constraint(equalTo: stageLabel.bottomAnchor, constant: 20).isActive = true
        contactLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        contactLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        contactLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
    }
}
