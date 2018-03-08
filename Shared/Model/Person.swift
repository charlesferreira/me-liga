//
//  Person.swift
//  NanoChallenge6
//
//  Created by Charles Ferreira on 07/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

struct Person {
    
    var givenName: String
    var familyName: String
    var phoneNumber: String?
    
    var fullName: String {
        return [givenName, familyName].filter { !$0.isEmpty }.joined(separator: " ")
    }
}
