//
//  ViewController.swift
//  CatchTheSpongeBobGame
//
//  Created by Berkay Kazkılınç on 2.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var bob1: UIImageView!
    @IBOutlet weak var bob2: UIImageView!
    @IBOutlet weak var bob3: UIImageView!
    @IBOutlet weak var bob4: UIImageView!
    @IBOutlet weak var bob5: UIImageView!
    @IBOutlet weak var bob6: UIImageView!
    @IBOutlet weak var bob7: UIImageView!
    @IBOutlet weak var bob8: UIImageView!
    @IBOutlet weak var bob9: UIImageView!
    
    // Variables
    var score = 0
    var highScore = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var spongeBobArray = [UIImageView]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score : \(score)"
        
        // High Score Checked
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "High Score : \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "High Score : \(highScore)"
        }
        
        
        // Images
        bob1.isUserInteractionEnabled = true // Tıklanmayı etkin hale getiriyor
        bob2.isUserInteractionEnabled = true
        bob3.isUserInteractionEnabled = true
        bob4.isUserInteractionEnabled = true
        bob5.isUserInteractionEnabled = true
        bob6.isUserInteractionEnabled = true
        bob7.isUserInteractionEnabled = true
        bob8.isUserInteractionEnabled = true
        bob9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action:   #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action:   #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action:   #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action:   #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action:   #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action:   #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action:   #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action:   #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action:   #selector(increaseScore))
        
        bob1.addGestureRecognizer(recognizer1)
        bob2.addGestureRecognizer(recognizer2)
        bob3.addGestureRecognizer(recognizer3)
        bob4.addGestureRecognizer(recognizer4)
        bob5.addGestureRecognizer(recognizer5)
        bob6.addGestureRecognizer(recognizer6)
        bob7.addGestureRecognizer(recognizer7)
        bob8.addGestureRecognizer(recognizer8)
        bob9.addGestureRecognizer(recognizer9)
        
        
        spongeBobArray = [bob1,bob2,bob3,bob4,bob5,bob6,bob7,bob8,bob9]
        
        
        
        //Timer
        counter = 5
        timeLabel.text = "Time : \(counter)"
        
        timeStarter()
        
        hideSpongeBob()
        
    }
    
    func timeStarter (){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true) // zamanlayıcıyı baslat
        hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(hideSpongeBob), userInfo: nil, repeats: true) // zamanlayıcıyı baslat
    }

    
    @objc func hideSpongeBob(){
        
        for spongeBob in spongeBobArray{
            spongeBob.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(spongeBobArray.count - 1)))
        spongeBobArray[random].isHidden = false
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score : \(score)"
    }

    @objc func countDown(){
        counter -= 1
        timeLabel.text = "Time : \(counter)"
        
        if counter == 0 {
            timer.invalidate() // zamanlayıcıyı durdurur
            hideTimer.invalidate()
            
            for spongeBob in spongeBobArray{
                spongeBob.isHidden = true
            }
            
            // High Score
            if score > highScore {
                highScore = score
            }
            highScoreLabel.text = "High Score : \(highScore)"
            UserDefaults.standard.set(highScore, forKey: "highscore")
            
            // Alert
            
            let alert = UIAlertController(title: "Times Up", message: "Do you want to play again ?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                //replay function
                
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 5
                self.timeLabel.text = "Time : \(self.counter)"
                
                self.timeStarter()
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true)
        }
        
       
        
        
        
    }
    
    
}

