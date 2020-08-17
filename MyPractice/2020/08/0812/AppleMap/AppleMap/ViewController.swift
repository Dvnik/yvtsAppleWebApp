

import UIKit
import CoreLocation // 引入核心定位框架
import MapKit //引入地圖框架
import SafariServices // 引入Safari服務框架

class ViewController: UIViewController, MKMapViewDelegate
{
    @IBOutlet weak var mapView: MKMapView!
    
    
    //初始化定位管理員
    let locationManager = CLLocationManager()
    //宣告大頭針的空陣列
    var annotations = [MKPointAnnotation]()
    
    //MARK: - 自訂函式
    //由Callout面板的按鈕所呼叫的函式
    @objc func buttonPress(_ sender: UIButton)
    {
        if sender.tag == 100
        {
            //初始化特定的網址物件
            let url = URL(string: "http://www.taroko.gov.tw")!
            //將網址物件製成Safari瀏覽器
            let safari = SFSafariViewController(url: url)
            //Safari瀏覽器開啟特定網址
            self.show(safari, sender: nil)
        }
    }
    //MARK: - Target Action
    
    @IBAction func segmentedControlPressed(_ sender: UISegmentedControl)
    {
        switch sender.selectedSegmentIndex
        {
            case 1://衛星
                mapView.mapType = .satellite
            case 2:// 混合
                mapView.mapType = .hybrid
            case 3:// 3D
                mapView.mapType = .satelliteFlyover
            default://預設標準
                mapView.mapType = .standard
        }
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //向使用者定位授權，需配合以下的Key和對應方法
        //Privacy - Location When In Use Usage Description
//        locationManager.requestWhenInUseAuthorization()
        //向使用者定位授權，需配合以下的Key和對應方法
        //Privacy - Location Always Usage Description
        locationManager.requestAlwaysAuthorization()
        //指定地圖協定實作在此類別
        mapView.delegate = self
        
        
        //初始化一個大頭針
        var annotation = MKPointAnnotation()
        //設定大頭針的緯度和經度
        annotation.coordinate = CLLocationCoordinate2D(latitude: 24.137426, longitude: 121.275753)
        //設定大頭針的主要資訊
        annotation.title = "武嶺"
        //設定大頭針的附屬資訊
        annotation.subtitle = "南投縣仁愛鄉"
        //將大頭針加入陣列
        annotations.append(annotation)
        //重新初始化一個大頭針（注意：重新初始化才會有新的記憶體配置記錄到陣列內！）
        annotation = MKPointAnnotation()
        //設定大頭針的緯度和經度
        annotation.coordinate = CLLocationCoordinate2D(latitude: 23.510041, longitude: 120.700458)
        //設定大頭針的主要資訊
        annotation.title = "奮起湖"
        //設定大頭針的附屬資訊
        annotation.subtitle = "嘉義縣竹崎鄉"
        //將大頭針加入陣列
        annotations.append(annotation)
        
        //重新初始化一個大頭針（注意：重新初始化才會有新的記憶體配置記錄到陣列內！）
        annotation = MKPointAnnotation()
        //設定大頭針的緯度和經度
        annotation.coordinate = CLLocationCoordinate2D(latitude: 24.402551, longitude: 121.161865)
        //設定大頭針的主要資訊
        annotation.title = "雪霸國家公園"
        //設定大頭針的附屬資訊
        annotation.subtitle = "苗栗縣大湖鄉"
        //將大頭針加入陣列
        annotations.append(annotation)
        
        //將大頭針陣列釘在地圖上
        mapView.addAnnotations(annotations)
        //移動地圖到第一根大頭針的位置
        mapView.setCenter(annotations[0].coordinate, animated: true)
        
        //===========================在地圖上標示多邊形=============================
        //宣告多邊形每個鼎點位置的陣列
        var points = [CLLocationCoordinate2D]()
        points.append(CLLocationCoordinate2D(latitude: 24.2013, longitude: 120.5810))
        points.append(CLLocationCoordinate2D(latitude: 24.2044, longitude: 120.6559))
        points.append(CLLocationCoordinate2D(latitude: 24.1380, longitude: 120.6401))
        points.append(CLLocationCoordinate2D(latitude: 24.1424, longitude: 120.5783))
        //製作一個可用於地圖上的多邊形
        let polygon = MKPolygon(coordinates: points, count: points.count)
        //在地圖上加入多邊形圖層（注意：此時為透明多邊形，需透過代理事件提供渲染樣式）
        mapView.addOverlay(polygon)
        //=======================================================================
        //===========================在地圖上標示圓形=============================
        //製作一個可用於地圖上的圓形(第二個參數為公尺)
        let circle = MKCircle(center: CLLocationCoordinate2D(latitude: 24.1100, longitude: 120.5750), radius: 3000)
        //在地圖上加入圓形圖層（注意：此時為透明圓形，需透過代理事件提供渲染樣式）
        mapView.addOverlay(circle)
        //=======================================================================
    }

