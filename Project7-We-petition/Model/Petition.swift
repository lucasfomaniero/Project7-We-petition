//
//  Petition.swift
//  Project7-We-petition
//
//  Created by Lucas Maniero on 21/02/22.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var issues: [Issue]
    var signatureThreshold: Int
    var signatureCount: Int
    var signaturesNeeded: Int
    var url: String
}
