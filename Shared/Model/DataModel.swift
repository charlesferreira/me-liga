//
//  DataModel.swift
//  NanoChallenge6
//
//  Created by Charles Ferreira on 08/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import Foundation

protocol DataModelDelegate: AnyObject {
    
    func dataModel(_ dataModel: DataModel, didUpdateContacts contacts: [AppContact])
}

class DataModel {
    
    static let shared = DataModel()
    
    weak var delegate: DataModelDelegate?
    
    private (set) lazy var contacts: [AppContact] = loadContacts()
    
    var defaults = UserDefaults.standard
    var contactsKey: String {
        return UserDefaults.Keys.contacts
    }
    
    private init() {}
    
    func add(_ contact: AppContact) {
        contacts.append(contact)
        contacts.sort(by: { $0.givenName < $1.givenName })
        persist()
    }
}

private extension DataModel {
    
    func persist() {
        guard let data = try? PropertyListEncoder().encode(contacts) else { return }
        defaults.set(data, forKey: contactsKey)
        delegate?.dataModel(self, didUpdateContacts: contacts)
    }
    
    func loadContacts() -> [AppContact] {
        guard let data = defaults.value(forKey: contactsKey) as? Data,
            let contacts = try? PropertyListDecoder().decode([AppContact].self, from: data) else { return [] }
        
        return contacts
    }
}
