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
    
    func createDeal(with stage: String, name: String, product: String, contact: String, date: Date) {
        let deal = Deal(stage: stage, name: name, product: product, contact: contact, date: date)
        deals.append(deal)
        encode()
    }
    
    func updateVideoURL(with title: String?, image: Data?, audio: URL?) {
        guard let updatedVideoURL = try? Deal(from: audio as! Decoder) else { return }
        deals.append(updatedVideoURL)
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

private let dealURLList = "dealURLList"

class DealURLController {
    
    private(set) var dealURLs: [DealURL] = []
    
    func createDealURL(with title: String, url: URL, date: Date) {
        let dealURL = DealURL(title: title, url: url, date: date)
        dealURLs.append(dealURL)
        encode()
    }
    
    var url : URL? {
        let fileManager = FileManager()
        let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDirectory.appendingPathComponent(dealURLList)
    }
    
    func encode() {
        do {
            guard let url = url else { return }
            
            let encoder = PropertyListEncoder()
            let dealURLData = try encoder.encode(dealURLs)
            try dealURLData.write(to: url)
        } catch {
            NSLog("Error encoding: \(error)")
        }
    }
    
    func decode() {
        let fileManager = FileManager()
        do {
            guard let url = url, fileManager.fileExists(atPath: url.path) else { return }
            
            let dealURLData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedDealURLs = try decoder.decode([DealURL].self, from: dealURLData)
            dealURLs = decodedDealURLs
        } catch {
            NSLog("Error decoding: \(error)")
        }
    }
}
