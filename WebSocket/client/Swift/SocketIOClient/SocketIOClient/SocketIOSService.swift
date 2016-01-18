//
//  SocketIOSService.swift
//  SocketIOClient
//
//  Created by Yalin on 16/1/17.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit
import Socket_IO_Client_Swift

class SocketIOSService: NSObject {
    
    private var socket: SocketIOClient?
    private var clientServerURLStr = "127.0.0.1:3000"
    
    static let shareInstance = SocketIOSService()
    private override init() {
        
    }

    func connect(connectId: String) {
        if socket == nil {
            socket = SocketIOClient(socketURL: clientServerURLStr, options: [.Log(true), .ForcePolling(true)])
            
            socket?.on("connect", callback: { (data: [AnyObject], ack: SocketAckEmitter) -> Void in
                NSLog("\(data) socket connected")
            })
            
            socket?.on("currentAmount", callback: { [unowned self] (data: [AnyObject], ack: SocketAckEmitter) -> Void in
                
                if let cur = data[0] as? Double {
                    self.socket!.emitWithAck("canUpdate", cur)(timeoutAfter: 0) {data in
                        self.socket!.emit("update", ["amount": cur + 2.50])
                    }
                    
                    ack.with("Got your currentAmount", "dude")
                }
            })
            
            socket?.connect()
        }
    }
}
