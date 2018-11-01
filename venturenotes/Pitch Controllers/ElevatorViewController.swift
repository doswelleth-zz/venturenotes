//
//  ElevatorViewController.swift
//  venturenotes
//
//  Created by David Doswell on 10/30/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import AVFoundation

private let navigationTitle = String.elevatorVCTitle

class ElevatorViewController: UIViewController, UITextFieldDelegate, AVAudioPlayerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = navigationTitle
        
        setUpNavBar()
        setUpViews()
        
        hideKeyboardWhenTapped()
        
        self.navigationController?.navigationItem.hidesBackButton = true
    }
    
    var dealURLController: DealURLController?

    private var player: AVAudioPlayer?
    private var recorder: AVAudioRecorder?
    
    let cardView: UIView = {
        let cView = UIView()
        cView.layer.borderColor = UIColor.white.cgColor
        cView.layer.borderWidth = 1.0
        cView.layer.cornerRadius = 10
        cView.backgroundColor = .black
        cView.translatesAutoresizingMaskIntoConstraints = false
        return cView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let date = Date()
    let formatter = DateFormatter()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.tintColor = .white
        textField.textAlignment = .center
        textField.font = UIFont.boldSystemFont(ofSize: 22)
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(string: String.nameYourElevatorTextFieldTitle, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.becomeFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let recordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.recordButtonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = .white
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(recordButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.forwardButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = .black
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(playButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pitchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.pitchButtonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = .white
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(pitchButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func recordButtonTapped(sender: UIButton) {
        let isRecording = recorder?.isRecording ?? false
        if isRecording {
            recorder?.stop()
            if let url = recorder?.url {
                player = try! AVAudioPlayer(contentsOf: url)
                player?.delegate = self
            }
        } else {
            let format = AVAudioFormat(standardFormatWithSampleRate: 44100.0, channels: 1)
            recorder = try! AVAudioRecorder(url: newRecordingURL(), format: format!)
            recorder?.record()
        }
        updateViews()
    }
    
    @objc private func playButtonTapped(sender: UIButton) {
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
        updateViews()
    }
    
    @objc private func pitchButtonTapped(sender: UIButton) {
        if titleTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Error", message: "Please name your pitch", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
        guard let title = titleTextField.text, let url = recorder?.url else { return }
        dealURLController?.createDealURL(with: title, url: url, date: Date())
        }
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        updateViews()
        playTimeTimer = nil
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        
        let isPlaying = player?.isPlaying ?? false
        let playButtonTitle = isPlaying ? "Stop" : "▶"
        playButton.setTitle(playButtonTitle, for: .normal)
        
        let isRecording = recorder?.isRecording ?? false
        let recordButtonTitle = isRecording ? "Stop Recording" : "Record Your Pitch"
        recordButton.setTitle(recordButtonTitle, for: .normal)
        
        let currentTime = player?.currentTime ?? 0
        durationLabel.text = String(currentTime)
        
        let components = DateComponentsFormatter()
        components.zeroFormattingBehavior = .pad
        components.allowedUnits = [.second, .minute]
        durationLabel.text = components.string(from: currentTime)
    }
    
    private func startPollingPlayTime() {
        playTimeTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
            self.updateViews()
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
    
    private func setUpViews() {
        view.backgroundColor = Appearance.customBackground
        
        view.addSubview(cardView)
        view.addSubview(dateLabel)
        view.addSubview(titleTextField)
        view.addSubview(recordButton)
        view.addSubview(playButton)
        view.addSubview(durationLabel)
        view.addSubview(pitchButton)
        
        titleTextField.delegate = self
        
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        dateLabel.text = formatter.string(from: date)

        cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 175.0).isActive = true
        cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        titleTextField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20).isActive = true
        titleTextField.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        titleTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        recordButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 30).isActive = true
        recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recordButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        recordButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        playButton.topAnchor.constraint(equalTo: recordButton.bottomAnchor, constant: 50).isActive = true
        playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        durationLabel.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 20).isActive = true
        durationLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        durationLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        durationLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        pitchButton.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 50).isActive = true
        pitchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pitchButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        pitchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}
