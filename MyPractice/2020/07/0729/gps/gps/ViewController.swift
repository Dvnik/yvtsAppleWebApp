//
//  ViewController.swift
//  gps
//
//  Created by Trixie Lulamoon on 2020/7/29.
//  Copyright © 2020 Trixie. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController
{
    
    @IBOutlet weak var longitude: UITextField!
    
    @IBOutlet weak var latitude: UITextField!
    
    @IBOutlet weak var height: UITextField!
    
    @IBOutlet weak var speed: UITextField!
    
    @IBOutlet weak var direction: UITextField!
    
    
    var manager:CLLocationManager!
    //MARK: - Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager = CLLocationManager()
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        
    }
    //MARK: - My Actions
    @IBAction func receive(_ sender: Any)
    {
        manager.startUpdatingLocation()
//        manager.startUpdatingHeading()
    }
    
    @IBAction func stop(_ sender: Any)
    {
        manager.stopUpdatingLocation()
//        manager.stopUpdatingHeading()
    }
}

extension ViewController:CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newest_point:CLLocation = locations[0]
        print(
            "目前位置===> 經度:\(newest_point.coordinate.longitude) 緯度: \(newest_point.coordinate.latitude) "
        )
        self.latitude.text = "\(newest_point.coordinate.latitude)"
        self.longitude.text = "\(newest_point.coordinate.longitude)"
        self.height.text = "\(newest_point.altitude)"
        self.speed.text = "\(newest_point.speed.advanced(by: 100))"
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("update direction....")
        self.direction.text = "\(newHeading)"
    }
    
}
