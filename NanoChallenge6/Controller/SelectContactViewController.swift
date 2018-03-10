//
//  SelectContactViewController.swift
//  NanoChallenge6
//
//  Created by Charles Ferreira on 07/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit
import Contacts
import WatchConnectivity

class SelectContactViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var contacts = [AppContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContacts()
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func fetchContacts() {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { [weak self] (granted, error) in
            guard granted, error == nil else { return }
            
            // carrega os contatos do dispositivo
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
            let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            try? store.enumerateContacts(with: request, usingBlock: { [weak self] (contact, _) in
                self?.contacts.append(AppContact(contact: contact))
            })
            
            // ordena e atualiza a tabela
            self?.contacts.sort(by: { $0.givenName < $1.givenName })
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func select(contact: AppContact) {
        DataModel.shared.add(contact)
        sendMessage(with: contact)
        dismiss(animated: true, completion: nil)
    }
    
    private func sendMessage(with contact: AppContact) {
        guard let data = contact.encode() else { return }
        let message = [Message.Keys.newContact: data]
        WCSession.default.sendMessage(message, replyHandler: nil, errorHandler: nil)
    }
}

extension SelectContactViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "NewContactTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellID)
        
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = contact.fullName
        
        return cell
    }
}

extension SelectContactViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        select(contact: contacts[indexPath.row])
    }
}
