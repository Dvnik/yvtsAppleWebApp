//
//  ViewController.swift
//  just_for_fun2
//
//  Created by Trixie Lulamoon on 2020/5/21.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {

    
    @IBOutlet weak var imgDice1: NSImageView!
    
    @IBOutlet weak var imgDice2: NSImageView!
    
    @IBOutlet weak var imgDice3: NSImageView!
    
    @IBOutlet weak var imgDice4: NSImageView!
    
    
    var dice_image_views: [NSImageView] = [NSImageView]()
    
    var player:AVAudioPlayer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dice_image_views.append(self.imgDice1)
        dice_image_views.append(self.imgDice2)
        dice_image_views.append(self.imgDice3)
        dice_image_views.append(self.imgDice4)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    @IBAction func sibala(_ sender: Any) {
        // Home Work
        for view in self.dice_image_views {
            let diceResult = Int.random(in: 1...6)
            view.image = NSImage(named: "dice\(diceResult)")
        }
        
        let sibala = URL(fileURLWithPath: "/Users/trixie/Desktop/iOS_practice/0521/diceImage/dice_throw.mp3")

        do {
            player = try AVAudioPlayer(contentsOf: sibala)
            player.play()
        }
        catch {
            print(error)
        }
    }
}
