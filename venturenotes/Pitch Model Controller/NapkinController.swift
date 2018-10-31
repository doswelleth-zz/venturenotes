//
//  NapkinController.swift
//  venturenotes
//
//  Created by David Doswell on 10/31/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

private let napkinList = "napkinList"

class NapkinController {
    
    private(set) var napkins: [Napkin] = []
    
    func createNote(title: String, description: String, date: Date) {
        let napkin = Napkin(title: title, description: description, date: date)
        napkins.append(napkin)
        encode()
    }
    
    func delete(napkin: Napkin) {
        guard let index = napkins.index(of: napkin) else { return }
        napkins.remove(at: index)
        encode()
    }
    
    var url : URL? {
        let fileManager = FileManager()
        let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDirectory.appendingPathComponent(napkinList)
    }
    
    func encode() {
        do {
            guard let url = url else { return }
            
            let encoder = PropertyListEncoder()
            let napkinData = try encoder.encode(napkins)
            try napkinData.write(to: url)
        } catch {
            NSLog("Error encoding: \(error)")
        }
    }
    
    func decode() {
        let fileManager = FileManager()
        do {
            guard let url = url, fileManager.fileExists(atPath: url.path) else { return }
            
            let napkinData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedNapkins = try decoder.decode([Napkin].self, from: napkinData)
            napkins = decodedNapkins
        } catch {
            NSLog("Error decoding: \(error)")
        }
    }
}
