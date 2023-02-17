//
//  CatalogService.swift
//  OnlineShop
//
//  Created by Daniil Chemaev on 17.02.2023.
//

import Foundation

protocol CatalogService {

    func obtainData() throws -> [Product]

}
