//
//  TaskModel.swift
//  Taskit
//
//  Created by Nicholai de Guzman on 1/19/15.
//  Copyright (c) 2015 Nicholai de Guzman. All rights reserved.
//

import Foundation

struct TaskModel {
    var task:String
    var subTask:String
    var date:NSDate //apple hasn't created a good way to create nsdate in swift
    var completed:Bool
}