//
//  PrototypeController.swift
//  venturenotes
//
//  Created by David Doswell on 10/31/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

private let prototypeList = "prototypeList"

class PrototypeController {
    
    private(set) var prototypes: [Prototype] = []
    
    func createPrototype(url: URL, date: Date) {
        let prototype = Prototype(url: url, date: date)
        prototypes.append(prototype)
        encode()
    }
    
    func delete(prototype: Prototype) {
        guard let index = prototypes.index(of: prototype) else { return }
        prototypes.remove(at: index)
        encode()
    }
    
    var url : URL? {
        let fileManager = FileManager()
        let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDirectory.appendingPathComponent(prototypeList)
    }
    
    func encode() {
        do {
            guard let url = url else { return }
            
            let encoder = PropertyListEncoder()
            let prototypeData = try encoder.encode(prototypes)
            try prototypeData.write(to: url)
        } catch {
            NSLog("Error encoding: \(error)")
        }
    }
    
    func decode() {
        let fileManager = FileManager()
        do {
            guard let url = url, fileManager.fileExists(atPath: url.path) else { return }
            
            let prototypeData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedPrototypes = try decoder.decode([Prototype].self, from: prototypeData)
            prototypes = decodedPrototypes
        } catch {
            NSLog("Error decoding: \(error)")
        }
    }
    
}
