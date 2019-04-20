//
//  MyTableViewController.swift
//  NavTablesBLE
//
//  Created by Alan Lam on 4/20/19.
//  Copyright © 2019 Alan Lam. All rights reserved.
//

import UIKit
import CoreBluetooth

class MyTableViewController: UITableViewController, CBCentralManagerDelegate {
    
    var centralManager: CBCentralManager!
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            print("Bluetooth on so start scanning")
            startScan()
        }
        else {
            let vc = UIAlertController(title: "Bluetooth Not Enabled!", message: "Make sure Bluetooth is on", preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(vc, animated: true, completion: nil)
        }
    }
    
    // Universally Unique ID
    let BLEService_UUID = CBUUID(string: "6e400001-b5a3-f393-e093-e50e24dcca9e")
    
    func startScan() {
        // Remove names and RSSI
        names = []
        rssi = []
        print("Now scanning for BLE devices...")
        centralManager?.scanForPeripherals(withServices: [BLEService_UUID], options: nil)
        // Scan for 10 seconds, then stop
        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { (timer) in
            self.stopScan()
        }
    }
    
    func stopScan() {
        centralManager?.stopScan()
        print("Stopped scanning")
        print("Found \(names.count) devices")
    }
    
    @IBAction func doAbout(_ sender: Any) {
        let vc = UIAlertController(title: "About", message: "Program by ntrllog", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func doRefresh(_ sender: Any) {
        namesIndex += 1
        names.append("BLE \(namesIndex+1)")
        rssi.append(-42)
        tableView.reloadData()
    }
    
    var namesIndex = 2
    var names = ["BLE 1", "BLE 2", "BLE 3"]
    var rssi = [-42, -52, -62]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
        let backButton = UIBarButtonItem(title: "Disconnect", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /* default cells */
        // let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // let cell = tableView.dequeueReusableCell(withIdentifier: "rightDetail", for: indexPath)

        /* custom cell */
        let cell = tableView.dequeueReusableCell(withIdentifier: "bluetooth", for: indexPath) as! MyTableViewCell

        /* use for default cells */
        // cell.textLabel?.text = names[indexPath.row]
        // cell.detailTextLabel?.text = String(rssi[indexPath.row])
        
        /* use for custom cell */
        cell.myNameLabel.text = names[indexPath.row]
        cell.myRSSILabel.text = String(rssi[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(indexPath.row)")
        //TODO: connectToDevice()
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController")
        navigationController?.pushViewController(vc!, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
