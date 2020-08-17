

import UIKit
import WebKit

class ViewController: UIViewController
{
    @IBOutlet weak var browser: WKWebView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let myBlog = "http://www.tutorialspoint.com"
//        let myBlog = "https://www.google.com"
        let url = URL(string: myBlog)!
        let request = URLRequest(url: url)
        
        browser.load(request)
    }


}

