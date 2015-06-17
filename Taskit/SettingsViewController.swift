//
//  SettingsViewController.swift
//  Taskit
//
//  Created by Nicholai de Guzman on 6/17/15.
//  Copyright (c) 2015 Nicholai de Guzman. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //sections might be better tah mutliple table views
    @IBOutlet weak var capitalizeTableView: UITableView!
    @IBOutlet weak var completeNewTodoTableView: UITableView!
    
    @IBOutlet weak var verLabel: UILabel!
    
    let kVersionNumber = "1.0"
    let kShouldCapitalizeTaskKey = "shouldCapitalizeTask"
    let kShouldCompleteNewTodoKey = "completeNewTodo"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.capitalizeTableView.delegate = self
        self.capitalizeTableView.dataSource = self
        self.capitalizeTableView.scrollEnabled = false
        self.completeNewTodoTableView.delegate = self
        self.completeNewTodoTableView.dataSource = self
        self.completeNewTodoTableView.scrollEnabled = false
        self.title = "Settings"
        self.versionLabel.text = kVersionNumber
        
        //overrding functionality
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("doneBarButtonItemPressed:"))
        self.navigationItem.leftBarButtonItem = doneButton
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == self.capitalizeTableView {
            var capitalizeCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("capitali        zeCell") as! UITableViewCell
            if indexPath.row == 0 {
                capitalizeCell.textLabel?.text = "No do not Capitalize"
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == false {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            else {
                capitalizeCell.textLabel?.text = "Yes Capitalize!"
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == true {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            return capitalizeCell
        }
        
        else {
            var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("completeNewTodoCell") as! UITableViewCell
            if indexPath.row == 0 {
                cell.textLabel?.text = "Do not complete Task"
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) == false {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            else {
                cell.textLabel?.text = "Complete Task"
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) == true{
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            return cell
        }
    }
    
    func doneBarButtonItemPressed (barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    

}
