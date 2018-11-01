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
    
    let nameTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
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
    
    let stageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 18)
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
        
        addSubview(nameTextLabel)
        addSubview(productLabel)
        addSubview(stageLabel)
        addSubview(contactLabel)
        
        nameTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        nameTextLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        nameTextLabel.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
        nameTextLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        productLabel.topAnchor.constraint(equalTo: nameTextLabel.bottomAnchor, constant: 20).isActive = true
        productLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        productLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        productLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        stageLabel.topAnchor.constraint(equalTo: productLabel.bottomAnchor, constant: 20).isActive = true
        stageLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        stageLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        stageLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        contactLabel.topAnchor.constraint(equalTo: stageLabel.bottomAnchor, constant: 20).isActive = true
        contactLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        contactLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        contactLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
    }
}
