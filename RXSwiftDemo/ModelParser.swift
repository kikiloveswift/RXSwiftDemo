//
//  ModelParser.swift
//  RXSwiftDemo
//
//  Created by kong on 2019/5/7.
//  Copyright © 2019 konglee. All rights reserved.
//

import UIKit

import SwiftyJSON

final class ModelParser {
    func parser(_ data: Data) -> JSON? {
        guard let json = try? JSONSerialization.jsonObject(with:data, options: .mutableContainers) as? JSON else {
            return nil
        }
        return json
    }
}
