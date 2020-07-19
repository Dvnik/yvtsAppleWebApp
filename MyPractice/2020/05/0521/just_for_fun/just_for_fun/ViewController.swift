//
//  ViewController.swift
//  just_for_fun
//
//  Created by Trixie Lulamoon on 2020/5/21.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    
    @IBOutlet weak var dice_image: NSImageView!
    @IBOutlet weak var imgDice2: NSImageView!
    @IBOutlet weak var imgDice3: NSImageView!
    @IBOutlet weak var imgDice4: NSImageView!
    
    var counter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let dice2:NSImage? = NSImage(named: "dice2")
//        dice_image.image = dice2!
//
//        var diceArray = [NSImage]()
//        diceArray.append(NSImage(named: "dice1")!)
//        diceArray.append(NSImage(named: "dice2")!)
//        diceArray.append(NSImage(named: "dice3")!)
//        diceArray.append(NSImage(named: "dice4")!)
//        diceArray.append(NSImage(named: "dice5")!)
//        diceArray.append(NSImage(named: "dice6")!)
        
        self.dice_image.image = NSImage(named: "dice\(Int.random(in: 1...6))")
        self.imgDice2.image = NSImage(named: "dice\(Int.random(in: 1...6))")
        self.imgDice3.image = NSImage(named: "dice\(Int.random(in: 1...6))")
        self.imgDice4.image = NSImage(named: "dice\(Int.random(in: 1...6))")
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func throw_dice(_ sender: Any) {
        self.counter = 0
        /*
        for i in 1...6 {
            self.dice_image.image = NSImage(named: "dice\(i)")
            sleep(1)
        }
         */
//        var timer:Timer = Timer(timeInterval: 1.0, repeats: true) { (<#Timer#>) in
//            <#code#>
//        }
        /*
        var timer:Timer
        timer = Timer(
            timeInterval: 1.0,
            repeats: true,
            block: {
                (t) -> Void
                in
                self.counter += 1
//                print("haha\(self.counter)")
                self.dice_image.image = NSImage(named: "dice\(self.counter)")
                if self.counter == 6 {
                    t.invalidate()
                }
        }
        )
        
        var this_runloop:RunLoop
        this_runloop = RunLoop.current
        this_runloop.add(timer, forMode: RunLoop.Mode.default)
        */
        // bhilding block
        // if you see a crocodile! don't forget to scream
 /*
        _ = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true) {
                abc
                in
//                print("haha this one is easier")
                self.counter += 1
                self.dice_image.image = NSImage(named: "dice\(self.counter)")
                if self.counter == 6 {
                    abc.invalidate()
                }
            }
 */
        
        self.dice_image.image = NSImage(named: "dice\(Int.random(in: 1...6))")
        self.imgDice2.image = NSImage(named: "dice\(Int.random(in: 1...6))")
        self.imgDice3.image = NSImage(named: "dice\(Int.random(in: 1...6))")
        self.imgDice4.image = NSImage(named: "dice\(Int.random(in: 1...6))")
        
    }
    
}

