//
//  ContentView.swift
//  LoginPage
//
//  Created by Daniil Chemaev on 03.04.2023.
//

import SwiftUI

struct ContentView: View {

    @State var username: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false

    @State var showSuccess: Bool = false
    @State var showFail: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Spacer()

            TextField(
                "Username",
                text: $username
            )
                .padding(10)
                .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 2)
            }
                .autocorrectionDisabled()
                .keyboardType(.asciiCapable)
                .textInputAutocapitalization(.never)
                .padding(.horizontal)

            HStack {
                Group {
                    if showPassword {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                }
                .autocorrectionDisabled()
                .keyboardType(.asciiCapable)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray, lineWidth: 2)
                }
                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye.slash" : "eye").foregroundColor(.gray)
                }
            }.padding(.horizontal)
            Spacer()

            Button {
                authenticateUser(username: username, password: password)
            } label: {
                Text("Sign In")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(.gray)
                .cornerRadius(20)
                .padding()
        }
            .alert("You are successfully logged in", isPresented: $showSuccess) {
            Button("OK") { }
        }
            .alert("Incorrect login or password", isPresented: $showFail) {
            Button("Clear") {
                username = ""
                password = ""
            }
            Button("Clear Username") {
                username = ""
            }
            Button("Clear Password") {
                password = ""
            }
        }
    }

    func authenticateUser(username: String, password: String) {
        if username == "admin" && password == "admin" {
            showSuccess = true
        } else {
            showFail = true
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
