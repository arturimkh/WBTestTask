//
//  WBBrandModel.swift
//  WBTestTask
//
//  Created by Artur Imanbaev on 31.08.2023.
//

import Foundation

// MARK: - Brand
struct WBBrandModel: Codable {
    let brandID, title: String
    let thumbUrls: [String]
    let tagIDS: [String]
    let slug, type: String
    let viewsCount: Int

    enum CodingKeys: String, CodingKey {
        case brandID = "brandId"
        case title, thumbUrls
        case tagIDS = "tagIds"
        case slug, type, viewsCount
    }
}
