//
//  TaskModel.swift
//  Taskit
//
//  Created by Nicholai de Guzman on 2/15/15.
//  Copyright (c) 2015 Nicholai de Guzman. All rights reserved.
//

import Foundation
import CoreData

//in case we want to use Objective-C
@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subtask: String
    @NSManaged var task: String

}
