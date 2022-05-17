//
//  ViewController.swift
//  MinFit
//
//  Created by 노민희 on 2022/05/17.
//

import UIKit

import Firebase

class ViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.child("Library").observeSingleEvent(of: .value) { kind in
            kind.children.forEach { name in
                print(name)
            }
        }
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
