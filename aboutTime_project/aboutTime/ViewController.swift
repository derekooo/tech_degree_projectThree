//
//  ViewController.swift
//  aboutTime
//
//  Created by Tong Wang on 2018-06-06.
//  Copyright © 2018 Tong Wang. All rights reserved.
//

import UIKit
import AudioToolbox


class ViewController: UIViewController {
    
    var gameSound: SystemSoundID = 0
    var gameSoundTwo: SystemSoundID = 0
    var gameSoundThree: SystemSoundID = 0
    var gameSoundFour: SystemSoundID = 0
    var gameSoundFive: SystemSoundID = 0
    var timePerRound = 60
    var timer = Timer()
    var timerOn = false

    let eventManager = EventManager()
    var currentRound:[event]? = nil
    var currentAnswer:[event]? = nil
    
    @IBOutlet weak var firstRowDown: UIButton!
    @IBOutlet weak var secondRowUp: UIButton!
    @IBOutlet weak var secondRowDown: UIButton!
    @IBOutlet weak var thirdRowUp: UIButton!
    @IBOutlet weak var thirdRowDown: UIButton!
    @IBOutlet weak var lastRowUp: UIButton!
    
    
    
    @IBOutlet weak var firstEvent: UILabel!
    @IBOutlet weak var secondEvent: UILabel!
    @IBOutlet weak var thirdEvent: UILabel!
    @IBOutlet weak var lastEvent: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstEvent.layer.masksToBounds = true
        firstEvent.layer.cornerRadius = 5
        secondEvent.layer.masksToBounds = true
        secondEvent.layer.cornerRadius = 5
        thirdEvent.layer.masksToBounds = true
        thirdEvent.layer.cornerRadius = 5
        lastEvent.layer.masksToBounds = true
        lastEvent.layer.cornerRadius = 5
        statusLabel.layer.masksToBounds = true
        statusLabel.layer.cornerRadius = 10
        loadGameStartSound()
        playGameStartSound()
        loadCorrectSound()
        loadIncorrectSound()
        loadButtonUpSound()
        loadButtonDownSound()
        displayEvents()
        loadTime()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //sound effect in game
    
    
    func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "NFF-sublime", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSoundThree)
        
    }
    
    func loadCorrectSound() {
        let path = Bundle.main.path(forResource: "CorrectDing", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    func loadIncorrectSound() {
        let path = Bundle.main.path(forResource: "IncorrectBuzz", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSoundTwo)
    }
    
    func loadButtonUpSound(){
        let path = Bundle.main.path(forResource: "up", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSoundFour)
    }
    
    func loadButtonDownSound(){
        let path = Bundle.main.path(forResource: "down", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSoundFive)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSoundThree)
    }
    func playCorrectSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    func playIncorrectSound() {
        AudioServicesPlaySystemSound(gameSoundTwo)
    }
    func playUpSound() {
        AudioServicesPlaySystemSound(gameSoundFour)
    }
    func playDownSound() {
        AudioServicesPlaySystemSound(gameSoundFive)

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //timer in game
    func loadTime() {
        if !timerOn {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.action), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func action() {
        if timePerRound > 0 {
            timerOn = true
            timePerRound -= 1
            timeLabel.text = "00:\(timePerRound)"
        }
        else{
            timer.invalidate()
            timerOn = false
            loadNextRound(delay: 2)
            eventManager.eventFinished += 1
            let result = eventManager.correctAnswer(events: currentRound!) == currentRound!
            if result {
                eventManager.gameScore += 1
            }
            statusLabel.text = "Running out of Time!"
        
            timePerRound = 60
            timeLabel.text = "00:\(timePerRound)"
        }
        
    }
    func nextRound () {
        if eventManager.eventFinished < eventManager.gameRound {
            displayEvents()
            loadTime()
        }else {
            timer.invalidate()
            performSegue(withIdentifier: "gameOver", sender: self)
            eventManager.gameScore = 0
            eventManager.eventFinished = 0
            displayEvents()
            timePerRound = 60
            timeLabel.text = "00:\(timePerRound)"
            timerOn = false
            loadNextRound(delay: 2)
            // socred show up
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desination = segue.destination as? GameOverViewController {
            desination.gameRound = eventManager.gameRound
            desination.gameScore = eventManager.gameScore
        }
        
    }
    
    func displayEvents() -> Void {
        currentRound = eventManager.generateRound()
        firstEvent.text = currentRound![0].eventIntro
        secondEvent.text = currentRound![1].eventIntro
        thirdEvent.text = currentRound![2].eventIntro
        lastEvent.text = currentRound![3].eventIntro
        timePerRound = 60
        statusLabel.text = "shake to complete"
        statusLabel.backgroundColor = UIColor.clear
    }
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    
    
    
    @IBAction func switchEvent(_ sender: UIButton) {
        if sender == firstRowDown {
            firstEvent.text = currentRound![1].eventIntro
            secondEvent.text = currentRound![0].eventIntro
            currentRound?.swapAt(0, 1)
            playDownSound()
            
        }else if sender == secondRowUp {
            secondEvent.text = currentRound![0].eventIntro
            firstEvent.text = currentRound![1].eventIntro
            currentRound?.swapAt(1, 0)
            playUpSound()
        }else if sender == secondRowDown {
            secondEvent.text = currentRound![2].eventIntro
            thirdEvent.text = currentRound![1].eventIntro
            currentRound?.swapAt(1, 2)
            playDownSound()
        }else if sender == thirdRowUp {
            thirdEvent.text = currentRound![1].eventIntro
            secondEvent.text = currentRound![2].eventIntro
            currentRound?.swapAt(2, 1)
            playUpSound()
        }else if sender == thirdRowDown {
            thirdEvent.text = currentRound![3].eventIntro
            lastEvent.text = currentRound![2].eventIntro
            currentRound?.swapAt(2, 3)
            playDownSound()
        }else {
            lastEvent.text = currentRound![2].eventIntro
            thirdEvent.text = currentRound![3].eventIntro
            currentRound?.swapAt(3, 2)
            playUpSound()
        }
        
    }
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEventSubtype.motionShake {
            let result = eventManager.correctAnswer(events: currentRound!) == currentRound!
            if result {
                eventManager.gameScore += 1
                eventManager.eventFinished += 1
                playCorrectSound()
                statusLabel.backgroundColor = UIColor.green
                statusLabel.textColor = UIColor.white
                statusLabel.text = "good job! Next Round"
                loadNextRound(delay: 2)
                
                
            }else {
                playIncorrectSound()
                eventManager.eventFinished += 1
                statusLabel.backgroundColor = UIColor.red
                statusLabel.text  = "Incorrect order!"
                
                loadNextRound(delay: 2)
                
                
                
            }
            
        }
    }

}

