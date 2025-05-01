//
//  CardView.swift
//  DailyStack
//
//  Created by Robin O'Brien on 2025-05-01.
//

import SwiftUI

struct TaskCardView: View {
    var task: Task
    @State private var translation: CGSize = .zero
    
    var body: some View {
        GeometryReader { geo in
            // the card background
            ZStack {
                Color.secondary
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width - 32)
                    .clipped()
                    .cornerRadius(15)
                    .modifier(ThemeShadow())
                    .ignoresSafeArea()
                
                // on the card
                VStack {
                    
                    // <<  and  >>  indicators
                    HStack{
                        if translation.width > 0 {
                            Text(">>>")
                                .tracking(3)
                                .font(.title)
                                .padding(.horizontal)
                                .foregroundColor(Color.theme.accent)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.theme.accent, lineWidth: 3)
                                )
                                .rotationEffect(.degrees(-20))
                        } else if translation.width < 0 {
                            Text("<<<")
                                .tracking(3)
                                .font(.title)
                                .padding(.horizontal)
                                .foregroundColor(Color.theme.accent)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.theme.accent, lineWidth: 3)
                                )
                                .rotationEffect(.degrees(20))
                        }

                    }
                    .padding(.horizontal, 25)
                    Spacer()
                    
                    // Add card text here
                    
                }
                .padding(.top, 40)
                
                
            }
            .ignoresSafeArea()
            .offset(x: self.translation.width, y: 0)
            .rotationEffect(.degrees(Double(self.translation.width / geo.size.width) * 25), anchor: .bottom)
            .rotationEffect(.degrees(Double(self.translation.height / geo.size.height) * 25), anchor: .leading)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.translation = value.translation
                    }
                    .onEnded { value in
                        withAnimation(.easeInOut) {
                            // if the card has moved left or right more than 200 points, move it off the screen
                            if translation.width > 200 {
                                self.translation.width = 500
                            } else if translation.width < -200 {
                                self.translation.width = -500
                            } else {
                                self.translation = .zero
                            }
                        }
                    }
            )
            .cornerRadius(15)
            .padding()
        }
    }
}

#Preview {
    TaskCardView(task: Task.sampleTasks[0])
}
