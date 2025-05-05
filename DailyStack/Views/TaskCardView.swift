//
//  CardView.swift
//  DailyStack
//
//  Created by Robin O'Brien on 2025-05-01.
//

import SwiftUI

struct TaskCardView: View {
    var task: Task
    @State private var offset: CGSize = .zero

    
    var body: some View {
        
        ZStack {
            cardBackground
            cardContent
        }
        .offset(offset)
        .scaleEffect(getScaleAmount())
        // Combined 3D rotation effects for both axes
        .rotation3DEffect(
            .degrees(getVertical3DRotationAmount()),
            axis: (x: -1.0, y: 0.0, z: 0.0),
            anchor: .center,
            anchorZ: 0.0,
            perspective: 0.5
        )
        .rotation3DEffect(
            .degrees(getHorizontal3DRotationAmount()),
            axis: (x: 0.0, y: -1.0, z: 0.0),
            anchor: .center,
            anchorZ: 0.0,
            perspective: 0.5
        )
        .rotationEffect(.degrees(getRotationAmount()), anchor: .bottom)
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.offset = value.translation
                }
                .onEnded { value in
                    // Use absolute values to determine which dimension is dominant (positive or negative are irrelevant)
//                    if abs(offset.width) > abs(offset.height) {
//                        
//                        if offset.width > 200 {
//                            self.offset.width = 500
//                        } else if offset.width < -200 {
//                            self.offset.width = -500
//                        } else {
//                            self.offset = .zero
//                        }
//                        
//                    } else if abs(offset.height) > abs(offset.width) {
//                        
//                        if offset.height > 200 {
//                            self.offset.height = 500
//                        } else if offset.height < -200 {
//                            self.offset.height = -500
//                        } else {
//                            self.offset = .zero
//                        }
//                        
//                    } else {
//                        self.offset = .zero
//                    }
                    withAnimation(.spring()) {
                        self.offset = .zero
                    }
                }
        )
        
    }
    
    

}

#Preview {
    TaskCardView(task: Task.sampleTasks[0])
}


// MARK: - Extensions
extension TaskCardView {
    
    // MARK: - View Components
    
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(.white)
            .shadow(color: .gray, radius: 50, x: 5, y: 5)
            .padding()
    }
    
    
    private var cardContent: some View {
        VStack {
            Spacer()
            
            Text("x Axis: \(offset.width)")
            Text("y Axis: \(offset.height)")
            
            Spacer()
        }
    }
    
    // MARK: - Helper Functions
    
    ///  Calculates the scale amount based on the current offset.  Works for a vertical or horizontal drag.
    ///
    ///  Used a maximum of half the screen width or height to determine the scale.  Returns a scale factor of 1.0 when not dragging.  Reduces the scale to 50% at most.
    ///
    /// - Returns:  A CGFloat representing the scale factor.
    func getScaleAmount() -> CGFloat {
        let maxWidth = UIScreen.main.bounds.width / 2
        let maxHeight = UIScreen.main.bounds.height / 2
        
        // Get absolute values of both offsets
        let currentWidthAmount = abs(offset.width)
        let currentHeightAmount = abs(offset.height)
        
        // Use the larger of the two offsets for the calculation
        let currentAmount = max(currentWidthAmount, currentHeightAmount)
        
        // Calculate percentage based on the appropriate maximum
        let percentage: CGFloat
        if currentWidthAmount > currentHeightAmount {
            percentage = currentAmount / maxWidth
        } else {
            percentage = currentAmount / maxHeight
        }
        
        // return scaled amount (Scale down to 50% at most)
        //return 1.0 - min(percentage, 0.5) * 0.5
        
    }
    
    func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 10
        return percentageAsDouble * maxAngle
    }
    
    // Renamed from get3DRotationAmount to better describe its purpose
    func getVertical3DRotationAmount() -> Double {
        let maxHeight = UIScreen.main.bounds.height / 2
        let currentAmount = offset.height
        let percentage = currentAmount / maxHeight
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 30 // Maximum tilt angle
        
        return percentageAsDouble * maxAngle
    }
    
    // New function for horizontal 3D rotation (Y-axis)
    func getHorizontal3DRotationAmount() -> Double {
        let maxWidth = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = currentAmount / maxWidth
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 50 // Maximum Y-axis rotation angle
        
        return -percentageAsDouble * maxAngle // Negative for natural feel
    }
    

}

