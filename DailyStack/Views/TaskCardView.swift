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
        TaskCardDetailView(offset: $offset)
            .padding()        
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
                        // Determine which action to take based on drag distance
                        if abs(offset.width) > 200 || abs(offset.height) > 200 {
                            // Card was dragged far enough to dismiss
                            performDismissAnimation()
                        } else {
                            // Card wasn't dragged far enough, reset with smooth animation
                            resetCardPosition()
                        }
                        
                        // For debugging choppy animations, you can print offset values
                        // print("Ending drag with offset: \(offset)")
                    }
            )
    }
    
    // MARK: - Animation Functions
    
    /// Smoothly resets the card position to the center with a fluid spring animation
    private func resetCardPosition() {
        // Use a single, smoother animation with carefully tuned spring parameters
        withAnimation(.spring(
            response: 0.5,        // Slightly slower response for smoother motion
            dampingFraction: 0.65, // Balanced damping for a natural feel
            blendDuration: 0.3    // Helps blend animations more smoothly
        )) {
            self.offset = .zero
        }
    }
    
    /// Animates the card off screen when dismissed
    private func performDismissAnimation() {
        withAnimation(.spring(
            response: 0.5,
            dampingFraction: 0.7,
            blendDuration: 0.2
        )) {
            // Determine which direction to animate based on which dimension has larger offset
            if abs(offset.width) > abs(offset.height) {
                // Horizontal swipe dominates
                let screenWidth = UIScreen.main.bounds.width
                self.offset.width = offset.width > 0 ? screenWidth : -screenWidth
                // Keep vertical position consistent for a smoother animation
                self.offset.height = self.offset.height
            } else {
                // Vertical swipe dominates
                let screenHeight = UIScreen.main.bounds.height
                self.offset.height = offset.height > 0 ? screenHeight : -screenHeight
                // Keep horizontal position consistent for a smoother animation
                self.offset.width = self.offset.width
            }
        }
        
        // Here you could add code to actually remove the card or perform other actions
        // after the dismiss animation completes
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
