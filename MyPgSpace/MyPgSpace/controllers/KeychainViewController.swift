//
//  KeychainViewController.swift
//  MyPgSpace
//
//  Created by Johnson Liu on 3/12/22.
//

import UIKit

class KeychainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?
    
    var rowsData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Keychain"
        rowsData = ["Add New", "Retrieve", "Edit", "Delete"]
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView?.layer.borderColor = UIColor.black.cgColor
        tableView?.layer.borderWidth = 0.5
    }
}

extension KeychainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId")
        
        cell?.textLabel?.text = rowsData[indexPath.row]
        cell?.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
