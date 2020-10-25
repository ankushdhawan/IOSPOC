//
//  CountryModel.swift
//  POC
//
//  Created by Ankush Dhawan on 10/24/20.
//  Copyright © 2019 Reliance. All rights reserved.
//

import Foundation
struct CountryModel: Codable {
    var title:String?
    var rows:[CountryDetailModel] = [CountryDetailModel]()
    
}
struct CountryDetailModel: Codable {
    var title:String?
    var description:String?
    var imageHref:String?
    
}

