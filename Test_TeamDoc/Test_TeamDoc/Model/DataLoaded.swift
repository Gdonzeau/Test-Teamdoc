//
//  DataLoaded.swift
//  Test_TeamDoc
//
//  Created by Guillaume Donzeau on 03/06/2022.
//

import Foundation

struct DataLoaded {
    static var allData: GeneralBase = Bundle.main.decode("FirstFile.json")
}
