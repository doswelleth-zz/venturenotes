//
//  URLs.swift
//  venturenotes
//
//  Created by David Doswell on 10/29/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import SafariServices

extension GlossaryTableViewController {
    func showDetailView() {
        if let url = URL(string: "") {
            let configuration = SFSafariViewController.Configuration()
            configuration.barCollapsingEnabled = false
            
            let safariViewController = SFSafariViewController(url: url, configuration: configuration)
            safariViewController.preferredBarTintColor = .white
            safariViewController.preferredControlTintColor = Appearance.customBackground
            present(safariViewController, animated: true)
        }
    }
}
