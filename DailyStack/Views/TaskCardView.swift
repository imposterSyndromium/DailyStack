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
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Double = 0.0
    @State private var vertical3DRotation: Double = 0.0
    @State private var horizontal3DRotation: Double = 0.0
    
    var body: some View {
        ZStack {
            // Card background
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 5, x: 2, y: 4)
            
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
        .padding()
        // Apply all transformations to the entire ZStack
        .offset(offset)
        .scaleEffect(getScaleAmount())
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
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        //Use absolute values to determine which dimension is dominant (positive or negative are irrelevant)
                        if abs(offset.width) > abs(offset.height) {
                            
                            if offset.width > 200 {
                                self.offset.width = 500
                            } else if offset.width < -200 {
                                self.offset.width = -500
                            } else {
                                self.offset = .zero
                            }
                            
                        } else if abs(offset.height) > abs(offset.width) {
                            
                            if offset.height > 200 {
                                self.offset.height = 500
                            } else if offset.height < -200 {
                                self.offset.height = -500
                            } else {
                                self.offset = .zero
                            }
                            
                        } else {
                            self.offset = .zero
                        }
                    }
                }
        )
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
        return 1.0 - min(percentage, 0.5) * 0.5
    }
    
    
    func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 10
        return percentageAsDouble * maxAngle
    }
    
    
    func getVertical3DRotationAmount() -> Double {
        let maxHeight = UIScreen.main.bounds.height / 2
        let currentAmount = offset.height
        let percentage = currentAmount / maxHeight
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 30 // Maximum tilt angle
        
        return percentageAsDouble * maxAngle
    }
    
    
    func getHorizontal3DRotationAmount() -> Double {
        let maxWidth = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = currentAmount / maxWidth
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 50 // Maximum Y-axis rotation angle
        
        return -percentageAsDouble * maxAngle // Negative for natural feel
    }
}

#Preview {
    TaskCardView(task: Task.sampleTasks[0])
}
