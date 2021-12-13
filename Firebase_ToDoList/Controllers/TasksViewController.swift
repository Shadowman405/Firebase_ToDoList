//
//  TasksViewController.swift
//  Firebase_ToDoList
//
//  Created by Maxim Mitin on 12.12.21.
//

import UIKit
import Firebase

class TasksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addClicked(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func signoutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - Extensions

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text = "Cell \(indexPath.row)"
        return cell
    }
    
    
}
