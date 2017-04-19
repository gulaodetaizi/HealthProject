//
//  BLCreateAccountTableViewController.swift
//  Bodylogical
//
//  Created by appledev096 on 17/3/17.
//  Copyright © 2017年 Bodylogical. All rights reserved.
//

import UIKit

class BLCreateAccountTableViewController: UITableViewController, UITextFieldDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Create Account"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.done , target: self, action: #selector(backAction))
        configureTableView()
        self.navigationController?.isNavigationBarHidden = false
        
        print("Started LPHTTP server on port 37265")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
    }
    func configureTableView() {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.estimatedRowHeight = 44
        registerCells()
    }
    
    func registerCells() {
        tableView.registerNibWithCell(BLLogoCell.self)
        tableView.registerNibWithCell(BLInputInfoCell.self)
        tableView.registerNibWithCell(BLCreateAccountButtonCell.self)
    }
    
    func backAction() {
        self.navigationController?.isNavigationBarHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - TextField delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.placeholder != nil {
            textField.resignFirstResponder()
            switch textField.placeholder! {
            case "Email address":
                let passwordCell = self.tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! BLInputInfoCell
                passwordCell.inputTextField.becomeFirstResponder()
            case "Enter password":
                let passwordCell = self.tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! BLInputInfoCell
                passwordCell.inputTextField.becomeFirstResponder()
            case "Re-enter password":
                let passwordCell = self.tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! BLInputInfoCell
                passwordCell.inputTextField.becomeFirstResponder()
            default:
                break
            }
        }
        return true
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueCell(BLLogoCell.self)
            return cell
        case 1:
            let cell = tableView.dequeueCell(BLInputInfoCell.self)
            cell.inputTextField.placeholder = "Email address"
            cell.inputTextField.delegate = self
            cell.inputTextField.returnKeyType = .next
            return cell
        case 2:
            let cell = tableView.dequeueCell(BLInputInfoCell.self)
            cell.inputTextField.placeholder = "Enter password"
            cell.inputTextField.delegate = self
            cell.inputTextField.returnKeyType = .next
            return cell
        case 3:
            let cell = tableView.dequeueCell(BLInputInfoCell.self)
            cell.inputTextField.placeholder = "Re-enter password"
            cell.inputTextField.delegate = self
            cell.inputTextField.returnKeyType = .next
            return cell
        case 4:
            let cell = tableView.dequeueCell(BLInputInfoCell.self)
            cell.inputTextField.placeholder = "Zip code"
            cell.inputTextField.delegate = self
            cell.inputTextField.returnKeyType = .default
            return cell
        case 5:
            let cell = tableView.dequeueCell(BLCreateAccountButtonCell.self)
            cell.CreateAccountBtn.addTarget(self, action: #selector(tapOnCreateAccountButton), for: .touchUpInside)
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tapOnCreateAccountButton() {
        let connectVC = BLConnectAppleViewController(nibName: "BLConnectAppleViewController", bundle: nil)
        self.navigationController?.pushViewController(connectVC, animated: true)
    
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
