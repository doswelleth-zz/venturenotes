//
//  GlossaryViewController.swift
//  venturenotes
//
//  Created by David Doswell on 10/29/18.
//  Copyright © 2018 David Doswell. All rights reserved.

import UIKit
import SafariServices

private let reuseIdentifier = "reuseIdentifier"

class GlossaryViewController: UIViewController {
    
    let glossaryController = GlossaryController()
    var sortedTerms: [Glossary] = []
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let noteCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        noteCollectionView.alwaysBounceVertical = true
        noteCollectionView.showsVerticalScrollIndicator = false
        return noteCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        
        setUpNavBar()
        setUpViews()
        
        navigationController?.navigationItem.hidesBackButton = true
    }
    
    private func setUpCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.frame
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonTapped(sender:)))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    @objc private func leftBarButtonTapped(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func rightBarButtonTapped(sender: UIButton) {
        showGlossaryDetail()
    }
    
    private func showGlossaryDetail() {
        let vc = GlossaryDetailViewController()
        self.navigationController?.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    private func setUpViews() {
        view.backgroundColor = Appearance.customBackground
        self.title = String.glossaryVCTitle
    }
}

extension GlossaryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sortedTerms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GlossaryCell
        
        let term = sortedTerms[indexPath.item]
        
        cell.titleLabel.text = term.title
        cell.descriptionLabel.text = term.description
        cell.urlButton.titleLabel?.text = term.url
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let term = sortedTerms[indexPath.item]
        
        let alert = UIAlertController(title: "Delete", message: "Permanently delete your order?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .destructive) { (actio) in
            
            DispatchQueue.main.async {
                self.glossaryController.delete(term: term)
                self.collectionView.reloadData()
            }
        }
        
        let no = UIAlertAction(title: "No", style: .default) { (action) in }
        
        alert.addAction(yes)
        alert.addAction(no)
        present(alert, animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: 0, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: 0, height: 30)
    }
}

extension GlossaryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20.0
    }
}
