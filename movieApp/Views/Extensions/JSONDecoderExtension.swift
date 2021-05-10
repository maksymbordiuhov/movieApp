//
//  JSONDecoderExtension.swift
//  movieApp
//
//  Created by Maksym Bordyugov on 08.05.2021.
//  Copyright © 2021 Maksym Bordyugov. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    func setCustomDateDecodingStrategy() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.dateDecodingStrategy = .formatted(formatter)
    }
}
