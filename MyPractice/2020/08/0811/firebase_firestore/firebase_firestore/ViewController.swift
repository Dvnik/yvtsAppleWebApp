//
//  ViewController.swift
//  firebase_firestore
//
//  Created by Trixie Lulamoon on 2020/8/6.
//  Copyright © 2020 Trixie. All rights reserved.
//

import UIKit
import FirebaseFirestore
import MapKit
import CoreLocation

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




class ViewController: UIViewController,XMLParserDelegate, MKMapViewDelegate
{
    let db = Firestore.firestore()
    var parser:XMLParser!
    
    var datas:[String:[[String:Double]]] = [String:[[String:Double]]]()
    var track_value:[[String:Double]] = [[String:Double]]()
    // point number
    var number:Int = 0
    
    @IBOutlet weak var map: MKMapView!
    
    
    
    //MARK:- My Function
    

    
    //MARK:- Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Add a new document with a generated ID
        //24.930869, 121.172074
        map.delegate = self
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let location = CLLocationCoordinate2DMake(24.930869, 121.172074)
        let region = MKCoordinateRegion(center: location, span: span)
        self.map.setRegion(self.map.regionThatFits(region), animated: true)
        let pin:myMark = myMark(coor: location, ttt: "start")
        map.addAnnotation(pin)
    }
    //MARK:-Target Action
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
        
        /*
        
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
         */
    }
    
    
    
    
    @IBAction func tap(_ tapGuesture: UITapGestureRecognizer)
    {
        let location = tapGuesture.location(in: map)
        
        let coordinate = self.map.convert(location, toCoordinateFrom: map)
        let pin:MKPointAnnotation = MKPointAnnotation()
        pin.coordinate = coordinate
        self.map.addAnnotation(pin)
        print("你點在地圖上囉！座標是：\(coordinate.latitude), \(coordinate.longitude)")
        //新增座標到資料庫上
        db.collection("positions").document("cat").updateData(["track":FieldValue.arrayUnion([["lat":coordinate.latitude, "lng":coordinate.longitude]])])
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
    
    func parserDidEndDocument(_ parser: XMLParser)
    {
        print(track_value)
        
        datas = ["track":track_value]
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
    
    
    //MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        
        let reuseIdentifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

    
        if annotation.title == "start"
        {
            annotationView!.image = UIImage(named: "No0")
        }
        else
        {
            number = number + 1
            
            annotationView!.image = UIImage(named: "No\(number)")
            var xx:UIImageView = UIImageView(image: UIImage(named: "No\(number)"))
            xx.frame = CGRect(x: xx.frame.origin.x - xx.frame.size.width, y: xx.frame.origin.y, width: xx.frame.size.width, height: xx.frame.size.height)
            annotationView!.addSubview(xx)
        }
        
        return annotationView
    }
}