    //MARK: - MKMapViewDelegate
    //<方法一>以系統提供的大頭針樣式，來更換預設大頭針的樣式（10-3改變大頭針顏色）
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
//    {
//        //如果是使用者位置的大頭針，不更換樣式
//        if annotation is MKUserLocation
//        {
//
//            return nil
//        }
//        //以pin為ID來取得大頭針的一般樣式MKAnnotationView(轉型為MKPinAnnotationView)
//        var annView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKPinAnnotationView
//        //如果無法以pin為ID取得大頭針的樣式
//        if annView == nil
//        {
//            //則以pin為ID重新做一個大頭針樣式
//            annView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
//        }
//        //更換大頭針的顏色
//        if annotation.title == "武嶺"
//        {
//            annView?.pinTintColor = .green
//        }
//        else if annotation.title == "奮起湖"
//        {
//            annView?.pinTintColor = .orange
//        }
//
//        //允許點選大頭針之後顯示大頭針資訊
//        annView?.canShowCallout = true
//        //回傳更動過後的大頭針樣式
//        return annView
//    }
    //<方法二>以自定圖片來更換預設大頭針的樣式（10-4將大頭針為自訂圖示）
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        //如果是使用者位置的大頭針，不更換樣式
        if annotation is MKUserLocation
        {

            return nil
        }
        //以pin為ID來取得大頭針的一般樣式MKAnnotationView(注意：不需要轉型為MKPinAnnotationView)
        var annView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") //as? MKPinAnnotationView
        //如果無法以pin為ID取得大頭針的一般樣式（不是MKPinAnnotationView）
        if annView == nil
        {
            //則以pin為ID重新做一個大頭針樣式（不是MKPinAnnotationView）
            annView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        }
        // 提供大頭針一般樣式的自訂圖片
        annView?.image = UIImage(named: "coffee_to_go.png")
        
        if annotation.title == "武嶺"
        {
            // 1.增加Callout面板左側的附件
            let imageView = UIImageView(image: UIImage(named: "wuling.jpg"))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            annView?.leftCalloutAccessoryView = imageView
            // 2.替換Callout面板的subtitle資訊為經緯度資訊
            let label = UILabel()
            label.numberOfLines = 2//將label設定為可以顯示兩行資料
            label.text = "緯度：\(annotation.coordinate.latitude)\n經度：\(annotation.coordinate.longitude)"
            annView?.detailCalloutAccessoryView = label
            // 3.增加Callout面板右側的按鈕附件
            let button = UIButton(type: .detailDisclosure)
            button.tag = 100
            button.addTarget(self, action: #selector(buttonPress(_:)), for: .touchUpInside)
            annView?.rightCalloutAccessoryView = button
            
        }
        
        
        //允許點選大頭針之後顯示大頭針資訊
        annView?.canShowCallout = true
        //回傳自定圖片的大頭針樣式
        return annView
    }
    //回傳地圖圖層的渲染樣式
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        if overlay is MKPolygon
        {
            // 取得地圖塗層中多邊形的渲染樣式(一開始為全透明)
            let renderPolygon = MKPolygonRenderer(overlay: overlay)
            // 設定多邊形範圍內的填滿顏色
            renderPolygon.fillColor = UIColor.red.withAlphaComponent(0.2)
            // 設定多邊形範圍的筆畫顏色
            renderPolygon.strokeColor = UIColor.red.withAlphaComponent(0.7)
            //設定多邊形的線條粗細
            renderPolygon.lineWidth = 3
            // 回傳多邊形的渲染樣式
            return renderPolygon
        }
        else if overlay is MKCircle
        {
            // 取得地圖塗層中圓形的渲染樣式(一開始為全透明)
            let renderCircle = MKCircleRenderer(overlay: overlay)
            // 設定圓形範圍內的填滿顏色
            renderCircle.fillColor = UIColor.red.withAlphaComponent(0.2)
            // 設定圓形範圍的筆畫顏色
            renderCircle.strokeColor = UIColor.red.withAlphaComponent(0.7)
            //設定圓形的線條粗細
            renderCircle.lineWidth = 3
            
            return renderCircle
        }
        // 回傳預設的透明樣式
        return MKOverlayRenderer()
    }
}

