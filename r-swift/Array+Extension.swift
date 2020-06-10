//
//  Array+Extension.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-09.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import Foundation

extension Array {
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
