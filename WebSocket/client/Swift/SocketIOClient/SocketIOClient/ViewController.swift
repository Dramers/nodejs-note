//
//  ViewController.swift
//  SocketIOClient
//
//  Created by Yalin on 16/1/17.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var connectionButton: UIButton!
    @IBOutlet weak var disconnectButton: UIButton!
    @IBOutlet weak var sendMsgButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        SocketIOSService.shareInstance
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func connectionPressed(sender: AnyObject) {
        
        SocketIOSService.shareInstance.connect("12345")
    }
    
    @IBAction func disconnectPressed(sender: AnyObject) {
    }
    
    @IBAction func sendMsgPressed(sender: AnyObject) {
    }
    
}

