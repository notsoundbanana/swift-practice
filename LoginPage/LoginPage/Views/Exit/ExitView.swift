//
//  ExitView.swift
//  LoginPage
//
//  Created by Daniil Chemaev on 21.04.2023.
//

import SwiftUI

struct ExitView: View {
    let username: String

    @Binding var showTabBarPage: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("Hello, \(username)")
            Button {
                showTabBarPage.toggle()
            } label: {
                Text("Exit")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(.gray)
                    .cornerRadius(20)
                    .padding(.horizontal)
            }
        }
    }
}
