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
    
    var player : AVAudioPlayer!
    
    var time = Timer()
    
    var totalTime : Float = 0
    
    var usedTime : Float = 0
    
    let eggTimes = [
        "Soft" : 20,
        "Medium" : 130,
        "Hard" : 150
    ]
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var progressBar: UIProgressView!
    
    @IBAction func setEggTimer(_ sender: UIButton) {
        
        time.invalidate()
        
        usedTime = 0
        
        totalTime = 0
        
        progressBar.progress = 1.0
        
        playAlarm().stop()
        
        self.titleLabel.text = "How do you like your eggs?"
        
        let eggState : String? = sender.currentTitle
        
        self.totalTime = Float(eggTimes[eggState!]!)
        
        time = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        //example functionality
        if usedTime < totalTime {
            print("\(usedTime)")
            usedTime += 1
            progressBar.progress = 1.0 - usedTime / totalTime
        } else {
            self.titleLabel.text = "Ready to Eat"
            playAlarm().play()
        }
    }
    
    func playAlarm() -> AVAudioPlayer {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        return player
    }
}
