//
//  ElevatorController.swift
//  venturenotes
//
//  Created by David Doswell on 10/31/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

private let elevatorList = "elevatorList"

class ElevatorController {
    
    private(set) var elevators: [Elevator] = []
    
    func createElevator(title: String, url: URL, date: Date) {
        let elevator = Elevator(title: title, url: url, date: date)
        elevators.append(elevator)
        encode()
    }
    
    func delete(elevator: Elevator) {
        guard let index = elevators.index(of: elevator) else { return }
        elevators.remove(at: index)
        encode()
    }
    
    var url : URL? {
        let fileManager = FileManager()
        let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDirectory.appendingPathComponent(elevatorList)
    }
    
    func encode() {
        do {
            guard let url = url else { return }
            
            let encoder = PropertyListEncoder()
            let elevatorData = try encoder.encode(elevators)
            try elevatorData.write(to: url)
        } catch {
            NSLog("Error encoding: \(error)")
        }
    }
    
    func decode() {
        let fileManager = FileManager()
        do {
            guard let url = url, fileManager.fileExists(atPath: url.path) else { return }
            
            let elevatorData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedElevators = try decoder.decode([Elevator].self, from: elevatorData)
            elevators = decodedElevators
        } catch {
            NSLog("Error decoding: \(error)")
        }
    }
    
}
