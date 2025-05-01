//
//  CardModel.swift
//  DailyStack
//
//  Created by Robin O'Brien on 2025-05-01.
//

import Foundation

struct Task: Identifiable, Codable {
    let id: String
    let taskName: String
    let taskDescription: String
    let taskDate: Date
    let isComplete: Bool
    
    init(id: String = UUID().uuidString, taskName: String, taskDescription: String, taskDate: Date = Date(), isComplete: Bool = false) {
        self.id = id
        self.taskName = taskName
        self.taskDescription = taskDescription
        self.taskDate = taskDate
        self.isComplete = isComplete
    }
}


extension Task {
    
    static let sampleTasks: [Task] = [
        Task(taskName: "Sample Task 1", taskDescription: "Description for Task 1"),
        Task(taskName: "Sample Task 2", taskDescription: "Description for Task 2"),
        Task(taskName: "Sample Task 3", taskDescription: "Description for Task 3"),
        Task(taskName: "Sample Task 4", taskDescription: "Description for Task 4"),
        Task(taskName: "Sample Task 5", taskDescription: "Description for Task 5")
    ]
    
}
