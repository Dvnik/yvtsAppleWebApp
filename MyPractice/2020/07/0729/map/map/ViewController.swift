//
//  ViewController.swift
//  map
//
//  Created by Trixie Lulamoon on 2020/7/29.
//  Copyright © 2020 Trixie. All rights reserved.
//

import UIKit
import MapKit
//乾脆!!自己也遵循MKAnnotation介面，自己造一個MKAnnotation新的家族成員===> myMark
class myMark:NSObject, MKAnnotation
{
    // 因為只有NSObject的後代才有資格再繼承某個介面
    // 所以先讓myMark繼承NSSObject <=== 這個類別是整個swift物件導向類別樹的最上層的祖先
    var coordinate: CLLocationCoordinate2D// 一定要override MKAnnotation的CLLocationCoordinate2D資料
    var title: String?                    //一定要override MKAnnotation的title(String)資料
    var subtitle: String?                 //要不要override MKAnnotation的subtitle(String)資料 無所謂
    // 寫個建構子來把東西初始化一下
    init(coor:CLLocationCoordinate2D, ttt:String)
    {
        self.coordinate = coor
        self.title = ttt
    }
    
    func setSubtitle(sss:String)
    {
        self.subtitle = sss
    }
}



class ViewController: UIViewController
{
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var address: UITextField!
    
    
    

    //MARK: Life cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        map.delegate = self
        
        let puxin_lat:CLLocationDegrees = 24.919598
        let puxin_lon:CLLocationDegrees = 121.183534
//        var location:CLLocationCoordinate2D = CLLocationCoordinate2D()
//        location.latitude = puxin_lat
//        location.longitude = puxin_lon
/*
        let region:MKCoordinateRegion = MKCoordinateRegion(center: location,
                                                 latitudinalMeters: CLLocationDistance(exactly: 5000)!,
                                                 longitudinalMeters: CLLocationDistance(exactly: 5000)!)
        map.setRegion(region, animated: true)
 */
//        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let location = CLLocationCoordinate2D(latitude: puxin_lat, longitude: puxin_lon)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(map.regionThatFits(region), animated: true)
        
    }

    //MARK: My Action
    @IBAction func go(_ sender: Any)
    {
        // apple 的大地編碼物件
        let geocoder:CLGeocoder = CLGeocoder()
        
        // 反解 lat/lon ===> address
        /*
        let puxin_lat:CLLocationDegrees = 24.919598
        let puxin_lon:CLLocationDegrees = 121.183534
        let location:CLLocation = CLLocation(latitude: puxin_lat, longitude: puxin_lon)
        geocoder.reverseGeocodeLocation(location) {
            (addresses, error)
            in
            if let err = error {
                print("出錯！！錯誤是：\(err)")
            }
            else {
                
                if addresses!.count >= 1
                {
                    print("您給的經緯度的人為地址(第一筆)是：\(addresses![0])")
                }
                else
                {
                    print("No man's land.")
                }
                
            }
            
        }
         */
        //正解 lat/lon ===> address
        
        geocoder.geocodeAddressString(self.address.text!) {
            (loc, error)
            in
            if let err = error {
                print("出錯！！錯誤是：\(err)")
            }
            else {
                print("經度：\(loc![0].location!.coordinate.longitude)緯度：\(loc![0].location!.coordinate.latitude)")
                // 前去這這個位置！！
                let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                let location = CLLocationCoordinate2D(
                    latitude: loc![0].location!.coordinate.latitude,
                    longitude: loc![0].location!.coordinate.longitude)
                let region = MKCoordinateRegion(center: location, span: span)
                self.map.setRegion(self.map.regionThatFits(region), animated: true)
                //並打上mark
                let xxx:myMark = myMark(coor: location, ttt: "媽！我在這")
                xxx.setSubtitle(sss: "疑是地上霜")
                self.map.addAnnotation(xxx)
            }
            
        }
    }
    
}

extension ViewController:MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView])
    {
        print("Amark was mark on")
//        let mark:MKAnnotationView = views[0]
//        let xxx:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        xxx.backgroundColor = UIColor.red
//        mark.addSubview(xxx)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        var my:MKAnnotationView
//        my = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom pin")
//
//        let puxin_lat:CLLocationDegrees = 24.919598
//        let puxin_lon:CLLocationDegrees = 121.183534
//        let location = CLLocationCoordinate2D(latitude: puxin_lat, longitude: puxin_lon)
//        let xxx:myMark = myMark(coor: location, ttt: "程咬金")
//        xxx.setSubtitle(sss: "此山是我開\n此數是我災")
//        my.image = UIImage(named: "barr")
//        my.
//        my.annotation = xxx
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom pin")
        annotationView.image = UIImage(named: "barr")
        
        annotationView.canShowCallout = true
        
        
        return annotationView
    }
}
