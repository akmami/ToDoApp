//
//  TaskVDMConverters.swift
//  ToDoApp
//
//  Created by Mine Rala on 4.08.2021.
//

import Foundation

class TaskVDMConverter {
    
    static func taskViewDataModels(from toDoItems: [ToDoItem]) -> [TaskListVDM] {
        return toDoItems.compactMap { TaskVDMConverter.taskViewDataModel(toDoItem: $0) }
    }
    
    static func taskViewDataModel(toDoItem: ToDoItem) -> TaskListVDM? {
        guard let taskName = toDoItem.taskName, let description = toDoItem.taskDescription, let category = toDoItem.taskCategory else { return nil }
  
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: toDoItem.taskDate!)
        let minute = calendar.component(.minute, from: toDoItem.taskDate!)
        var dayAndNight : String = ""

        var day: String = ""
        if calendar.isDateInToday(toDoItem.taskDate!) {
            day = "Today"
        }
        else if calendar.isDateInYesterday(toDoItem.taskDate!) {
            day = "Yesterday"
        }
        else if calendar.isDateInTomorrow(toDoItem.taskDate!){
            day = "Tomorrow"
        }
        else {
            let components = calendar.dateComponents([.year, .month, .day], from: toDoItem.taskDate!)
            let monthName = DateFormatter().monthSymbols[components.month!-1]
            day = String(format: "%02d %@ %04d", components.day!, monthName, components.year!)
        }
        
        if hour == 0{
            hour = 12
            dayAndNight = "AM"
        }
        else if(hour > 12) {
            hour = hour-12
            dayAndNight = "PM"
        }
        else if hour == 12 {
            dayAndNight = "PM"
        }
        else {
            dayAndNight = "AM"
        }
        
        
        let dateHourAndMinute = String(format: "%02d:%02d", hour, minute)
        
        let taskId = "\(toDoItem.taskId!)"
        let isTaskCompleted = toDoItem.isTaskCompleted
        
        return TaskListVDM(taskName: taskName, taskCategory: category, dateHourAndMinute: dateHourAndMinute, datePeriod: dayAndNight, taskId: taskId, isTaskCompleted: isTaskCompleted,day: day)
    }
    
    static func detailTaskViewModel(toDoItem: ToDoItem) -> TaskDetailVDM? {
        guard let taskName = toDoItem.taskName else{
            return nil
        }
        let taskDescription = "\(toDoItem.taskDescription)"
        let taskDate = "\(toDoItem.taskDate?.description)"
        let taskId = "\(toDoItem.taskId)"
        let isTaskCompleted = toDoItem.isTaskCompleted
        return TaskDetailVDM(taskName: taskName, taskDescription: taskDescription, taskDate: taskDate, taskId: taskId, isTaskCompleted: isTaskCompleted)
    }
    
    static func editTaskViewModel(toDoItem: ToDoItem) -> TaskEditVDM? {
        guard let taskName = toDoItem.taskName else {
            return nil
        }
        let taskDescription = "\(toDoItem.taskDescription)"
        let taskDate = "\(toDoItem.taskDate?.description)"
        let notificationDate = "\(toDoItem.notificationDate?.description)"
        let taskId = "\(toDoItem.taskId)"
        
        return TaskEditVDM(taskName: taskName, taskDescription: taskDescription, taskDate: taskDate, notificationDate: notificationDate, taskId: taskId)
    }
}
