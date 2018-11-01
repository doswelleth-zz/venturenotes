//
//  NapkinViewController.swift
//  venturenotes
//
//  Created by David Doswell on 10/30/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

private let navigationTitle = String.napkinVCTitle

class NapkinViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = navigationTitle
        
        setUpNavBar()
        setUpViews()
        
        hideKeyboardWhenTapped()
        
        self.navigationController?.navigationItem.hidesBackButton = true
    }
    
    var dealController: DealController?
    
    let cardView: UIView = {
        let cView = UIView()
        cView.layer.borderColor = UIColor.white.cgColor
        cView.layer.borderWidth = 1.0
        cView.layer.cornerRadius = 10
        cView.backgroundColor = .black
        cView.translatesAutoresizingMaskIntoConstraints = false
        return cView
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.tintColor = .white
        textField.textAlignment = .center
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(string: String.nameYourIdeaTextFieldTitle, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.becomeFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let productTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.tintColor = .black
        textView.textAlignment = .left
        textView.layer.cornerRadius = 10
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.backgroundColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let stageTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.tintColor = .white
        textField.textAlignment = .center
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(string: String.stageTextFieldTitle, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.becomeFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let contactTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.tintColor = .white
        textField.textAlignment = .center
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(string: String.contactTextFieldTitle, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.becomeFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let pitchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.pitchButtonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = .white
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(pitchButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func pitchButtonTapped(sender: UIButton) {
        if nameTextField.text!.isEmpty || productTextView.text.isEmpty {
            let alert = UIAlertController(title: "Error", message: "Please enter all fields correctly", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            guard let name = nameTextField.text,
                let product = productTextView.text,
                let stage = stageTextField.text,
                let contact = contactTextField.text else { return }
            
            dealController?.createDeal(with: name, product: product, stage: stage, contact: contact)
        }
        presentHomeVC()
    }
    
    private func presentHomeVC() {
        let vc = HomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
        
        view.addSubview(cardView)
        view.addSubview(nameTextField)
        view.addSubview(productTextView)
        view.addSubview(stageTextField)
        view.addSubview(contactTextField)
        view.addSubview(pitchButton)
        
        nameTextField.delegate = self
        
        
        cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        productTextView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30).isActive = true
        productTextView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        productTextView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        productTextView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        stageTextField.topAnchor.constraint(equalTo: productTextView.topAnchor, constant: 20).isActive = true
        stageTextField.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        stageTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        stageTextField.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        contactTextField.topAnchor.constraint(equalTo: stageTextField.topAnchor, constant: 20).isActive = true
        contactTextField.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        contactTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        contactTextField.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        pitchButton.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 50).isActive = true
        pitchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pitchButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        pitchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}
