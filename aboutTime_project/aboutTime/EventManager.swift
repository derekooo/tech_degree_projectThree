//
//  EventManager.swift
//  aboutTime
//
//  Created by Tong Wang on 2018-06-07.
//  Copyright © 2018 Tong Wang. All rights reserved.
//

import Foundation
let Events = EventsGenerator()

class EventManager{
    let gameRound = 6
    var gameScore = 0
    var eventFinished = 0
    let gameEvents = Events
    var gameSatus = false
    func generateRound()->[event] {
        var result:[event] = []
        while result.count < 4{
            let event = Events.randomPopEvent()
            if !result.contains(event){
                result.append(event)
            }
           
        }
        return result
    }
    
    func checkCorrectOrder(events:[event])-> Bool {
        for i in 0...events.count - 1{
            if events[i].eventTime > events[i+1].eventTime{
                return false
            }
        }
        return true
    }
    
    func correctAnswer(events:[event]) -> [event]{
        let result = events
        let sotedResult = result.sorted()
        return sotedResult
    }
    
    
    
    
    
}
