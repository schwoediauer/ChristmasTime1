//
//  ViewController.swift
//  ChristmasTime
//
//  Created by Juergen Schwoediauer on 06.11.17.
//  Copyright © 2017 Juergen Schwoediauer. All rights reserved.
//

import UIKit
import SJExtension

class ViewController: UIViewController {
    
    @IBOutlet weak var waittime: UILabel!
    @IBOutlet weak var greetings: UILabel!
    @IBOutlet weak var backgound: UIImageView!
    @IBOutlet weak var candle1: UIImageView!
    @IBOutlet weak var candle2: UIImageView!
    @IBOutlet weak var candle3: UIImageView!
    @IBOutlet weak var candle4: UIImageView!
    
    
    let benutzerGeraeteName = UIDevice.current.name
    
    var refresh = Timer()
    var tempCount: Int = 1
    
    func drawAdventCandle(today: Date) {
        
        //destroy all candles --------------------
        candle1.isHidden = true
        candle2.isHidden = true
        candle3.isHidden = true
        candle4.isHidden = true
        
        let newDay = DateTool()
        
        switch newDay.checkAdventWeek(checkDate: today) {
        case 1:
            candle1.isHidden = false
        case 2:
            candle1.isHidden = false
            candle2.isHidden = false
        case 3:
            candle1.isHidden = false
            candle2.isHidden = false
            candle3.isHidden = false
        case 4:
            candle1.isHidden = false
            candle2.isHidden = false
            candle3.isHidden = false
            candle4.isHidden = false
        default:
            candle1.isHidden = true
            candle2.isHidden = true
            candle3.isHidden = true
            candle4.isHidden = true
        }
    }
    
    
    //timer function with core code ----------------------
    @objc func runRefreshCode() {
        
        let yet = Date()
        let today = DateTool()
        let dayTime = today.CheckDayTime(checkDate: yet)
        
        switch dayTime {
        case "Früh":
            backgound.alpha = 0.7
            backgound.backgroundColor = UIColor.darkGray
            greetings.text = "Noch sehr früh " + benutzerGeraeteName
        case "Morgen":
            backgound.alpha = 0.7
            backgound.backgroundColor = UIColor.lightGray
            greetings.text = "Guten Morgen " + benutzerGeraeteName
        case "Vormittag":
            backgound.backgroundColor = UIColor.white
            backgound.alpha = 1.0
            greetings.text = "Schönen Vormittag " + benutzerGeraeteName
        case "Mittag":
            backgound.backgroundColor = UIColor.white
            backgound.alpha = 1.0
            greetings.text = "Mahlzeit " + benutzerGeraeteName
        case "Nachmittag":
            backgound.backgroundColor = UIColor.white
            backgound.alpha = 1.0
            greetings.text = "Schönen Nachmittag " + benutzerGeraeteName
        case "Abend":
            backgound.alpha = 0.7
            backgound.backgroundColor = UIColor.lightGray
            greetings.text = "Ruhigen Feierabend " + benutzerGeraeteName
        case "Nacht":
            backgound.alpha = 0.7
            backgound.backgroundColor = UIColor.darkGray
            greetings.text = "Gute Nacht " + benutzerGeraeteName
        default:
            backgound.backgroundColor = UIColor.white
            backgound.alpha = 1.0
            greetings.text = "Hallo " + benutzerGeraeteName
        }
        
        let now = NSDate()
        
        //MARK: create christmas date ==================
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let christmas = dateFormatter.date(from: "2017-12-24 23:59")!
        
        let calendar = Calendar.current
        let anchorComponents = calendar.dateComponents([.day, .month, .year, .hour], from: now as Date, to: christmas)
        
        var tempYears = ""
        var tempMonths = ""
        var tempDays = ""
        
        if anchorComponents.year! > 1  {
            tempYears = String(describing: anchorComponents.year!) + " Jahre "
        }
        else if anchorComponents.year! == 1 {
            tempYears = String(describing: anchorComponents.year!) + " Jahr "
        }
        
        if anchorComponents.month! > 1 {
            tempMonths = String(describing: anchorComponents.month!) + " Monate "
        }
        else if anchorComponents.month! == 1{
            tempMonths = String(describing: anchorComponents.month!) + " Monat "
        }
        
        if anchorComponents.day! > 1 {
            tempDays = String(describing: anchorComponents.day!) + " Tage "
        }
        else if anchorComponents.day! == 1 {
            tempDays = String(describing: anchorComponents.day!) + " Tag "
        }
        
        waittime.text = tempYears + tempMonths + tempDays
        drawAdventCandle(today: now as Date)
        
    }
    
    
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UI initialisation --------------------------
        candle1.isHidden = true
        candle2.isHidden = true
        candle3.isHidden = true
        candle4.isHidden = true
        greetings.text = "Hallo " + benutzerGeraeteName
        
        // Background initialisiern ------------
        backgound.backgroundColor = UIColor.white
        backgound.alpha = 1.0
        
        
        /*/load image from URL ------------------------------------------------------
        
        if let url = NSURL(string: "http://85.233.100.73/ELSI/Dev/christmas.jpg") {
            if let data = NSData(contentsOf: url as URL) {
                self.backgound.image = UIImage(data: data as Data)
            }
        } else {
            print("Error loading background image")
        }
        
        //end load image from URL --------------------------------------------------
        */
        
        
        //Refresh Timer definieren -------------------
        refresh = Timer.scheduledTimer(timeInterval: 600, target: self, selector: #selector(runRefreshCode), userInfo: nil, repeats: true)
        
        // initial run of timer -------------------
        runRefreshCode()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

