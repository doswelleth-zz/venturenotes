//
//  DealController.swift
//  venturenotes
//
//  Created by David Doswell on 10/30/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

private let dealList = "dealList"

class DealController {
    
    private(set) var deals: [Deal] = []
    
    func createDeal(with name: String, product: String, stage: String, contact: String) {
        let deal = Deal(name: name, product: product, stage: stage, contact: contact)
        deals.append(deal)
        encode()
    }
    
    func delete(deal: Deal) {
        guard let index = deals.index(of: deal) else { return }
        deals.remove(at: index)
        encode()
    }
    
    var url : URL? {
        let fileManager = FileManager()
        let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDirectory.appendingPathComponent(dealList)
    }
    
    func encode() {
        do {
            guard let url = url else { return }
            
            let encoder = PropertyListEncoder()
            let dealData = try encoder.encode(deals)
            try dealData.write(to: url)
        } catch {
            NSLog("Error encoding: \(error)")
        }
    }
    
    func decode() {
        let fileManager = FileManager()
        do {
            guard let url = url, fileManager.fileExists(atPath: url.path) else { return }
            
            let dealData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedDeals = try decoder.decode([Deal].self, from: dealData)
            deals = decodedDeals
        } catch {
            NSLog("Error decoding: \(error)")
        }
    }
}
