//
//  ContentView.swift
//  LoginPage
//
//  Created by Daniil Chemaev on 20.04.2023.
//

import SwiftUI

struct HomeView: View {

    @ObservedObject
    var navigationObject: NavigationObject = .init()

    @State var showAnimalImagesPage: Bool = false

    let username: String

    var body: some View {
        NavigationStack(path: $navigationObject.path) {
            VStack(alignment: .center, spacing: 15) {
                Text("Hello, \(username)")

                Button {
                    navigationObject.path.append(CatalogPage(id: 0))
                } label: {
                    Text("Browse catalog")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(.gray)
                        .cornerRadius(20)
                        .padding(.horizontal)
                }

                Button {
                    showAnimalImagesPage.toggle()
                } label: {
                    Text("Animal images")
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
                .sheet(isPresented: $showAnimalImagesPage) {
                Animal()
            }
                .navigationDestination(for: CatalogPage.self) { page in
                CatalogView(navigationObject: navigationObject, pageNumber: page.id + 1)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(username: "{Username}")
    }
}
