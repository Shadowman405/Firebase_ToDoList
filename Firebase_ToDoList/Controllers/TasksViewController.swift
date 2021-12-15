//
//  TasksViewController.swift
//  Firebase_ToDoList
//
//  Created by Maxim Mitin on 12.12.21.
//

import UIKit
import Firebase

class TasksViewController: UIViewController {
    
    var user: UserApp!
    var ref = DatabaseReference()
    var tasks = [Task]()
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currnetUser = Auth.auth().currentUser else {return}
        user = UserApp(user: currnetUser)
        ref = Database.database(url: "https://todofiretest-default-rtdb.europe-west1.firebasedatabase.app").reference(withPath: "users").child(String(user.uid)).child("tasks")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ref.observe(.value) { [weak self] snapshot in
            var _tasks = [Task]()
            for item in snapshot.children {
                let task = Task(snapshot: item as! DataSnapshot)
                _tasks.append(task)
            }
            
            self?.tasks = _tasks
            self?.tableView.reloadData()
        }
    }

    @IBAction func addClicked(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New Task", message: "Add new task", preferredStyle: .alert)
        alertController.addTextField()
        let save = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let texField = alertController.textFields?.first, texField.text != "" else {return}
            let task = Task(title: texField.text!, userId: (self?.user.uid)!)
            let taskRef = self?.ref.child(task.title.lowercased())
            taskRef?.setValue(task.convertToDictionary())
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(save)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
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
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        let taskTitle = tasks[indexPath.row].title
        cell.textLabel?.text = taskTitle
        return cell
    }
    
    
}
