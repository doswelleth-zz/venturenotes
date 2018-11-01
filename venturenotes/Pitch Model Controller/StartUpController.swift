//
//  StartUpController.swift
//  venturenotes
//
//  Created by David Doswell on 11/1/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

private let startUpList = "startUpList"

class StartUpController {
    
    private(set) var startups: [StartUp] = []
    
    func createStartUp(name: String, product: String, website: String, contact: String, date: Date) {
        let startUp = StartUp(name: name, product: product, website: website, contact: contact, date: date)
        startups.append(startUp)
        encode()
    }
    
    func delete(startUp: StartUp) {
        guard let index = startups.index(of: startUp) else { return }
        startups.remove(at: index)
        encode()
    }
    
    var url : URL? {
        let fileManager = FileManager()
        let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDirectory.appendingPathComponent(startUpList)
    }
    
    func encode() {
        do {
            guard let url = url else { return }
            
            let encoder = PropertyListEncoder()
            let startUpData = try encoder.encode(startups)
            try startUpData.write(to: url)
        } catch {
            NSLog("Error encoding: \(error)")
        }
    }
    
    func decode() {
        let fileManager = FileManager()
        do {
            guard let url = url, fileManager.fileExists(atPath: url.path) else { return }
            
            let startUpData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedStartUps = try decoder.decode([StartUp].self, from: startUpData)
            startups = decodedStartUps
        } catch {
            NSLog("Error decoding: \(error)")
        }
    }
}
