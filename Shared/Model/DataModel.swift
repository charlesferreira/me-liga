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
    
    private (set) lazy var contacts = [AppContact]()
    
    var averageHappiness: Double? {
        guard contacts.count > 0 else { return nil }
        return contacts.reduce(0.0, { $0 + $1.happiness }) / Double(contacts.count)
    }
    
    var defaults = UserDefaults.standard
    var contactsKey: String {
        return UserDefaults.Keys.contacts
    }
    
    private init() {
        loadContacts()
    }
    
    func add(_ contact: AppContact) {
        contacts.append(contact)
        contacts.sort(by: { $0.givenName < $1.givenName })
        persist()
    }
    
    func remove(at index: Int) {
        contacts.remove(at: index)
        persist()
    }
    
    @discardableResult
    func touch(at index: Int) -> AppContact {
        contacts[index].lastCall = Date.now
        persist()
        return contacts[index]
    }
    
    func decode(data: Data) {
        guard let contacts = try? PropertyListDecoder().decode([AppContact].self, from: data) else { return }
        
        self.contacts = contacts
        persist()
    }
    
    func encode() -> Data? {
        return try? PropertyListEncoder().encode(contacts)
    }
    
    private func persist() {
        guard let data = encode() else { return }
        defaults.set(data, forKey: contactsKey)
        delegate?.dataModel(self, didUpdateContacts: contacts)
    }
    
    private func loadContacts() {
        guard let data = defaults.value(forKey: contactsKey) as? Data else { return }
        decode(data: data)
    }
}
