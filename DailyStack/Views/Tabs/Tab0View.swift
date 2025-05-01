//
//  Tab0View.swift
//  DailyStack
//
//  Created by Robin O'Brien on 2025-05-01.
//

import SwiftUI

struct Tab0View: View {
    var body: some View {
        VStack {
            TaskCardView(task: Task.sampleTasks[0])
                
        }
    }
}

#Preview {
    Tab0View()
}
