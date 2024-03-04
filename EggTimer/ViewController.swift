//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer!
    var secondsRemaining = 0
    var totalTime = 0
    var timer = Timer()
    
    let eggTime: [String: Int] = [
        "Soft": 300,
        "Medium": 420,
        "Hard": 720
    ]
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countdownTimer), userInfo: nil, repeats: true)
    }
    
    @objc func countdownTimer() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            progressBar.progress = (Float(secondsRemaining) / Float(totalTime))
        } else {
            timer.invalidate()
            topLabel.text = "Done!"
            playSound()
        }
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        
        timer.invalidate()
        topLabel.text = hardness
        secondsRemaining = eggTime[hardness]!
        totalTime = secondsRemaining
        startTimer()
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
