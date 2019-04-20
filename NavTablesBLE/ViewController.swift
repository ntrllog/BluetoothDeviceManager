//
//  ViewController.swift
//  NavTablesBLE
//
//  Created by Alan Lam on 4/20/19.
//  Copyright © 2019 Alan Lam. All rights reserved.
//

import UIKit
import CoreBluetooth

var txCharacteristic: CBCharacteristic?

class ViewController: UIViewController {
    
    var peripheral: CBPeripheral!
    
    // Write to the Bluetooth device
    func writeValue(data: String) {
        let valueString = (data as NSString).data(using:String.Encoding.utf8.rawValue)
        if let blePeripheral = peripheral {
            if let txCharacteristic = txCharacteristic {
                blePeripheral.writeValue(valueString!, for: txCharacteristic, type: .withResponse)
            }
        }
    }

    @IBAction func doLEDOnOff(_ sender: UISwitch) {
        /* Turn LED on */
        if sender.isOn {
            /* 20 char limit, have to break up */
            writeValue(data: "digitalWrite(\r\n")
            writeValue(data: "LED1,1)\r\n")
        }
        /* Turn LED off */
        else {
            /* 20 char limit, have to break up */
            writeValue(data: "digitalWrite(\r\n")
            writeValue(data: "LED1,0)\r\n")
        }
    }
    
    @IBOutlet weak var myTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateIncomingData()
    }
    
    func updateIncomingData() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Notify"), object: nil, queue: nil) { (notification) in
            // TODO
            print("Got notification")
        }
    }


}

