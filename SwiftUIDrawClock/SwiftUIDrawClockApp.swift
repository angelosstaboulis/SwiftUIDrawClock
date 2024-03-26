//
//  SwiftUIDrawClockApp.swift
//  SwiftUIDrawClock
//
//  Created by Angelos Staboulis on 26/3/24.
//

import SwiftUI

@main
struct SwiftUIDrawClockApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(hourRadians: 0.0, minuteRadians: 0.0, secondsRadians: 0.0, hour: 0, minute: 0, second: 0)
        }
    }
}
