//
//  GlossaryDetailViewController.swift
//  venturenotes
//
//  Created by David Doswell on 10/29/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class GlossaryDetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
        hideKeyboardWhenTapped()
    }
    
    let cardView: UIView = {
        let cView = UIView()
        cView.layer.borderColor = UIColor.white.cgColor
        cView.layer.borderWidth = 1.0
        cView.layer.cornerRadius = 10
        cView.backgroundColor = .black
        cView.translatesAutoresizingMaskIntoConstraints = false
        return cView
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.tintColor = .white
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(string: String.titleTextFieldTitle, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.becomeFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = String.descriptionTextFieldTitle
        textView.textColor = .white
        textView.tintColor = .white
        textView.textAlignment = .left
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.autocapitalizationType = .none
        textView.backgroundColor = .black
        textView.becomeFirstResponder()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let urlTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.tintColor = .white
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 18)
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(string: String.urlTextFieldTitle, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.becomeFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.createButtonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = .white
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(createButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.cancelButtonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = .white
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(cancelButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func createButtonTapped(sender: UIButton) {
        //
    }
    
    @objc private func cancelButtonTapped(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextView.text.isEmpty {
            descriptionTextView.text = String.descriptionTextFieldTitle
            descriptionTextView.textColor = .lightGray
        }
        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
    }
    
    private func setUpViews() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "DetailBackground")!)
        
        view.addSubview(cardView)
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextView)
        view.addSubview(urlTextField)
        view.addSubview(createButton)
        view.addSubview(cancelButton)
        
        titleTextField.delegate = self
        descriptionTextView.delegate = self
        urlTextField.delegate = self
        
        cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        titleTextField.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
        titleTextField.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 20).isActive = true
        titleTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 30).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 15).isActive = true
        descriptionTextView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 39).isActive = true
        
        urlTextField.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 50).isActive = true
        urlTextField.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 20).isActive = true
        urlTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        urlTextField.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 50).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        createButton.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 50).isActive = true
        createButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        createButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
}
