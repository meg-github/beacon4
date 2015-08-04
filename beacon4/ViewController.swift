//
//  ViewController.swift
//  beacon4
//
//  Created by Megumi Yasuo on 2015/07/31.
//  Copyright (c) 2015年 Megumi Yasuo. All rights reserved.
//

import UIKit
import Foundation
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

    }

    //ここから関数locationManagerの中身が続くよ．
    
    func locationManager(manager: CLLocationManager!, didDetermineState state: CLRegionState, forRegion region: CLRegion!) {
        if(state == .Inside){
            manager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
        }
    }
    
    func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
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
        manager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
        reset()
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        println(beacons.count)
        
        if(beacons.count == 0) { return }
        var beacon = beacons[0] as! CLBeacon
        
        if (beacon.proximity == CLProximity.Unknown) {
            self.beaconA.text = "Unknown Proximity"
            reset()
        }
        
        if(beacon.minor == 1){
            self.beaconA.text = "A"}
        if(beacon.minor == 2){
            self.beaconB.text = "B"}
        if(beacon.minor == 3){
            self.beaconC.text = "C"}
        if(beacon.minor == 4){
            self.beaconD.text = "D"}

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