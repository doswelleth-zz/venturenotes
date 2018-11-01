//
//  DealViewController.swift
//  venturenotes
//
//  Created by David Doswell on 10/30/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

private let reuseIdentifier = "reuseIdentifier"
private let navigationTitle = String.dealFlowVCTitle

class DealViewController: UIViewController, AVAudioPlayerDelegate {

    let dealController = DealController()
    var sortedDeals: [Deal] = []
    
    private var player: AVAudioPlayer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.sortedDeals = self.dealController.deals.sorted(by: {$0.date > $1.date})
        self.dealController.decode()
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        
        setUpNavBar()
        
        self.title = navigationTitle
        
        self.sortedDeals = self.dealController.deals.sorted(by: {$0.date > $1.date})
        self.dealController.decode()
        self.collectionView.reloadData()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .black
        collectionView.register(DealCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        hideKeyboardWhenTapped()
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let dealCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        dealCollectionView.alwaysBounceVertical = true
        dealCollectionView.showsVerticalScrollIndicator = false
        return dealCollectionView
    }()
    
    private func setUpCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.frame
    }
    
    private func setUpNavBar() {
        let left = UIButton(type: .custom)
        left.setTitle(String.backButton, for: .normal)
        left.setTitleColor(.white, for: .normal)
        left.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        left.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        left.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        left.adjustsImageWhenHighlighted = false
        left.addTarget(self, action: #selector(leftBarButtonTapped(sender:)), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: left)
    }
    
    @objc private func leftBarButtonTapped(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func playButtonTapped(sender: UIButton) {
        let cell = DealCell()
        let isPlaying = player?.isPlaying ?? false
        if isPlaying {
            player?.pause()
            playTimeTimer = nil
        } else {
            let fileURL = Bundle.main.url(forResource: "06 Yellow Submarine", withExtension: "m4a")!
            if (player == nil) {
                player = try! AVAudioPlayer(contentsOf: fileURL)
                player?.delegate = self
            }
            player?.play()
            startPollingPlayTime()
        }
        updateViews(cell: cell)
    }
    
    private func startPollingPlayTime() {
        let cell = DealCell()
        playTimeTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
            self.updateViews(cell: cell)
        })
    }
    
    private func newRecordingURL() -> URL {
        let fm = FileManager.default
        let documentsDir = try! fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return documentsDir.appendingPathComponent(UUID().uuidString).appendingPathExtension("caf")
    }
    
    private var playTimeTimer: Timer? {
        willSet {
            playTimeTimer?.invalidate()
        }
    }
    
    private func updateViews(cell: DealCell) {
        let isPlaying = player?.isPlaying ?? false
        let playButtonTitle = isPlaying ? "Stop" : "▶"
        cell.playButton.setTitle(playButtonTitle, for: .normal)
        
        let currentTime = player?.currentTime ?? 0
        cell.durationLabel.text = String(currentTime)
        
        let components = DateComponentsFormatter()
        components.zeroFormattingBehavior = .pad
        components.allowedUnits = [.second, .minute]
        cell.durationLabel.text = components.string(from: currentTime)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        let cell = DealCell()
        updateViews(cell: cell)
        playTimeTimer = nil
    }
}

extension DealViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sortedDeals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DealCell
        
        let deal = sortedDeals[indexPath.item]
        
        cell.stageLabel.text = deal.stage
        cell.nameTextLabel.text = deal.name
        cell.productLabel.text = deal.product
        cell.playButton.addTarget(self, action: #selector(playButtonTapped(sender:)), for: .touchDragInside)
        
        updateViews(cell: cell)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: 0, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: 0, height: 30)
    }
}

extension DealViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width, height: 375)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20.0
    }
}
