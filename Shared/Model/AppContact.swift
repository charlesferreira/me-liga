//
//  AppContact.swift
//  NanoChallenge6
//
//  Created by Charles Ferreira on 07/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import Contacts

struct AppContact: Codable {
    
    var givenName: String
    var familyName: String
    var phoneNumber: String?
    var lastCall: Date
    
    var imageName: String? = nil
    
    var fullName: String {
        return [givenName, familyName].filter { !$0.isEmpty }.joined(separator: " ")
    }
    
    var happiness: Double {
        return Happiness.calculate(lastCall: lastCall)
    }
    
    init(contact: CNContact) {
        givenName = contact.givenName
        familyName = contact.familyName
        phoneNumber = contact.phoneNumbers.first?.value.stringValue.digits
        lastCall = Constants.LastCall.default
    }
}
