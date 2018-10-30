//
//  GlossaryCell.swift
//  venturenotes
//
//  Created by David Doswell on 10/29/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class GlossaryCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Angel"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Accredited Early Stage Investor"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let urlButton: UIButton = {
        let button = UIButton()
        button.setTitle("Learn", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = .white
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        
        backgroundColor = Appearance.customBackground
        
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(urlButton)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        urlButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30).isActive = true
        urlButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true
        urlButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        urlButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
