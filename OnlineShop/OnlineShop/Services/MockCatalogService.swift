//
//  MockCatalogService.swift
//  OnlineShop
//
//  Created by Daniil Chemaev on 17.02.2023.
//

import Foundation

class MockCatalogService: CatalogService {

    static let shared = MockCatalogService()

    func obtainData() throws -> [Product] {
        return [
            Product(id: 1, name: "Name 1", description: "Description 1", price: 100),
            Product(id: 2, name: "Name 2", description: "Description 2", price: 200),
            Product(id: 3, name: "Name 3", description: "Description 3", price: 300),
            Product(id: 4, name: "Name 4", description: "Description 4", price: 400),
            Product(id: 5, name: "Name 5", description: "Description 5", price: 500),
            Product(id: 6, name: "Name 6", description: "Description 6", price: 600),
            Product(id: 7, name: "Name 7", description: "Description 7", price: 700),
            Product(id: 8, name: "Name 8", description: "Description 8", price: 800),
            Product(id: 9, name: "Name 9", description: "Description 9", price: 900),
            Product(id: 10, name: "Name 10", description: "Description 10", price: 1000)
        ]
    }
}
