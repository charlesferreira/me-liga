//
//  Date.swift
//  NanoChallenge6
//
//  Created by Charles Ferreira on 10/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import Foundation

extension Date {
    
    static var sevenDaysAgo: Date {
        return Date(timeIntervalSinceNow: -7 * 3600 * 24)
    }
    
    static var threeDaysAgo: Date {
        return Date(timeIntervalSinceNow: -3 * 3600 * 24)
    }
    
    static var oneHourAgo: Date {
        return Date(timeIntervalSinceNow: -3600)
    }
    
    static var tenMinutesAgo: Date {
        return Date(timeIntervalSinceNow: -600)
    }
    
    static var now: Date {
        return Date()
    }
    
    func diffForHumans() -> String {
        
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            return "\(year) \(year == 1 ? "ano" : "anos") atrás"
        } else if let month = interval.month, month > 0 {
            return "\(month) \(month == 1 ? "mês" : "meses") atrás"
        } else if let day = interval.day, day > 0 {
            return "\(day) \(day == 1 ? "dia" : "dias") atrás"
        } else if let hour = interval.hour, hour > 0 {
            return "\(hour) \(hour == 1 ? "hora" : "horas") atrás"
        } else if let minute = interval.minute, minute > 0 {
            return "\(minute) \(minute == 1 ? "minuto" : "minutos") atrás"
        } else if let second = interval.second, second > 0 {
            return "\(second) \(second == 1 ? "segundo" : "segundos") atrás"
        } else {
            return "agora mesmo"
        }
    }
}
