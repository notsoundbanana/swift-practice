//
//  LoginView.swift
//  LoginPage
//
//  Created by Daniil Chemaev on 03.04.2023.
//

import SwiftUI

class NavigationObject: ObservableObject {
    @Published
    var path: NavigationPath = .init()
}

struct LoginView: View {

    @State var username: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false

    @State var showContent: Bool = false
    @State var showFail: Bool = false

    @ObservedObject
    var navigationObject: NavigationObject = .init()

    var body: some View {
        NavigationStack(path: $navigationObject.path) {
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
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(.gray)
                        .cornerRadius(20)
                        .padding()
                }
            }
        }
        .fullScreenCover(isPresented: $showContent) {
            TabBarView(username: username)
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
            showContent.toggle()
        } else {
            showFail.toggle()
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
