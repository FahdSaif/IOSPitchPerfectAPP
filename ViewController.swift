//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Fahd on 01/03/2017.
//  Copyright © 2017 Fahd. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVAudioRecorderDelegate {
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!


    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stopRecordingButton.isEnabled=false
        
        
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func record(_ sender: UIButton) {
        self.recordButton.isEnabled=false
        self.statusLabel.text="Press Stop to finish recording"
        self.stopRecordingButton.isEnabled=true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                          .userDomainMask, true)[0] as String
        
        let recordingName = "recordedVoice.wav"
        
        
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        
        let session = AVAudioSession.sharedInstance()
        
        
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:.defaultToSpeaker)
        
        
//        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:]) audioRecorder.isMeteringEnabled = true
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        
audioRecorder.delegate=self
        
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
        
        
    }
    
    @IBAction func stop(_ sender: UIButton) {
        self.recordButton.isEnabled=true
        self.stopRecordingButton.isEnabled=false
        self.statusLabel.text="Press to Start recording"
        
        audioRecorder.stop()
        
        let audioSession=AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
        
        
    }
    

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        //print("finished recording")
        if flag{
            self.performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
            
        }else{
            print("recording was not sucessful")
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="stopRecording"
        {
            let playSoundsVC=segue.destination as! PlaySoundsViewController
            let recordedAudioURL=sender as! URL
            playSoundsVC.recordedAudioURL=recordedAudioURL
    }
    }
}

