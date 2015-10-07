//
//  ViewController.swift
//  beacon4
//
//  Created by Megumi Yasuo on 2015/07/31.
//  Copyright (c) 2015年 Megumi Yasuo. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var beaconA: UILabel!
    @IBOutlet var beaconB: UILabel!
    @IBOutlet var beaconC: UILabel!
    @IBOutlet var beaconD: UILabel!
    @IBOutlet var beaconE: UILabel!
    
    let uuid = NSUUID(UUIDString: "00000000-7DE6-1001-B000-001C4DF13E76")
    var region = CLBeaconRegion()
    var manager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        region = CLBeaconRegion(proximityUUID:uuid,identifier:"beacon")
        
        manager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        if(status == CLAuthorizationStatus.NotDetermined) {
            self.manager.requestAlwaysAuthorization();
        }
        
        self.manager.startRangingBeaconsInRegion(self.region)

    }

    //ここから関数locationManagerの中身が続くよ．
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
        manager.requestStateForRegion(region)
        self.beaconA.text = "Scanning..."
    }
    
    func locationManager(manager: CLLocationManager!, didDetermineState state: CLRegionState, forRegion region: CLRegion!) {
        if(state == .Inside){
            println("determinestate")
            manager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
        }
    }
    
    func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
        println("test")
        println("monitoringDidFailForRegion \(error)")
        self.beaconA.text = "Error!"
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("didFailWithError \(error)")
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        manager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
        self.beaconA.text = "Possible Match"
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        println("exit")
        manager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
        reset()
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        var beacon = beacons[0] as! CLBeacon
        if(beacon.minor == 1){
            self.beaconA.text = "Ant!"}
            NSLog("A")
        if(beacon.minor == 2){
            self.beaconB.text = "Bear!"
            NSLog("B")
        }
        if(beacon.minor == 3){
            self.beaconC.text = "Cat!"
            NSLog("C")
        }
        if(beacon.minor == 4){
            self.beaconD.text = "Dog!"
            NSLog("D")
        }
        if (beacon.proximity == CLProximity.Unknown) {
            println("Unknown Proximity")
            reset()
        }
    }
    

    //ここまでlocationManagerの中身だよ
    
    func reset(){
        self.beaconA.text = "none"
        self.beaconB.text = "none"
        self.beaconC.text = "none"
        self.beaconD.text = "none"
        self.beaconE.text = "none"
       }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}