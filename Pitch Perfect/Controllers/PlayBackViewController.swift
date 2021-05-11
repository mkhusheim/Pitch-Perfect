//
//  PlayBackViewController.swift
//  Pitch Perfect
//
//  Created by Meemi on 08/05/2021.
//

import UIKit
import AVFoundation

class PlayBackViewController: UIViewController {
    // IBOutlets
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darthButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // Property Declaraions
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    var recordedAudioURL: URL!
    let debugMode: Bool = true
    enum ButtonType: Int { case slow = 0, fast, chipmunk, darth, echo, reverb }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureButtons()
        configureUI(playState: .NotPlaying)
    }
    
    // MARK: - IBActions
    
    // IBAction for playing sounds buttons
    @IBAction func playSoundForButton(_ sender: UIButton) {
        // Case
        switch(ButtonType(rawValue: sender.tag)!) {
            case .slow:
                playSound(rate: 0.5)
            case .fast:
                playSound(rate: 1.5)
            case .chipmunk:
                playSound(pitch: 1000)
            case .darth:
                playSound(pitch: -1000)
            case .echo:
                playSound(echo: true)
            case .reverb:
                playSound(reverb: true)
            }

        configureUI(playState: .Playing)
    }
    
    // IBAction for stop button
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        stopAudio()
    }
    
    // Configure button image function
    func configureButtons() {
        snailButton.imageView!.contentMode = .scaleAspectFit
        rabbitButton.imageView!.contentMode = .scaleAspectFit
        chipmunkButton.imageView!.contentMode = .scaleAspectFit
        darthButton.imageView!.contentMode = .scaleAspectFit
        echoButton.imageView!.contentMode = .scaleAspectFit
        reverbButton.imageView!.contentMode = .scaleAspectFit
    }
}
