//
//  AllGroupsTableViewController.swift
//  VK GB
//
//  Created by Роман Вертячих on 03.05.2022.
//

import UIKit

class AllGroupsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet var allGroupsTableView: UITableView!
    @IBOutlet weak var searchGroup: UISearchBar!
    
    //var data = [["Фитнес","bolt.heart"],["Компьютеры","pc"], ["Книги","person.2.crop.square.stack"],["Волейбол","circle.fill"]]
    var vkGroups = [GroupVK(id: "Фитнес", imageName: "bolt.heart"),
                  GroupVK(id: "Компьютеры", imageName: "pc"),
                  GroupVK(id: "Книги", imageName: "person.2.crop.square.stack"),
                  GroupVK(id: "Волейбол", imageName: "circle.fill")]
    
    var filteredData: [GroupVK]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredData = vkGroups
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allGroupsCell", for: indexPath)
        
        cell.textLabel?.text = filteredData[indexPath.row].id
        cell.imageView?.image = UIImage(systemName: filteredData[indexPath.row].imageName)
        if filteredData[indexPath.row].check {
            cell.accessoryType = .checkmark
        }
        
        return cell
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? vkGroups : vkGroups.filter({(vkGroup: GroupVK) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return vkGroup.id.range(of: searchText, options: .caseInsensitive) != nil
        })

            tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "groupsTableView")
//
//        (vc as? GroupsTableViewController)?.data.append([data[indexPath.row][0],data[indexPath.row][1]])
//        self.navigationController?.pushViewController(vc, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
