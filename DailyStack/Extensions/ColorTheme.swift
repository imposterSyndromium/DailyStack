//
//  Color.swift
//
//  Created by Robin O'Brien on 2025-03-01.
//

import Foundation
import SwiftUI



extension Color {
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}



struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let greenColor = Color("greenColor")
    let redColor = Color("redColor")
    let purpleColor = Color("purpleColor")
    let secondaryText = Color("SecondaryTextColor")
}

struct LaunchTheme {
    let background = Color("LaunchBackgroundColor")
    let accent = Color("LaunchAccentColor")
}
