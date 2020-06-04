//
//  Player.swift
//  StepUp
//
//  Created by Zach Grande on 5/11/20.
//  Copyright © 2020 Zach Grande. All rights reserved.
//

import UIKit

class Player: NSObject, NSCoding {
    
    // MARK: Properties
    var name: String
    var roomNumber: Int
    var stepCount: Int
    var lapCount: Int
    
    // MARK: Archiving Paths (from FoodTracker)
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("players")
    
    // MARK: Types
    struct PropertyKey { // Find where this is called
        static let name = "name"
        static let roomNumber = "roomNumber"
        static let stepCount = "stepCount"
        static let lapCount = "lapCount"
    }
    
    init?(name: String, roomNumber: Int, stepCount: Int, lapCount: Int) {
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // Room number cannot be negative
        guard roomNumber >= 0 else {
            return nil
        }
        
        // Initialize stored properties
        self.name = name
        self.roomNumber = roomNumber
        self.stepCount = stepCount
        self.lapCount = lapCount
    }
    
    // MARK: NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: PropertyKey.name)
        coder.encode(roomNumber, forKey: PropertyKey.roomNumber)
        coder.encode(stepCount, forKey: PropertyKey.stepCount)
        coder.encode(lapCount, forKey: PropertyKey.lapCount)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Player object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast
        let roomNumber = aDecoder.decodeObject(forKey: PropertyKey.roomNumber)
        let stepCount = aDecoder.decodeInteger(forKey: PropertyKey.stepCount)
        let lapCount = aDecoder.decodeInteger(forKey: PropertyKey.lapCount)
        
        // Must call designated initializer
        self.init(name: name, roomNumber: roomNumber as! Int, stepCount: stepCount, lapCount: lapCount)
    }
    
    // MARK: Modifier methods
    func incrSteps(numSteps: Int) {
        stepCount += numSteps
    }
    
    func resetPlayer() {
        name = "EMPTY"
        roomNumber = 0
        stepCount = 0
        lapCount = 0
    }
    
    // MARK: Instance methods
    func getName() -> String {
        return name
    }
    
    func getSteps() -> Int {
        return stepCount
    }
}
