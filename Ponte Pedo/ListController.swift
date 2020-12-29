//
//  ListController.swift
//  Ponte Pedo
//
//  Created by Abraham Luna on 28/12/20.
//

import Foundation
import UIKit

class MenuListController: UITableViewController{
    
    var items = ["Reglas","Contacto","Créditos","Califícanos"]
    let darkColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = darkColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.separatorColor = darkColor
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var cellTxt = items[indexPath.row]
        cell.textLabel?.text = cellTxt
        cell.textLabel?.textColor = .white
        cell.backgroundColor = darkColor
        setImageViewtoCell(cell: &cell, txt: &cellTxt)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func setImageViewtoCell(cell: inout UITableViewCell, txt: inout String){
        let padding: CGFloat = 10

        switch txt {
        case "Reglas":
            cell.imageView?.image = UIImage(named: "beer")
          break
            
        case "Contacto":
            cell.imageView?.image = UIImage(named: "email")?.resizableImage(withCapInsets: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding), resizingMode: .stretch)
            cell.imageView?.contentMode = .scaleAspectFill
            
          break
            
        case "Créditos":
            cell.imageView?.image = UIImage(named: "rating")?.resizableImage(withCapInsets: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding), resizingMode: .stretch)
            cell.imageView?.contentMode = .scaleAspectFill
          break
            
        case "Califícanos":
            cell.imageView?.image = UIImage(named: "teamwork")?.resizableImage(withCapInsets: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding), resizingMode: .stretch)
            cell.imageView?.contentMode = .scaleAspectFill
          break
            
        default:
            break
        }
    }
}
