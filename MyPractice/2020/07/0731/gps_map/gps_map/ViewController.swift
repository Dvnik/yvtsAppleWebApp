//
//  ViewController.swift
//  gps_map
//
//  Created by Trixie Lulamoon on 2020/7/31.
//  Copyright © 2020 Trixie. All rights reserved.
//

import UIKit
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
    func setSubtitle(sss:String){
        self.subtitle = sss
    }
   
    
}

class myMarkView:MKAnnotationView{
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        frame = CGRect(x: 0, y: 0, width: 40, height: 50)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)

        canShowCallout = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    func setIcon(image:UIImage){
        self.image = UIImage(named: "boat")
    }
    */
}

class ViewController: UIViewController {

    @IBOutlet weak var park: MKMapView!
    @IBOutlet weak var games: UIPickerView!
    
    let gps = CLLocationManager()
    let center = CLLocationCoordinate2D(latitude: 24.930975, longitude: 121.172248)
    let games_icon:[UIImage] = [
        UIImage(named: "boat")!,
        UIImage(named: "carousel")!,
        UIImage(named: "train")!,
        UIImage(named: "coaster")!

    ]
    let games_title:[String] = [
       "飛天潛艇",
       "擎天飛梭",
       "天女散花",
       "迴旋磁場"
    ]
    let games_subtitle:[String] = [
       "搭乘88米約30樓層高、矗立在摩天廣場的巨大幸福摩天輪，360度放眼所及，優美的自然美景一覽無遺。",
       "亞洲首度引進360度大迴轉『無底盤式』雲霄飛車，軌道全長814公尺，高度40公尺。",
       "依劍湖山世界山勢量身打造的造型鋼骨支架，讓G5飛馳於蒼翠綠意之間，全長共381公尺",
       "驚嚇列車是以列車為主題打造8個不同的驚嚇場景車廂"
    ]
    let games_location:[CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 24.931281, longitude: 121.171735),  //24.931281, 121.171735
        CLLocationCoordinate2D(latitude: 24.930823, longitude: 121.172636),  //24.930823, 121.172636
        CLLocationCoordinate2D(latitude: 24.930073, longitude: 121.172058),  //24.930073, 121.172058
        CLLocationCoordinate2D(latitude: 24.930305, longitude: 121.172989)   //24.930305, 121.172989
    ]
    var signal = true
    
    var center_annotation:myMark!
    var myAnnotation:MKPointAnnotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        
        gps.requestAlwaysAuthorization()
        games.dataSource = self
        games.delegate = self
        
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.0019, longitudeDelta: 0.0019)
        let location = CLLocationCoordinate2DMake(center.latitude, center.longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        self.park.setRegion(region, animated: true)
        
        center_annotation = myMark(coor: self.center, ttt: "中心位置")
        
        park.register(myMarkView.self, forAnnotationViewWithReuseIdentifier: "aabb")
        
        //park.addAnnotation(center_annotation)
        
        myAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = self.center
        park.addAnnotation(myAnnotation)
        
        //movePosition(center: myAnnotation, destinationPosition: games_location[2])
        
        // games devices
        var games:[myMark] = []
        for i in 0...3{
            let temp_game = myMark(coor: self.games_location[i], ttt: self.games_title[i])
            temp_game.setSubtitle(sss: self.games_subtitle[i])
            games.append(temp_game)
        }
        park.addAnnotations(games)
        
        park.delegate = self
        
        /*
        // Set timer of 5 seconds before beginning the animation.
               weak var timer: Timer?
               
               func movePosition() {
                   // Set timer to run after 5 seconds.
                   timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { [weak self] _ in
                       // Set animation to last 4 seconds.
                       UIView.animate(withDuration: 4, animations: {
                           // Update annotation coordinate to be the destination coordinate
                        myAnnotation.coordinate = self!.games_location[1]
                       }, completion: nil)
                   }
               }
               
               // Start moving annotation.
               movePosition()
       */
    }

    
    // 自製函數
    
    weak var timer: Timer!

    func movePosition(center:MKPointAnnotation, destinationPosition:CLLocationCoordinate2D) {
        
        // Set timer to run after 5 seconds.
        timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false) { [weak self] _ in
            // Set animation to last 4 seconds.
            UIView.animate(withDuration: 3, animations: {
                // Update annotation coordinate to be the destination coordinate
                print("動畫...")
                center.coordinate = destinationPosition
            }, completion: nil)
        }
    }

}

