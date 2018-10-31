//
//  Deal.swift
//  venturenotes
//
//  Created by David Doswell on 10/30/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

struct Deal: Codable, Equatable {
    var name: String
    var photo: Data
    var stage: String
    var product: String
    var contact: String
}
