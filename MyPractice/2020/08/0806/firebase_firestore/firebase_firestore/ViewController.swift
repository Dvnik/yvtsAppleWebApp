//
//  ViewController.swift
//  firebase_firestore
//
//  Created by Trixie Lulamoon on 2020/8/6.
//  Copyright © 2020 Trixie. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,XMLParserDelegate
{
    let db = Firestore.firestore()
    var parser:XMLParser!
    
    var datas:[String:[[String:Double]]] = [String:[[String:Double]]]()
    var track_value:[[String:Double]] = [[String:Double]]()
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Add a new document with a generated ID
        
    }
    
    @IBAction func fill_data(_ sender: Any)
    {
        //get the gpx file
        let bundle = Bundle.main
        let path = bundle.path(forResource: "cat", ofType: "gpx")!
        print(path)
        // create XML Parser
        parser = XMLParser(contentsOf: URL(fileURLWithPath: path))
        parser!.delegate = self
        
        parser.parse()
        
        
        
        datas["track"] = track_value
        db.collection("positions").document("cat").setData(datas)
        {
            err
            in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    //MARK: -XMLParserDelegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "wpt"
        {
            let lat = Double(attributeDict["lat"]!)!
            let lng = Double(attributeDict["lon"]!)!
            let pos = ["lat":lat, "lng":lng]
            track_value.append(pos)
            
//            print("lon:\(attributeDict["lon"]!), lat:\(attributeDict["lat"]!)")
//            print(attributeDict)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print(track_value)
    }
}

