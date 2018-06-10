//
//  EventProvider.swift
//  aboutTime
//
//  Created by Tong Wang on 2018-06-07.
//  Copyright © 2018 Tong Wang. All rights reserved.
//

import Foundation
import GameKit


struct event:Equatable,Comparable {
    let eventIntro: String
    let eventTime: Int
    static func ==(lhs: event, rhs:event ) -> Bool {
        return lhs.eventIntro == rhs.eventIntro
    }
    static func < (lhs: event, rhs: event) -> Bool {
        return lhs.eventTime < rhs.eventTime
    }
}



class EventsGenerator {
    let events:[event] = [event(eventIntro: "Kobe Bryant drops 81 points on the Raptors", eventTime: 2006),
                          event(eventIntro: " Wilt Chamberlain scored 100 points against the New York Knicks", eventTime: 1962),
                          event(eventIntro: " McGrady had one of the most memorable performances of his career, scoring 13 points in the final 35 seconds.", eventTime: 2005),
                          event(eventIntro: "Leborn James socred 51 points career high in 1st game of final championship vs Godlen states", eventTime: 2018),
                          event(eventIntro: "The 1st Dream team of USA basketball", eventTime: 1992),
                          event(eventIntro: "Kobe Bryant change his number from 8 to 24", eventTime: 2007),
                          event(eventIntro: "Leborn finally got his first NBA championship ring", eventTime: 2012),
                           event(eventIntro: "Stephen Curry was selected with the seventh overall pick by by the Golden State Warriors", eventTime: 2009),
                           event(eventIntro: " Chicago had finally vanquished its longtime nemesis, the Detroit Pistons", eventTime: 1991),
                           event(eventIntro: "The Golden states warriors first championshp", eventTime: 1975),
                           event(eventIntro: "Yao Ming was selected by the Houston Rockets as the first overall pick", eventTime: 2002),
                           event(eventIntro: "Derrick Rose, at age 22, became the youngest player to win the NBA Most Valuable Player Award", eventTime: 2011),
                           event(eventIntro: "Satnam Singh Bhamara became the first player from India to be drafted into the NBA", eventTime: 2015),
                           event(eventIntro: "Seattle SuperSonics relocated to Oklahoma City, Oklahoma,", eventTime: 2008),
                           event(eventIntro: "USA basketball team lost the game against Argentina", eventTime: 2004),
                            event(eventIntro: "The Cleveland Cavaliers won their first NBA Championship, marking Cleveland's first major sports title ", eventTime: 2016),
                            event(eventIntro: "Los Angeles Lakers's showtime started ", eventTime: 1979),
                            event(eventIntro: "Kobe Bryant got his 2nd championship as number 24", eventTime: 2010),
                            event(eventIntro: "Ben Wallace and Ron Artest: The Malice in the Palace", eventTime: 2005),
                            event(eventIntro: "Vince Carter epic Slam Dunk Contest performance ", eventTime: 2000),
                            event(eventIntro: "The Olajuwon-led Rockets won the franchise's first championship against Patrick Ewing and the New York Knicks", eventTime: 1994),
                            event(eventIntro: "The best draft year of NBA", eventTime: 1996),
                            event(eventIntro: "Violet Renice Palmer was the first woman to officiate an NBA playoff game", eventTime: 2006),
                            event(eventIntro: "The Splash Brothers won their 1st championship", eventTime: 2015),
                             event(eventIntro: "Kevin Durant got his first NBA championship", eventTime: 2017)]
    func randomPopEvent() -> event {
        let randomNum = GKRandomSource.sharedRandom().nextInt(upperBound: events.count)
        return self.events[randomNum]
    }
}








