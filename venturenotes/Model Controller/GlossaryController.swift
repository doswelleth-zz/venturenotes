//
//  GlossaryController.swift
//  venturenotes
//
//  Created by David Doswell on 10/29/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

private let termsList = "termsList"

class GlossaryController {
    
    private(set) var terms: [Glossary] = []
    
    func create(with title: String, description: String, url: String) {
        let term = Glossary(title: title, description: description, url: url)
        terms.append(term)
        encode()
    }
    
    func delete(term: Glossary) {
        guard let index = terms.index(of: term) else { return }
        terms.remove(at: index)
        encode()
    }
    
    var url : URL? {
        let fileManager = FileManager()
        let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDirectory.appendingPathComponent(termsList)
    }
    
    func encode() {
        do {
            guard let url = url else { return }
            
            let encoder = PropertyListEncoder()
            let termData = try encoder.encode(terms)
            try termData.write(to: url)
        } catch {
            NSLog("Error encoding: \(error)")
        }
    }
    
    func decode() {
        let fileManager = FileManager()
        do {
            guard let url = url, fileManager.fileExists(atPath: url.path) else { return }
            
            let termData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedTerms = try decoder.decode([Glossary].self, from: termData)
            terms = decodedTerms
        } catch {
            NSLog("Error decoding: \(error)")
        }
    }
}
