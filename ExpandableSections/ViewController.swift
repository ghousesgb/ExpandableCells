//
//  ViewController.swift
//  ExpandableSections
//
//  Created by Ghouse Basha Shaik on 20/11/17.
//  Copyright © 2017 Ghouse Basha Shaik. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var categories = [CellModelData(isExpandable: true, names: [Contact(name: "Shaik Ghouse Basha", hasFavorite: false), Contact(name: " Ghouse S", hasFavorite: false), Contact(name: "Habeeb Banu", hasFavorite: false), Contact(name: "Tippu", hasFavorite: false), Contact(name: "Hafeez", hasFavorite: false)]),
                      CellModelData(isExpandable: true,  names: [Contact(name: "Anil Kumble", hasFavorite: false), Contact(name: "Bashit", hasFavorite: false), Contact(name: "Brain Lara", hasFavorite: false), Contact(name: "Bishop", hasFavorite: false)]),
                      CellModelData(isExpandable: true,  names: [Contact(name: "Dhoni MS", hasFavorite: false), Contact(name: "Dravid Rahul", hasFavorite: false), Contact(name: "Dinesh Karthik", hasFavorite: false)]),
                      CellModelData(isExpandable: true,  names: [Contact(name: "Sachin Tendullkar", hasFavorite: false), Contact(name: " Gangully", hasFavorite: false), Contact(name: "Kapil Dev", hasFavorite: false), Contact(name: "Rahane", hasFavorite: false), Contact(name: "Rohit", hasFavorite: false)]),
                      CellModelData(isExpandable: true,  names: [Contact(name: "Virat Kohil", hasFavorite: false), Contact(name: "Kafi", hasFavorite: false), Contact(name: "Yuvaraj", hasFavorite: false), Contact(name: "Jadeja", hasFavorite: false), Contact(name: "Aswin Kumar", hasFavorite: false)])]
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never //.scrollableAxes
        }
        navigationController?.navigationBar.prefersLargeTitles = true
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomeCell
        cell.textLabel?.text = categories[indexPath.section].names[indexPath.row].name
        let hasFavStatus = categories[(indexPath.section)].names[(indexPath.row)].hasFavorite
        cell.accessoryView?.tintColor = hasFavStatus ? UIColor.red : UIColor.gray
        cell.link = self
        return cell
    }
  
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        view.backgroundColor = .orange
        
        let caption = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        caption.textColor = .white
        caption.text = "    " + categories[section].names[0].name
        
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
    func setUnSetFavorite(cell : UITableViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        let hasFavStatus = categories[(indexPath?.section)!].names[(indexPath?.row)!].hasFavorite
        categories[(indexPath?.section)!].names[(indexPath?.row)!].hasFavorite = !hasFavStatus
        tableView.reloadRows(at: [indexPath!], with: .fade)
    }
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
