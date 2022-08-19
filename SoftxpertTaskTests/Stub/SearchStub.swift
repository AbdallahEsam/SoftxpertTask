//
//  SearchStub.swift
//  SoftxpertTaskTests
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//


import Foundation
@testable import SoftxpertTask

class SearchStub {
    static func createSearch() -> SearchRecipe {
        return .init(q: "s", from: 0, to: 10, more: false, count: 10, hits: [])
    }
}
