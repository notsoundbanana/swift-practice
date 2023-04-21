//
//  TabBarView.swift
//  LoginPage
//
//  Created by Daniil Chemaev on 21.04.2023.
//

import SwiftUI

struct TabBarView: View {
    let username: String

    var body: some View {
        TabView {
            HomeView(username: username).tabItem {
                Label("Home", systemImage: "house")
            }

            ExitView(username: username).tabItem {
                Label("Exit", systemImage: "person")
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(username: "{Username}")
    }
}
