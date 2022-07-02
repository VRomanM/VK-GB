//
//  GroupsTableViewController.swift
//  VK GB
//
//  Created by Роман Вертячих on 03.05.2022.
//

import UIKit
import RealmSwift

class GroupsTableViewController: UITableViewController {

    @IBOutlet var groupsTableView: UITableView!
    var apiVK = ApiVK()
//    var vkGroup: [GroupVK] = [] {
//         didSet {
//             tableView.reloadData()
//         }
//     }
//    var vkGroup: [GroupVK] = []
    var vkData: Results<GroupVK>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            var configuartion = Realm.Configuration.defaultConfiguration
            configuartion.deleteRealmIfMigrationNeeded = General.instance.needMigration
            let realm = try Realm(configuration: configuartion)
            print(realm.configuration.fileURL?.absoluteString ?? "NO REALM URL")
            let vkResult = realm.objects(GroupVK.self).sorted(by: \.name)
            vkData = vkResult
        } catch {
            print(error.localizedDescription)
        }
        
        apiVK.getGroupsByUserIDAF { [weak self] groupsArray in
            //self?.vkGroup = groupsArray
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
//        if segue.identifier == "addGroup" {
//            guard let allGroupsController = segue.source as? AllGroupsTableViewController else { return }
//            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
//                let group = allGroupsController.filteredData[indexPath.row]
//                if !vkGroup.contains(group) {
//                    vkGroup.append(group)
//                    tableView.reloadData()
//                }
//            }
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        guard segue.identifier == "showAllGroup" else {return}
//        guard let dData = (segue.destination as? AllGroupsTableViewController)?.filteredData else {return}
//        for element in vkGroup {
//            guard let idx = find(value: element, in: dData) else { return }
//            dData[idx].check = true
//        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        //return self.vkGroup.count
        return vkData?.count ?? 0
//        switch tableView {
//        case self.tableView:
//            if self.data[0].count == 0 {
//                return 0
//            }else {
//                return self.data.count
//            }
//        default:
//            return 0
//        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")!
              
        cell.textLabel?.text = vkData?[indexPath.row].name
        cell.imageView?.image = UIImage(systemName: vkData?[indexPath.row].imageName ?? "")
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
//            vkGroup.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        //} else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
}
