//
//  GlossaryTableViewController.swift
//  venturenotes
//
//  Created by David Doswell on 10/30/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import SafariServices

private let reuseIdentifier = "reuseIdentifier"
private let navigationTitle = String.glossaryVCTitle

class GlossaryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = navigationTitle

        setUpNavBar()
        
        tableView.separatorColor = .white
        tableView.backgroundColor = Appearance.customBackground
        tableView.showsVerticalScrollIndicator = false
        tableView.register(GlossaryCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    let sections = SectionStrings().sections
    var array = ArrayStrings().array
    let detailArray = DetailArrayStrings().detailArray
    
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
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
        sectionView.backgroundColor = .black
        
        let label = UILabel(frame: CGRect(x: 10, y: 7, width: view.frame.size.width, height: 25))
        label.text = self.sections[section]
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        sectionView.addSubview(label)
        
        return sectionView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sections == sections {
            return array[section].count
        }
        return detailArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! GlossaryCell
        
        let name = array[indexPath.section][indexPath.row]
        cell.textLabel?.text = name
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        cell.textLabel?.textColor = .white
        
        let detailName = detailArray[indexPath.section][indexPath.row]
        cell.detailTextLabel?.text = detailName
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.detailTextLabel?.textColor = .white
        cell.detailTextLabel?.numberOfLines = 0
        
        cell.selectionStyle = .none
        cell.backgroundColor = Appearance.customBackground
        
        return cell
    }

}
