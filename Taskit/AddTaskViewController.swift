//
//  AddTaskViewController.swift
//  Taskit
//
//  Created by Nicholai de Guzman on 1/19/15.
//  Copyright (c) 2015 Nicholai de Guzman. All rights reserved.
//

import UIKit
import CoreData

protocol AddTaskViewControllerDelegate {
    func addTask(message: String)
    func addTaskCanceled(message: String)
}

class AddTaskViewController: UIViewController {

    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var delegate:AddTaskViewControllerDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //we are not inside navigationController because we used modal
    @IBAction func cancelButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTaskCanceled("Task was not added")
    }

    @IBAction func addTaskButtonTapped(sender: UIButton) {
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let managedObjectContext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == true {
            task.task = taskTextField.text.capitalizedString
        }
        else {
            task.task = taskTextField.text
        }
        
        task.subtask = subtaskTextField.text
        task.date = dueDatePicker.date
        
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) == true {
            task.completed = true
        }
        else {
            task.completed = false
        }
        
        //saves changes to task above; any changes below this call are will not be saved
        appDelegate.saveContext()
        
        //get an aray of TaskModels
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        
        //& is optimizaition, write to address location
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        }
       
        //dismiss first before showing the alert
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTask("task added")
       
        
        
    }
    
}
