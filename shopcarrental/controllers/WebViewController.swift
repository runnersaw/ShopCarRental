//
//  WebViewController.swift
//  shopcarrental
//
//  Created by Sawyer Vaughan on 10/30/15.
//  Copyright © 2015 Sawyer Vaughan. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    var url : NSURL
    var webView : UIWebView!
    
    init(title: String, url: NSURL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let done = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "done")
        self.navigationItem.rightBarButtonItem = done
        self.navigationItem.title = self.title
        
        self.webView = UIWebView(frame: self.view.frame)
        let request = NSURLRequest(URL: self.url)
        self.webView.loadRequest(request)
        self.view.addSubview(self.webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func done() {
        self.navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }

}
