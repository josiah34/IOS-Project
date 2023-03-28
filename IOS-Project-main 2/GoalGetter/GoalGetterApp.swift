//
//  GoalGetterApp.swift
//  GoalGetter
//
//  Created by mac on 2023-03-22.
//

import SwiftUI

@main
struct GoalGetterApp: App {
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .environmentObject(listViewModel)
          
        }
    }
}
