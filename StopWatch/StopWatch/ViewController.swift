//
//  ViewController.swift
//  StopWatch
//
//  Created by Patrick O'brien on 3/3/19.
//  Copyright © 2019 Patrick O'brien. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var isPlaying = false
    var counter = 0.0
    var lapCounter = 0.0
    var timer = Timer()
    var laps = [String]()
    var lapString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        lapTableView.delegate = self
        lapTableView.dataSource = self
        stopwatchLabel.text = "00:00.00"
        pauseButton.isEnabled = false
        resetButton.isEnabled = false
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func startButtonPressed(_ sender: UIButton) {
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
        isPlaying = true
        startButton.isEnabled = false
        pauseButton.isEnabled = true
        resetButton.isEnabled = true
        lapButton.isEnabled = true
    }
    
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
        startButton.isEnabled = true
        lapButton.isEnabled = false
        timer.invalidate()
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        timer.invalidate()
        isPlaying = false
        stopwatchLabel.text = "00:00.00"
        counter = 0.0
        startButton.isEnabled = true
        resetButton.isEnabled = false
        pauseButton.isEnabled = false
        laps = [String]()
        lapTableView.reloadData()
    }
    @IBAction func lapButtonPressed(_ sender: UIButton) {

        laps.append(lapString!)
        lapCounter = 0.0
    }
    
    @IBOutlet weak var lapButton: UIButton!
    @IBOutlet weak var lapTableView: UITableView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopwatchLabel: UILabel!
    
    
    @objc func runTimer(){
        counter += 0.01
        lapCounter += 0.01
        lapTableView.reloadData()
        
        let flooredCounter = Int(floor(counter))
        let flooredLapCounter = Int(floor(lapCounter))
        
   
        
        let lapMinute = (flooredLapCounter % 3600) / 60
        var lapMinuteString = "\(lapMinute)"
        
        if lapMinute < 10 {
            lapMinuteString = "0\(lapMinute)"
        }
        
        let lapSecond = (flooredLapCounter % 3600) % 60
        var lapSecondString = "\(lapSecond)"
        if lapSecond < 10 {
            lapSecondString = "0\(lapSecond)"
        }
        
        let lapDecisecond = String(format: "%.2f", lapCounter).components(separatedBy: ".").last!
        

        lapString = "\(lapMinuteString):\(lapSecondString).\(lapDecisecond)"
        
    
        
        
        
        
        
        
        
        
        
        let hour = flooredCounter / 3600
        var hourString = "\(hour)"
        
        
        
        
        
        
        if hour < 10 {
            hourString = "0\(hour)"
        }
        
        let minute = (flooredCounter % 3600) / 60
        var minuteString = "\(minute)"
        
        if minute < 10 {
            minuteString = "0\(minute)"
        }
        
        let second = (flooredCounter % 3600) % 60
        var secondString = "\(second)"
        if second < 10 {
            secondString = "0\(second)"
        }
        
        let decisecond = String(format: "%.2f", counter).components(separatedBy: ".").last!
        
        if hour > 1 {
            stopwatchLabel.text = "\(hourString):\(minuteString):\(secondString).\(decisecond)"
        } else {
            stopwatchLabel.text = "\(minuteString):\(secondString).\(decisecond)"
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.detailTextLabel!.text = laps[indexPath.row]
        cell.textLabel!.text = "Lap \(indexPath.row + 1)"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func numberOfSections(in lapTableView: UITableView) -> Int {
        return 1
    }
    
    
    
}








