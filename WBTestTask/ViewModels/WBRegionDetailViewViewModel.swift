//
//  WBRegionDetailViewViewModel.swift
//  WBTestTask
//
//  Created by Artur Imanbaev on 01.09.2023.
//

import Foundation

final class WBRegionDetailViewViewModel{
    private let region: WBBrandModel
    
    init(region: WBBrandModel) {
        self.region = region
    }
    public var title: String {
        region.title.uppercased()
    }
}
