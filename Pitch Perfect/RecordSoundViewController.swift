//
//  RecordSoundViewController.swift
//  Pitch Perfect
//
//  Created by Meemi on 07/05/2021.
//

import UIKit
// Audio and video framework
import AVFoundation

class RecordSoundViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    // Properties
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(recording: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // MARK: - IBActions
    
    // IBAction for record button
    @IBAction func recordButtonTapped(_ sender: Any) {
        configureUI(recording: true)

        // get application document directory path
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        // recording file name
        let recordingName = "recordedVoice.wav"
        
        // combine directory path with recording name to create a full path
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        if let filePath = filePath {
            print(filePath)
        }
        
        // setup audio session
        let session = AVAudioSession.sharedInstance()
        // sets up the session for playing and recording audio
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    // IBAction for stop button
    @IBAction func stopButtonTapped(_ sender: Any) {
        configureUI(recording: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    // Prepare segue function to pass audio to next VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPlayback" {
            let destinationVC = segue.destination as! PlayBackViewController
            destinationVC.recordedAudioURL = sender as! URL
        }
    }
    
    // Function to configure UI according to app state whether recording or not
    func configureUI(recording: Bool) {
        if recording {
            stopButton.isEnabled = true
            recordButton.isEnabled = false
            recordLabel.text = "Recording in Progress..."
        } else {
            stopButton.isEnabled = false
            recordButton.isEnabled = true
            recordLabel.text = "Tap to Record"
        }
    }
    
    
}

// MARK: - AVAudio Recorder Delegate
extension RecordSoundViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
        // perform segue
        performSegue(withIdentifier: "goToPlayback", sender: audioRecorder.url)
        } else {
            print("Recording was not successful")
        }
    }
}

