//
//  TaskDetailViewController.swift
//  Taskit
//
//  Created by Nicholai de Guzman on 1/19/15.
//  Copyright (c) 2015 Nicholai de Guzman. All rights reserved.
//

import UIKit

//@objc is used so we can create optional (not mandatory) functions for our delegate
@objc protocol TaskDetailViewControllerDelegate {
    optional func taskDetailEdited()
}

class TaskDetailViewController: UIViewController {

    var detailTaskModel: TaskModel!
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var delegate: TaskDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        
        self.taskTextField.text = detailTaskModel.task
        self.subtaskTextField.text = detailTaskModel.subtask
        self.dueDatePicker.date = detailTaskModel.date
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //before adding the AddTaskViewContr, we were given this action for "free", but adding the segue modified the behaviour
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        detailTaskModel.task = taskTextField.text
        detailTaskModel.subtask = subtaskTextField.text
        detailTaskModel.date   = dueDatePicker.date
        detailTaskModel.completed = detailTaskModel.completed
        
        appDelegate.saveContext()
        
        self.navigationController?.popViewControllerAnimated(true)
        delegate?.taskDetailEdited!()
        
        
    }
    

}
