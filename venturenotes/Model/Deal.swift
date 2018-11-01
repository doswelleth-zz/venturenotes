//
//  Deal.swift
//  venturenotes
//
//  Created by David Doswell on 10/30/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

struct Deal: Codable, Equatable {
    var stage: String
    var name: String
    var product: String
    var contact: String
    var date: Date
}

struct DealURL: Codable, Equatable {
    var title: String
    var url: URL
    var date: Date
}
