//
//  ViewController.swift
//  ExpandableSections
//
//  Created by Ghouse Basha Shaik on 20/11/17.
//  Copyright © 2017 Ghouse Basha Shaik. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var categories = [CellModelData(isExpandable: true, names: ["Shaik Ghouse Basha", "Ghouse S", "Habeeb Banu", "Tippu", "Hafeez"]),
                      CellModelData(isExpandable: true, names: ["Anil Kumble", "Ajith", "Andy Flower", "Ambrose"]),
                      CellModelData(isExpandable: true, names: ["Basith", "Bumbrah", "Bell"]),
                      CellModelData(isExpandable: true, names: ["Denish", "Dhoni"]),
                      CellModelData(isExpandable: true, names: ["Tendullkar", "Ashwin", "Kohli", "Rohit","Kumar"])]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !categories[section].isExpandable {
            return 0
        }
        return categories[section].names.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = categories[indexPath.section].names[indexPath.row]
        return cell!
    }
  
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        view.backgroundColor = .orange
        
        let caption = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        caption.textColor = .white
        caption.text = "  " + categories[section].names[0]
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: tableView.frame.size.width-60, y: 0, width: 60, height: 40)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        
        view.addSubview(caption)
        view.addSubview(button)
        return view
    }
}

extension ViewController {
    @objc func handleExpandClose(button: UIButton) {
        let section = button.tag
        var indexPaths = [IndexPath]()
        for row in categories[section].names.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpandable = categories[section].isExpandable
        categories[section].isExpandable = !isExpandable
        
        if categories[section].isExpandable {
            tableView.insertRows(at: indexPaths, with: .fade)
            button.setTitle("Close", for: .normal)
        }else {
            tableView.deleteRows(at: indexPaths, with: .fade)
            button.setTitle("Open", for: .normal)
        }
    }
}
