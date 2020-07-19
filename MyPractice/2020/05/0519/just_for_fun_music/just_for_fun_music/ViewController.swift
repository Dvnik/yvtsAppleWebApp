//
//  ViewController.swift
//  just_for_fun_music
//
//  Created by Trixie Lulamoon on 2020/5/19.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {

    var spring: AVAudioPlayer! // declare AVAudioPlayer variable to handle paly music
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func music(_ sender: Any)
    {
        // play music is also anther kind of ouput, just lick print
        
        let music:URL = URL(fileURLWithPath: "/Users/trixie/Desktop/iOS_practice/0519/meme_song1.mp3")
        
        do
        {
            spring = try AVAudioPlayer(contentsOf: music)
            spring.play()
        }
        catch
        {
            print("it's have somting wrong.")
            print("error message:\(error)")
        }
        
    }
    
}

