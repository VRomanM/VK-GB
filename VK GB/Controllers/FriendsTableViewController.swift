//
//  FriendsTableViewController.swift
//  VK GB
//
//  Created by Роман Вертячих on 03.05.2022.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    @IBOutlet var friendsTableView: UITableView!
    
    var vkUser = [UserVK](){
        didSet {
            sortedUsers = sortUsers(vkUsers: vkUser)
            tableView.reloadData()
        }
    }
        
    var sortedUsers = [Character: [UserVK]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiVK().getFriendList { [weak self] usersArray in
            self?.vkUser = usersArray
        }
        friendsTableView.register(UINib(nibName: "FriendsTableViewCell", bundle: nil), forCellReuseIdentifier: "friendsCell")
        self.sortedUsers = sortUsers(vkUsers: vkUser)
        tableView.reloadData()
    }
    
    private func sortUsers(vkUsers: [UserVK]) -> [Character: [UserVK]] {
        var sortedUser = [Character: [UserVK]]()
        
        vkUsers.forEach{vkUser in
            guard let firstChar = vkUser.firstName.first else {return}
            if var arrayUsers = sortedUser[firstChar] {
                arrayUsers.append(vkUser)
                sortedUser[firstChar] = arrayUsers
            } else {
                sortedUser[firstChar] = [vkUser]
            }
        }
        return sortedUser
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sortedUsers.keys.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let keySorted = sortedUsers.keys.sorted()
        let countUsers = sortedUsers[keySorted[section]]?.count ?? 0
        
        return countUsers
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as? FriendsTableViewCell else {
            preconditionFailure("Error")
        }
        let firstChar = self.sortedUsers.keys.sorted()[indexPath.section]
        let arrayUsers = sortedUsers[firstChar]!
        let vkUser = arrayUsers[indexPath.row]
        
        cell.alias?.text = vkUser.firstName
        cell.fullName?.text = vkUser.fullName
        cell.avatar.image = vkUser.image
        cell.avatar.layer.cornerRadius = cell.avatar.frame.size.width / 2
        cell.avatar.clipsToBounds = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FriendsTableViewCell else {
            preconditionFailure("Error")
        }
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            //            cell.containerAvatar.layer.opacity = 0
            cell.containerAvatar.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            cell.containerAvatar.transform = .identity
        } completion: { _ in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profileFriend") as! ProfileCollectionViewController
            
            let keySorted = self.sortedUsers.keys.sorted()
            guard let vkUsers = self.sortedUsers[keySorted[indexPath.section]] else { return }
            
            vc.title = vkUsers[indexPath.row].firstName
            vc.photo = vkUsers[indexPath.row].photo
            vc.transitioningDelegate = vc
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(sortedUsers.keys.sorted()[section])
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

