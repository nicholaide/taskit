//
//  ViewController.swift
//  Taskit
//
//  Created by Nicholai de Guzman on 1/17/15.
//  Copyright (c) 2015 Nicholai de Guzman. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext  = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    var baseArray:[[TaskModel]] = []
    var taskArray:[TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController = getFetchedResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTaskDetail" {
            let detailVC: TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            
            //indexPath is both a section and row
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = baseArray[indexPath!.section][indexPath!.row]
            detailVC.detailTaskModel = thisTask
            detailVC.mainVC = self
            //we shouldn't be updating UI elements here: technically, they have not been instantiated
        }
        
        else if segue.identifier == "showTaskAdd" {
            let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
            addTaskVC.mainVC = self //see the var declaration in the addtaskviewcontroller
            
            
        }
        
    }
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    //UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return baseArray.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baseArray[section].count
    }
    
    //becaise of taskArray.count, this function will be called three times
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let thisTask = baseArray[indexPath.section][indexPath.row]
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        cell.taskLabel.text = thisTask.task
        cell.descriptionLabel.text = thisTask.subTask
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        return cell
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        println(indexPath.row)
        //showTaskDetail is what we named our segue
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }
    
    //added by Nicholai based on comments in lecture
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To do"
        }
        else {
            return "Completed"
        }
    }
    
    
    //swipe functionality; what to do with a swiped cell
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let thisTask = baseArray[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 {
            var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: true)
            baseArray[1].append(newTask)
        }
        else {
            var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: false)
            baseArray[0].append(newTask)
        }
        
        baseArray[indexPath.section].removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
    
    //Helpers
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }


}

