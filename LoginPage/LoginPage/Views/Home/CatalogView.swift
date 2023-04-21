//
//  CatalogPage.swift
//  LoginPage
//
//  Created by Daniil Chemaev on 21.04.2023.
//

import SwiftUI

struct CatalogPage: Identifiable, Hashable {
    var id: Int
}

struct CatalogView: View {

    @ObservedObject
    var navigationObject: NavigationObject

    @State var showCatalogPage: Bool = false

    let pageNumber: Int

    var body: some View {
        NavigationStack(path: $navigationObject.path) {
            VStack(alignment: .center, spacing: 15) {
                Text("Page number: \(pageNumber)")
                Button {
                    navigationObject.path.append(CatalogPage(id: pageNumber))
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
            }
        }
            .navigationDestination(for: CatalogPage.self) { page in
                CatalogView(navigationObject: navigationObject, pageNumber: page.id + 1)
        }
    }
}
