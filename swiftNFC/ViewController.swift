//
//  ViewController.swift
//  swiftNFC
//
//  Created by 梁家章 on 19/12/2017.
//  Copyright © 2017 liangjiazhang. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    
    
    var helper: NFCHelper?
    var payloadLabel: UILabel!
    var payloadText = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // 增加检测按钮
        let button = UIButton(type: .system)
        button.setTitle("Read NFC", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 28.0)
        button.isEnabled = true
        button.addTarget(self, action: #selector(didTapReadNFC), for: .touchUpInside)
        button.frame = CGRect(x: 60, y: 260, width: self.view.frame.size.width - 120, height: 40)
        self.view.addSubview(button)
        
        // 添加一个 label 来显示状态
        payloadLabel = UILabel(frame: button.frame.offsetBy(dx: 0, dy: 260))
        payloadLabel.text = "按下读取数据"
        payloadLabel.numberOfLines = 120
        self.view.addSubview(payloadLabel)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK:
    //  当 NFCHelper 已经处理过或者通信失败时调用
    func onNFCResult(success: Bool, message: String)  {
        
        if success {
            payloadText = "\(payloadText)\n\(message)"
        } else {
            payloadText = "\(payloadText)\n\(message)"
        }
        
        // 在主线程中更新 UI
        DispatchQueue.main.async {
            self.payloadLabel.text = self.payloadText
        }
    }
    
    
    // 当用户点击 NFC 读取按钮时调用
    @objc func didTapReadNFC() {
        
        if helper == nil {
            
            helper = NFCHelper()
            helper?.onNFCResult = self.onNFCResult(success:message:)
        }
        
        payloadText = ""
        helper?.restartSession()
    }
    

}

