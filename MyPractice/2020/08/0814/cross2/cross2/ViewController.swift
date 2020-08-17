

import UIKit
import WebKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var map: WKWebView!
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //loading URL:
        let myBlog = "https://bussiness-acaca.firebaseapp.com/cross2.html"
        let url = URL(string: myBlog)!
        let request = URLRequest(url: url)
        map.load(request)
    }


}

