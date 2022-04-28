//
//  ViewController.swift
//  To-DO
//
//  Created by user186049 on 4/6/21.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
   
  
    
    
    @IBAction func addItem(_ sender: Any) {
        addButtonTapped()
    }
    
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        return table;
    }()
    
    
var item = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.item = UserDefaults.standard.stringArray(forKey: "item") ?? []
        // Do any additional setup after loading the view.
        title = "To Do List"
      view.addSubview(table)
        table.dataSource = self
        

    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = item[indexPath.row]

        return cell
        
    }
    
     
    
    
   func addButtonTapped(){
        let alert = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        alert.addTextField{ field in
            field.placeholder = "Write an Item"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self](_) in
            if let field = alert.textFields?.first{
                if let text = field.text, !text.isEmpty{
                    //print(text)
                    
                    DispatchQueue.main.async {
                        
                        var presentItem = UserDefaults.standard.stringArray(forKey: "item") ?? []
                        presentItem.append(text)
                        UserDefaults.standard.setValue(presentItem, forKey: "item")
                        self?.item.append(text)
                        self?.table.reloadData()
                    }
                   
                }
            }
        }))
    present(alert,animated: true,completion: nil)
    
   }
    
   
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       if editingStyle == .delete {
      
           // Delete the row from the data source
          item.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        let deleteItem = UserDefaults.standard.stringArray(forKey: "item") ?? []
        UserDefaults.standard.set(deleteItem, forKey:"item")
       
           
          
       }
}
    
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
        
    }
    
}


