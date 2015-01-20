//
//  ViewController.swift
//  Taskit
//
//  Created by Nicholai de Guzman on 1/17/15.
//  Copyright (c) 2015 Nicholai de Guzman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var taskArray:[Dictionary<String,String>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let task1:Dictionary<String, String> = ["task": "Study French", "subtask": "Verbs", "date": "01/14/2014"]
        let task2:Dictionary<String, String> = ["task": "Eat Dinner", "subtask": "Burgers", "date": "01/14/2014"]
        let task3:Dictionary<String, String> = ["task": "Gym", "subtask": "Leg day", "date": "01/14/2014"]
        taskArray = [task1, task2, task3]
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskArray.count
    }
    
    //becaise of taskArray.count, this function will be called three times
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println(indexPath.row)
        let taskDict:Dictionary = taskArray[indexPath.row]
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        cell.taskLabel.text = taskDict["task"]
        cell.descriptionLabel.text = taskDict["subtask"]
        cell.dateLabel.text = taskDict["date"]
        return cell
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
    }
    
    //added by Nicholai based on comments in lecture
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }


}

