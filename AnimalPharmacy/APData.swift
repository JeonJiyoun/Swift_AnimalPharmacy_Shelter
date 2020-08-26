//
//  AnimalPharmacy.swift
//  AnimalPharmacy
//
//  Created by 60080254 on 2020/08/21.
//  Copyright © 2020 60080254. All rights reserved.
//

import Foundation
class APData {
    let name: String
    let sigunName: String
    let location: String
    let latitude: String
    let longtude: String
    let telNo: String
    
    init(name: String, sigunName: String, location: String, latitude: String, longtude: String, telNo: String) {
        self.name = name
        self.sigunName = sigunName
        self.location = location
        self.latitude = latitude
        self.longtude = longtude
        self.telNo = telNo
    }
}
