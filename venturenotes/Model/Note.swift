//
//  Note.swift
//  venturenotes
//
//  Created by David Doswell on 10/29/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

struct Note: Codable, Equatable {
    var text: String
    var reference: String
    var date: Date
}
