//
//  ViewController.swift
//  Taskit
//
//  Created by Nicholai de Guzman on 1/17/15.
//  Copyright (c) 2015 Nicholai de Guzman. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, TaskDetailViewControllerDelegate, AddTaskViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext  = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    //var taskArray:[TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        
        fetchedResultsController = getFetchedResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)

    }
        
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTaskDetail" {
            let detailVC: TaskDetailViewController = segue.destinationViewController as! TaskDetailViewController
            
            //indexPath is both a section and row
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = fetchedResultsController.objectAtIndexPath(indexPath!) as! TaskModel
            detailVC.detailTaskModel = thisTask
            detailVC.delegate = self //TaskDetailViewControllerDelegate
         
            //we shouldn't be updating UI elements here: technically, they have not been instantiated
        }
        
        else if segue.identifier == "showTaskAdd" {
            let addTaskVC:AddTaskViewController = segue.destinationViewController as! AddTaskViewController
            addTaskVC.delegate = self
            
        }
        
    }
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    //UITableViewDataSource
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    //becaise of taskArray.count, this function will be called three times
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //passing the indexPath figures out the row and col for us
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as! TaskModel
        
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as! TaskCell
        cell.taskLabel.text = thisTask.task
        cell.descriptionLabel.text = thisTask.subtask
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
        
        if fetchedResultsController.sections?.count == 1 {
            let fetchedObjects = fetchedResultsController.fetchedObjects!
            let testTask:TaskModel = fetchedObjects[0] as! TaskModel
            if testTask.completed == true {
                return "Completed"
            }
            else {
                return "To do"
            }
        }
        
        if section == 0 {
            return "To do"
        }
        else {
            return "Completed"
        }
    }
    
    
    //swipe functionality; what to do with a swiped cell
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as! TaskModel
        
        if thisTask.completed == true {
            thisTask.completed = false
        }
        else {
            thisTask.completed = true
        }
        
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
    }
    
    
    //based on comments on background color lecture, see https://github.com/lanhamm/TaskIt2
    //was also on Updating...Autolayout lecture
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
        tableView.backgroundColor = UIColor.clearColor()
    }
    
    //we can use the function below because we conform to the NSfetchResults delegate
    //this is called automatically
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    
    //Helpers
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let completedDescriptor =  NSSortDescriptor(key: "completed", ascending: true)
        fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
        
        return fetchRequest
    }
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        var fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "completed", cacheName: nil)
        return fetchedResultsController
    }
    
    //TaskDetailViewControllerDelegate
    func taskDetailEdited() {
        //println("taskDetailEdited")
        showAlert()
        
    }
    
    //AddTaskViewControllerDelegate
    func addTaskCanceled(message: String) {
        showAlert(message: message)
    }
    func addTask(message: String) {
        showAlert(message: message)
    }
    
    func showAlert(message:String = "Congratulations") {
        var alert = UIAlertController(title: "Change Made!", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }


}

