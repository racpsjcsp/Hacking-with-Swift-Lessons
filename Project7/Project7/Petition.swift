//
//  Petition.swift
//  Project7
//
//  Created by Rafael Plinio on 25/06/20.
//  Copyright © 2020 Rafael Plinio. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
