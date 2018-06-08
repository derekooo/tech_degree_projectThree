//
//  GameOverViewController.swift
//  aboutTime
//
//  Created by Tong Wang on 2018-06-08.
//  Copyright © 2018 Tong Wang. All rights reserved.
//

import UIKit
import AudioToolbox

class GameOverViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    var gameRound = 0
    var gameScore = 0
    var gameSound: SystemSoundID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "You score: \(gameScore)/\(gameRound)"
        loadGameoverSound()
        playGameoverSound()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadGameoverSound() {
        let path = Bundle.main.path(forResource: "NFF-surpriser", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    func playGameoverSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    @IBAction func restGame(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
