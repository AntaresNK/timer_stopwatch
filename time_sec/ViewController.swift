//
//  ViewController.swift
//  time_sec
//
//  Created by Nazym Sayakhmet on 14.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var time = 0
    var counter = 1
    var pauseTime = 0
    var pauseSec = 0
    var startTime = 0
    var timer = Timer()
    var isTimeRunning = false
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        timeLabel.text = timeToString(timeSec: 0)
    }
    
    @IBAction func segmentControl(_ sender: Any) {
    
        if (sender as AnyObject).selectedSegmentIndex == 0 {
            
            clean()
            counter = 1

        }
        
        if (sender as AnyObject).selectedSegmentIndex == 1 {
            
            clean()
            counter = 2
        }
    }
    
    @IBAction func start(_ sender: Any) {
        if isTimeRunning {
            return
        }
        if counter == 1 {
            time = 10
            
            if pauseTime != 0 {
                time = pauseTime
            }
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countTimer), userInfo: nil, repeats: true)
                
            }
        else if counter == 2 {
            time = 0
            if pauseSec != 0 {
                time = pauseSec
            }
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countStopwatch), userInfo: nil, repeats: true)
        }
                isTimeRunning = true
        }
    
    @objc func countTimer() {
        time -= 1
        timeLabel.text = timeToString(timeSec: time)
        
        if time == 0 {
            timer.invalidate()
            isTimeRunning = false
        }
    }
    
    @objc func countStopwatch() {
        time += 1
        timeLabel.text = timeToString(timeSec: time)
        
    }
    
    
    @IBAction func pause(_ sender: Any) {
        
        if counter == 1 {
            pauseTime = time
        } else if counter == 2 {
            pauseSec = time
        }
        timer.invalidate()
        isTimeRunning = false
    }
    
    @IBAction func stop(_ sender: Any) {
       clean()
    }
    
    func timeToString(timeSec: Int) -> String {
        let sec = timeSec % 60
        let min = timeSec / 60 % 60
        let hour = timeSec / 60 / 60
        
        return String(format: "%0.2d:%0.2d:%0.2d", hour, min, sec)
    }
    
    
    func clean() {
        timer.invalidate()
        time = 0
        pauseTime = 0
        pauseSec = 0
        isTimeRunning = false
        timeLabel.text = timeToString(timeSec: time)
        
    }
}
