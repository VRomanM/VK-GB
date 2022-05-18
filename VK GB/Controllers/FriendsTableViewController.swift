//
//  FriendsTableViewController.swift
//  VK GB
//
//  Created by Роман Вертячих on 03.05.2022.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    @IBOutlet var friendsTableView: UITableView!
    //private var data = ["Заюнька", "Санёк"]
    var vkUser = [
        [UserVK(id: "Александр победоностный", imageSysName: "ant"),
         UserVK(id: "Антон Мокрый", imageSysName: "ant"),
         UserVK(id: "Алексей Кривой", imageSysName: "ant"),
         UserVK(id: "Алексей Невидимый", imageSysName: "ant")],
            
        [UserVK(id: "Заюнька", imageSysName:"pawprint.fill"),
         UserVK(id: "Зяблик", imageSysName: "pawprint"),
         UserVK(id: "Заррубин", imageSysName: "pawprint")],
            
        [UserVK(id: "Хлюпик", imageSysName: "tortoise"),
         UserVK(id: "Хомосапиенс", imageSysName: "tortoise"),
         UserVK(id: "Хороший парень", imageSysName: "tortoise")]
                ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsTableView.register(UINib(nibName: "FriendsTableViewCell", bundle: nil), forCellReuseIdentifier: "friendsCell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.vkUser.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        self.vkUser[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendsTableViewCell
        cell.alias?.text = self.vkUser[indexPath.section][indexPath.row].id
        cell.fullName?.text = self.vkUser[indexPath.section][indexPath.row].fullName
        cell.avatar.image = self.vkUser[indexPath.section][indexPath.row].image
        cell.avatar.layer.cornerRadius = cell.avatar.frame.size.width / 2
        cell.avatar.clipsToBounds = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "profileFriend") as! ProfileCollectionViewController
        vc.title = vkUser[indexPath.section][indexPath.row].id
        vc.photo = vkUser[indexPath.section][indexPath.row].photo
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.vkUser[section][0].id
    }
    /*
    // Override to support con4ditional editing of the table view.
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
