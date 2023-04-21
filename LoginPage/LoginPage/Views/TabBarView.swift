//
//  TabBarView.swift
//  LoginPage
//
//  Created by Daniil Chemaev on 21.04.2023.
//

import SwiftUI

struct TabBarView: View {
    let username: String

    @Binding var showTabBarPage: Bool

    var body: some View {
        TabView {
            HomeView(username: username).tabItem {
                Label("Home", systemImage: "house")
            }

            ExitView(username: username, showTabBarPage: $showTabBarPage).tabItem {
                Label("Exit", systemImage: "person")
            }
        }
    }
}
