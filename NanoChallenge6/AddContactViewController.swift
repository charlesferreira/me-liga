//
//  AddContactViewController.swift
//  NanoChallenge6
//
//  Created by Charles Ferreira on 07/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit
import Contacts

class AddContactViewController: UITableViewController {
    
    var contacts = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContacts()
    }
    
    func fetchContacts() {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            guard granted, error == nil else { return }
            
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
            let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            try? store.enumerateContacts(with: request, usingBlock: { [weak self] (contact, _) in
                let phoneNumber = contact.phoneNumbers.first?.value.stringValue
                let person = Person(givenName: contact.givenName, familyName: contact.familyName, phoneNumber: phoneNumber)
                self?.contacts.append(person)
                self?.contacts.sort(by: { p1, p2 in return p1.givenName < p2.givenName })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            })
        }
    }
    
    @IBAction func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "NewContactTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellID)
        
        let person = contacts[indexPath.row]
        cell.textLabel?.text = person.fullName
        
        return cell
    }
}
