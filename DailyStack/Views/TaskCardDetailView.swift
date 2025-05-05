//
//  Card.swift
//  DailyStack
//
//  Created by Robin O'Brien on 2025-05-05.
//

import SwiftUI

struct TaskCardDetailView: View {
    @Binding var offset: CGSize
    
    var body: some View {
        ZStack {
            // Card background
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 25, x: 2, y: 1)
            
            // Card content
            VStack {
                Spacer()
                
                Text("x Axis: \(offset.width, specifier: "%.2f")")
                    .padding(.bottom, 5)
                Text("y Axis: \(offset.height, specifier: "%.2f")")
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    var offset: CGSize
    
    TaskCardDetailView(offset: .constant(.zero))
        
}