extension ViewController: CLLocationManagerDelegate, MKMapViewDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        /*
        
        // 先轉準備一個"名字" ---> Identifier 給從地圖中取出的MKAnnotationView 使用
        let annotationIdentifier = "aabb"

        // 我要改造從地圖中取出的MKAnnotationView,所以宣告一個MKAnnotationView變數用來裝我改造的成果
        
        var annotationView: MKAnnotationView?
        // 下面用 Optional Binding語法:
        // 呼叫MKMapView的dequeueReusableAnnotationView函數來一一地取出地圖上的MKAnnotationView
        // 取出的MKAnnotationView在此一律叫 "AnnotationIdentifier"
        
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            //Optional Binding語法會檢查取出的MKAnnotationView是否為nil
            //若確實有取到！
            //就把取到的MKAnnotationView指定給我一開始宣告的MKAnnotationView變數!這就可以直接用了！！
            annotationView = dequeuedAnnotationView
            //別忘了dequeueReusableAnnotationView函數要剝皮
            //把委託傳進來的MKAnnotation指定給這個MKAnnotationView
            annotationView?.annotation = annotation
            //至此！！我會一一取到地圖上的每一個MKAnnotationView裡面的資料就是他們原來的MKAnnotation
        }
        else {  // 萬一取不到呢！！Optional Binding語法會回傳false
            //詳細說明：
            
              //你的地圖程式第一次執行時確實會取不到!!因為dequeueReusableAnnotationView函數是用這個名字"AnnotationIdentifier"
              //去取的！第一次執行時,所有的MKAnnotationView都還沒有Identifier！！
              //因此！這一段程式(你一定要寫好)因為一定會在第一次執行這支程式時被執行(第二次以後,你的地圖程式沒有整個關閉！你從背景再進前景...)
              //就不會執行這段else而是前面的true了(因為所有的MKAnnotationView都已經有Identifier)
            
            //就到這裡來執行了
            //因為取不到！所以自己製作(同時給Identifier)
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            //annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            //把委託傳進來的MKAnnotation指定給這個MKAnnotationView
            annotationView!.annotation = annotation
        }

        ///不論是哪一種方式取到地圖上的MKAnnotationView!我都取到了
        //修改圖
        if annotationView!.annotation?.title == "飛天潛艇"{
            annotationView!.image = UIImage(named: "train")
        }else if annotationView!.annotation?.title == "擎天飛梭"{
            annotationView!.image = UIImage(named: "boat")
        }else if annotationView!.annotation?.title == "天女散花"{
            annotationView!.image = UIImage(named: "coaster")
        }else if annotationView!.annotation?.title == "迴旋磁場"{
            annotationView!.image = UIImage(named: "carousel")
        }else{
            annotationView!.image = UIImage(named: "cat_walk")
        }
        
        
        //最後交出我改造的成果(map就會秀在原先MKAnnotationView的位置上)
        return annotationView
 
       */
        let annotationView: MKAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "aabb")!
        if annotation.title == "飛天潛艇"{
            annotationView.image = UIImage(named: "train")
        }else if annotation.title == "擎天飛梭"{
            annotationView.image = UIImage(named: "boat")
        }else if annotation.title == "天女散花"{
            annotationView.image = UIImage(named: "coaster")
        }else if annotation.title == "迴旋磁場"{
            annotationView.image = UIImage(named: "carousel")
        }else{
//            annotationView.image = UIImage(named: "cat_walk")
            Thread() {
                while self.signal {
                        
                        for i in 1...5
                        {
                            DispatchQueue.main.async {
                                annotationView.image = UIImage(named: "dog\(i)")
                            }
                            sleep(1)
                        }
                        
                       
                    }
                
                

            }.start()
        }
        
        return annotationView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.signal = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.signal = false
    }
    
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return games_title.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return games_title[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("你選了\(games_title[row])")
        // move center to the game
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
        let location = CLLocationCoordinate2DMake(games_location[row].latitude, games_location[row].longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        self.park.setRegion(region, animated: true)
        // animate my_icon to the point above
        movePosition(center: myAnnotation, destinationPosition: games_location[row])
    }
}
