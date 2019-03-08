//
//  DataPersistenceManager.swift
//  SoloProject
//
//  Created by Ramu on 3/7/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import Foundation

final class DataPersistenceManager {
    private init() {}
    
    static func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    static func filenameFromDoucmentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
    
}
