//
//  ExitView.swift
//  LoginPage
//
//  Created by Daniil Chemaev on 21.04.2023.
//

import SwiftUI

struct ExitView: View {
    let username: String

    @State var showLoginPage: Bool = false

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("Hello, \(username)")
            Button {
                showLoginPage.toggle()
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
            .fullScreenCover(isPresented: $showLoginPage) {
            LoginView()
        }
    }
}
